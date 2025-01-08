#!/bin/bash

# ==== BTOP
SESSION="btop"
SESSIONEXISTS=$(tmux list-sessions 2>/dev/null | grep $SESSION)

if [ "$SESSIONEXISTS" = "" ]
then
	tmux new-session -d -s $SESSION 'btop'
	#tmux send-keys -t $SESSION:0 'btop' C-m
else
	echo Already exists: $SESSIONEXISTS
fi

# ==== IPERF
SESSION="iperf"
SESSIONEXISTS=$(tmux list-sessions 2>/dev/null | grep $SESSION)

if [ "$SESSIONEXISTS" = "" ]
then
	tmux new-session -d -s $SESSION 'iperf3 -s'
	#tmux send-keys -t $SESSION:0 'iperf3 -s' C-m
else
	echo Already exists: $SESSIONEXISTS
fi


# Split window (tab) 0 of session: tmux split-window -v -t $SESSION:0 'command' 
# Create new window (tab) in session: tmux new-window -t $SESSION -n 'tab name' 'command' 
