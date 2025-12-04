#!/bin/bash
while true; do
  # Check if USB interrupts are spiking
  usb_irqs=$(cat /proc/interrupts | grep "xhci_hcd" | awk '{print $2+$3+$4+$5}')
  nvidia_irqs=$(cat /proc/interrupts | grep "nvidia" | awk '{print $2+$3+$4+$5}')
  
  # If USB interrupts are significantly higher than NVIDIA, adjust affinity
  if [ "$usb_irqs" -gt "$((nvidia_irqs * 2))" ]; then
    echo "Adjusting IRQ affinities due to USB activity"
    echo ffff0000 > /proc/irq/122/smp_affinity  # USB to CPUs 16-31
    echo 0000ff00 > /proc/irq/130/smp_affinity  # NVIDIA to CPUs 8-15
  fi
  
  sleep 2
done
