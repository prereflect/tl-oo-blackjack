#!/bin/bash
cd ~/rails_projects/tl-oop-blackjack

tmux start-server

tmux new-session -d -s itp2 -n workspace
tmux new-window -t itp2:2 -n irb
tmux new-window -t itp2:3 -n git

tmux send-keys -t itp2:2 "irb" C-m
tmux send-keys -t itp2:3 "git status" C-m

tmux select-window -t itp2:3

tmux attach-session -t itp2
