#!/usr/bin/env python3
"""Generate the ready-to-upload D12 hardware UART variant from the shared sketch."""
from pathlib import Path

root = Path(__file__).resolve().parents[1]
source = (root / 'arduino/glove_usb_dual/glove_usb_dual.ino').read_text()
source = source.replace('#define RIGHT_USE_HARDWARE_UART 0', '#define RIGHT_USE_HARDWARE_UART 1', 1)
source = source.replace('// RIGHT: module TXD -> D11 (SoftwareSerial RX); module RXD <- D10 (optional).',
                        '// RIGHT: module TXD -> D12 (hardware RX); module RXD <- D11 (optional).', 1)
source = source.replace('// D10 cannot be SoftwareSerial RX with this board/core: it lacks the RX IRQ.',
                        '// This variant uses SCI0 on D11 TX / D12 RX, with no SoftwareSerial.', 1)
source = source.replace('// Optional RIGHT_USE_HARDWARE_UART=1: RIGHT TXD -> D12, RXD <- D11 (optional).',
                        '// Use glove_usb_dual.ino for the original D11 RX / D10 TX wiring.', 1)
folder = root / 'arduino/glove_usb_dual_hardware'
folder.mkdir(exist_ok=True)
(folder / 'glove_usb_dual_hardware.ino').write_text(source)
print('Generated D12 hardware UART sketch from shared dual-glove source.')
