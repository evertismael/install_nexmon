from scapy.all import *

def send_probe(device, interval):
    rt = RadioTap(len=9, present='Rate') # 8 bytes radiotap header, 1 byte Rate field
    rt.Rate = 6 # Mbps
    dot11 = Dot11(addr1='ff:ff:ff:ff:ff:ff', addr2='11:22:33:44:55:66', addr3='ff:ff:ff:ff:ff:ff')
    probeReq = Dot11ProbeReq()
    dot11elt = Dot11Elt(ID="SSID", info="testSSID")
    frame = rt/dot11/probeReq/dot11elt
    sendp(frame, iface=device, loop=1, inter=interval)

send_probe('wlan0', 0.05)
