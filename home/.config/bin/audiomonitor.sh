#!/bin/bash
echo "=== Audio System Monitor ==="
echo "Timestamp: $(date)"
echo ""

# CPU frequency and governor
echo "--- CPU Status ---"
cpupower frequency-info | grep "current CPU frequency"

# Interrupt distribution
echo ""
echo "--- Interrupt Status ---"
echo "USB (122): $(cat /proc/interrupts | grep "122:" | awk '{print $2+$3+$4+$5}')"
echo "NVIDIA (130): $(cat /proc/interrupts | grep "130:" | awk '{print $2+$3+$4+$5}')"
echo "Intel GPU (190): $(cat /proc/interrupts | grep "190:" | awk '{print $2+$3+$4+$5}')"

# USB controller status
echo ""
echo "--- USB Status ---"
lsusb -t | grep -E "(Cloud|Audio)"

# Kernel messages
echo ""
echo "--- Recent Kernel Messages ---"
dmesg | tail -5 | grep -E "(usb|xhci|audio|snd)"

# Process priorities
echo ""
echo "--- Audio Process Priorities ---"
ps -eo pid,pri,ni,comm | grep -E "(pulse|pipe|alsa)"
