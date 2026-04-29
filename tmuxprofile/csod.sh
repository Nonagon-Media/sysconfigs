#!/bin/bash

# csod.sh - Create CSOD tmux session with pre-configured windows and panes
# Usage: ./csod.sh
#
# Creates:
#   - Window 1: CLAUDE (single pane)
#   - Window 2: SYSTEM (single pane)
#   - Window 3: AUTHS (12 panes for AWS/GCP environment authentication)

SESSION="csod"
AWS_PROFILES_DIR="$HOME/build/aws/profiles"

# Check if session already exists
if tmux has-session -t "$SESSION" 2>/dev/null; then
    echo "Session '$SESSION' already exists. Attaching..."
    tmux attach-session -t "$SESSION"
    exit 0
fi

# Create new session with first window named CLAUDE
tmux new-session -d -s "$SESSION" -n "CLAUDE"

# Create SYSTEM window
tmux new-window -t "$SESSION" -n "SYSTEM"

# Create AUTHS window
tmux new-window -t "$SESSION" -n "AUTHS"

# Set up AUTHS window with 12 panes in a 4x3 grid
# Pane layout:
#   ┌──────────────┬──────────────┬──────────────┐
#   │ 1: cm-stage  │ 2: itf-dev   │ 3: efta      │
#   ├──────────────┼──────────────┼──────────────┤
#   │ 4: leap-prod │ 5: cm-prod   │ 6: itf-prod  │
#   ├──────────────┼──────────────┼──────────────┤
#   │ 7: emast     │ 8: gcp       │ 9: glb-ext-sre│
#   ├──────────────┼──────────────┼──────────────┤
#   │10: gov-dev   │11: fed-stage │12: fed-prod  │
#   └──────────────┴──────────────┴──────────────┘

# Start in AUTHS window (window 3)
tmux select-window -t "$SESSION:3"

# Create 12 panes: 3 vertical splits (4 rows), then split each row horizontally twice
tmux split-window -v -t "$SESSION:3.1"
tmux split-window -v -t "$SESSION:3.1"
tmux split-window -v -t "$SESSION:3.1"
tmux split-window -h -t "$SESSION:3.1"
tmux split-window -h -t "$SESSION:3.1"
tmux split-window -h -t "$SESSION:3.4"
tmux split-window -h -t "$SESSION:3.4"
tmux split-window -h -t "$SESSION:3.7"
tmux split-window -h -t "$SESSION:3.7"
tmux split-window -h -t "$SESSION:3.10"
tmux split-window -h -t "$SESSION:3.10"

# Apply tiled layout for even 4x3 grid
tmux select-layout -t "$SESSION:3" tiled

# Define environments in order for the grid (row by row, left to right)
# Panes 10-12 are FedMod environments (gov-dev active, fed-stage/fed-prod pending access)
declare -a ENVS=("cm-stage" "itf-dev" "efta" "leap-prod" "cm-prod" "itf-prod" "emast" "gcp" "glb-ext-sre" "gov-dev" "fed-stage" "fed-prod")

# Send cd commands to each pane (panes 1-12)
for i in {1..12}; do
    env="${ENVS[$((i-1))]}"
    if [ -d "$AWS_PROFILES_DIR/$env" ]; then
        tmux send-keys -t "$SESSION:3.$i" "cd $AWS_PROFILES_DIR/$env && clear" Enter
    else
        tmux send-keys -t "$SESSION:3.$i" "clear && echo '[$env] environment not yet configured'" Enter
    fi
done

# Select first pane in AUTHS window
tmux select-pane -t "$SESSION:3.1"

# Go back to CLAUDE window
tmux select-window -t "$SESSION:1"

# Attach to session
echo "Created session '$SESSION' with windows: CLAUDE, SYSTEM, AUTHS"
tmux attach-session -t "$SESSION"
