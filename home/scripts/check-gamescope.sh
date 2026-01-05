#!/usr/bin/env bash
# Script to check if gamescope is running and which games are using it

echo "=== Checking for gamescope processes ==="
if pgrep -x gamescope > /dev/null; then
    echo "✓ gamescope is running"
    echo ""
    echo "Gamescope processes:"
    ps aux | grep gamescope | grep -v grep
    echo ""
    
    # Get gamescope PID
    GAMESCOPE_PID=$(pgrep -x gamescope)
    echo "=== Processes running under gamescope (PID: $GAMESCOPE_PID) ==="
    # Check child processes
    pstree -p $GAMESCOPE_PID 2>/dev/null || ps --forest -o pid,cmd $(pgrep -P $GAMESCOPE_PID) 2>/dev/null || echo "Cannot determine child processes"
else
    echo "✗ gamescope is NOT running"
    echo ""
    echo "To check if a specific game window is using gamescope:"
    echo "  hyprctl clients | grep -A 10 'gamescope'"
fi

echo ""
echo "=== Checking Hyprland windows for gamescope ==="
hyprctl clients 2>/dev/null | grep -B 5 -A 10 "class.*gamescope" || echo "No gamescope windows found in Hyprland"

echo ""
echo "=== Current game windows ==="
hyprctl clients 2>/dev/null | grep -E "class.*steam_app|title.*game" -i || echo "No game windows found"

