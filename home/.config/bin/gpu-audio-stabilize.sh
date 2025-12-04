#!/bin/bash
# Set NVIDIA power management to prefer consistent performance
nvidia-smi -pm 1
nvidia-smi -pl 90  # Set power limit slightly below max (adjust for your GPU)

# Disable GPU boost clocks for more consistent power usage
nvidia-settings -a [gpu:0]/GPUPowerMizerMode=1  # Prefer consistent performance

# Set fixed GPU clock instead of variable boosting
nvidia-settings -a [gpu:0]/GPUGraphicsClockOffset[3]=0  # No overclock
