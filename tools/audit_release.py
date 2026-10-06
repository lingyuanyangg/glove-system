#!/usr/bin/env python3
"""Offline integrity and structural audit for the documented release."""

import hashlib
import json
import re
import struct
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def processing_hash(text):
    """Ignore translated line comments and deployment-specific string values."""
    text = re.sub(r"//[^\n]*", "", text)
    for key in ("ssid", "password", "outIp"):
        text = re.sub(
            rf'(const\s+char\s*\*\s*{key}\s*=\s*)"[^"\n]*"',
            rf'\1"CONFIGURATION"',
            text,
        )
    return hashlib.sha256(re.sub(r"\s+", "", text).encode()).hexdigest()


def check_patch(patch):
    boxes = {entry["box"]["id"]: entry["box"] for entry in patch["boxes"]}
    assert len(boxes) == len(patch["boxes"]), "Duplicate object ID"
    for entry in patch.get("lines", []):
        line = entry["patchline"]
        for kind, count in (("source", "numoutlets"), ("destination", "numinlets")):
            object_id, port = line[kind]
            assert object_id in boxes, f"Missing {kind} object: {object_id}"
            assert 0 <= port < boxes[object_id][count], f"Invalid {kind} port"
    for box in boxes.values():
        if "patcher" in box:
            check_patch(box["patcher"])
    return boxes


def main():
    manifest = json.loads((ROOT / "docs/file-manifest.json").read_text())
    for record in manifest["files"]:
        path = ROOT / record["file"]
        data = path.read_bytes()
        assert len(data) == record["bytes"], f"Size mismatch: {path.name}"
        assert hashlib.sha256(data).hexdigest() == record["sha256"], (
            f"Hash mismatch: {path.name}"
        )
        if path.suffix == ".amxd":
            assert data[:4] == b"ampf" and data[24:28] == b"ptch"
            assert struct.unpack("<I", data[28:32])[0] == len(data) - 32
            patch = json.loads(data[32:].rstrip(b"\0"))
            extracted = json.loads((ROOT / record["source"]).read_text())
            assert patch == extracted, f"Extracted source mismatch: {path.name}"
            check_patch(patch["patcher"])
        elif path.suffix == ".maxpat":
            check_patch(json.loads(data)["patcher"])
    print("PASS: Original device/model/helper hashes and extracted source integrity")

    devices = ROOT / "max/devices"
    for name, rows in (("Glove_Direct_Map", 5), ("reressorMapping2", 10)):
        patch = json.loads((ROOT / f"max/source/{name}.maxpat").read_text())["patcher"]
        helpers = [
            entry["box"]
            for entry in patch["boxes"]
            if entry["box"]["maxclass"] == "bpatcher"
        ]
        assert len(helpers) == rows
        assert all(box["name"] == "unitPart.maxpat" for box in helpers)
        assert all((devices / box["name"]).is_file() for box in helpers)
    print("PASS: Five direct mapping rows and ten regression mapping rows")

    model = json.loads((devices / "gloveRegressor10.json").read_text())
    info = model["meta"]["info"]
    assert info["num_entries"] == 10
    assert info["input_dimensions"] == 5 and info["output_dimensions"] == 10
    datasets = model["data"]["datasets"]
    assert set(datasets["input"]["data"]) == set(datasets["output"]["data"])
    for name, dimensions in (("input", 5), ("output", 10)):
        dataset = datasets[name]
        assert dataset["cols"] == dimensions and len(dataset["data"]) == 10
        assert all(len(row) == dimensions for row in dataset["data"].values())
    layers = model["fits"]["input_regressor"]["layers"]
    assert [(layer["rows"], layer["cols"]) for layer in layers] == [
        (5, 3), (3, 3), (3, 10)
    ]
    assert [layer["activation"] for layer in layers] == [3, 3, 0]
    for layer in layers:
        assert len(layer["weights"]) == layer["rows"]
        assert all(len(row) == layer["cols"] for row in layer["weights"])
        assert len(layer["biases"]) == layer["cols"]
    print("PASS: Ten paired examples and 5 → 3 → 3 → 10 model structure")

    firmware = (ROOT / "arduino/glove/glove.ino").read_text()
    for key, value in (
        ("ssid", "YOUR_WIFI_SSID"),
        ("password", "YOUR_WIFI_PASSWORD"),
        ("outIp", "192.0.2.1"),
    ):
        match = re.search(rf'const char\* {key}\s*=\s*"([^"]*)"', firmware)
        assert match and match.group(1) == value, f"Non-placeholder config: {key}"
    assert processing_hash(firmware) == manifest["firmware"]["processing_sha256"]
    print("PASS: Publication placeholders and preserved firmware processing logic")


if __name__ == "__main__":
    main()
