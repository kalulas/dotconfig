#!/usr/bin/zsh

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch polybar "excalibar"
echo "------" | tee -a /tmp/polybar1.log
polybar excalibar 2>&1 | tee -a /tmp/polybar1.log & disown

echo "excalibar launched!"