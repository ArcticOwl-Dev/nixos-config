#!/usr/bin/env bash
# Example script to launch a game with gamescope
# Usage: ./launch-game-gamescope.sh <game-command>

if [ $# -eq 0 ]; then
    echo "Usage: $0 <game-command>"
    echo ""
    echo "Examples:"
    echo "  $0 steam steam://rungameid/123456"
    echo "  $0 '/path/to/game'"
    echo ""
    echo "Common gamescope options:"
    echo "  -f          Fullscreen"
    echo "  -w WIDTH    Window width"
    echo "  -h HEIGHT   Window height"
    echo "  -r RES      Resolution (e.g., 1920x1080)"
    echo "  -F          FSR (FidelityFX Super Resolution)"
    echo "  --          Separator before game command"
    exit 1
fi

# Launch with gamescope
# -f = fullscreen, -r = resolution, -- = separator before game command
gamescope -f -r 1920x1080 -- "$@"

