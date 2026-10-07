#!/usr/bin/env python3
"""Send one synthetic OSC frame to the local receiver; Python stdlib only."""
import argparse, socket, struct
def osc_string(s):
    b=s.encode()+b'\0';return b+b'\0'*((-len(b))%4)
def packet(address, values, raw=False):
    tag='i' if raw else 'f'
    return osc_string(address)+osc_string(','+tag*5)+struct.pack('>'+tag*5,*values)
def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--hand',choices=['left','right','both'],default='both')
    p.add_argument('--raw',action='store_true',help='Send /servos calibration midpoint')
    p.add_argument('--values',nargs=5,type=float,default=[.1,.3,.5,.7,.9])
    a=p.parse_args()
    if not all(0<=v<=1 for v in a.values):p.error('normalized values must be 0–1')
    with socket.socket(socket.AF_INET,socket.SOCK_DGRAM) as sock:
        for hand,port in [('left',7000),('right',6000)]:
            if a.hand not in ('both',hand):continue
            address='/servos' if a.raw else '/G'+hand.capitalize()
            values=[90,99,99,99,125] if a.raw else a.values
            sock.sendto(packet(address,values,a.raw),('127.0.0.1',port))
            print(f'Sent {address} {values} to localhost:{port}')
if __name__=='__main__':main()
