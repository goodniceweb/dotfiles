unbind-key -n C-q

unbind-key -n F2
unbind-key -n C-F2
unbind-key -n S-F2

unbind-key -n C-a
set -g prefix ^A
set -g prefix2 ^A
bind a send-prefix

bind-key -n F2 new-window -c "#{pane_current_path}"
bind-key -n C-F2 split-window -c "#{pane_current_path}" 
bind-key -n S-F2 split-window -h -c "#{pane_current_path}"
