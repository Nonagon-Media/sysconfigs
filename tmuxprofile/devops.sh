#!/bin/bash

tmux new-session -s operations \; \
    
tmux new-session \; \
    send-keys 'tail -f /var/log/messages' C-m \; \
    split-window -v \; \
    split-window -h \; \
    send-keys 'top' C-m \;