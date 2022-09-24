# Change prefix-key (optional).
unbind C-b
set -g prefix C-w
bind C-w send-prefix

##### Vim bindings.
is_not_zoomed_window="echo '#{window_zoomed_flag}' | grep -qwE '0'"
is_other_panes='echo "#{window_panes}" | grep -vqwE "1"'
is_editor="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|nvim)(diff)?$'"

# Bindings.
bind -T copy-mode-vi C-w switch-client -T vim-keys
bind h if "$is_editor" "send C-w; send" "select-pane -L"
bind C-h if "$is_editor" "send C-w; send" "select-pane -L"
bind j if "$is_editor" "send C-w; send" "select-pane -U"
bind C-j if "$is_editor" "send C-w; send" "select-pane -U"
bind k if "$is_editor" "send C-w; send" "select-pane -D"
bind C-k if "$is_editor" "send C-w; send" "select-pane -D"
bind l if "$is_editor" "send C-w; send" "select-pane -R"
bind C-l if "$is_editor" "send C-w; send" "select-pane -R"
bind w if "$is_editor" "send C-w; send" "select-pane -t :.+"
bind C-w if "$is_editor" "send C-w; send" "select-pane -t :.+"
bind o { kill-pane -a; if "$is_editor" "send C-w; send" }
bind C-o { kill-pane -a; if "$is_editor" "send C-w; send" }
bind c if "$is_editor" "send C-w; send" 'if $is_other_panes kill-pane'
bind C-c if "$is_editor" "send C-w; send" 'if $is_other_panes kill-pane'

# Tmux bindings.
bind % "split-window -h"
bind \" "split-window -v"
bind n new-window
bind x kill-pane

# Regular neovim bindings.
bind v "send C-w; send"
bind s "send C-w; send"
bind t "send C-w; send"

# Tmux bindings (optional).
bind \# kill-window
bind t choose-session
bind % if "$is_not_zoomed_window" "split-window -h -c \"#{pane_current_path}\"" "select-pane -t :.+"
bind \" if "$is_not_zoomed_window" "split-window -v -c \"#{pane_current_path}\"" "select-pane -t :.+"
bind n new-window -c "#{pane_current_path}"
