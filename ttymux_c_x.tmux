# Change prefix-key (optional).
unbind C-b
set -g prefix C-x
bind C-x send-prefix

is_not_zoomed_window="echo '#{window_zoomed_flag}' | grep -qwE '0'"
is_other_panes='echo "#{window_panes}" | grep -vqwE "1"'
is_editor="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|nvim)(diff)?$'"

# Bindings.
bind -T nvim-keys h if "$is_editor" "send C-w; send" "select-pane -L"
bind -T nvim-keys C-h if "$is_editor" "send C-w; send" "select-pane -L"
bind -T nvim-keys j if "$is_editor" "send C-w; send" "select-pane -U"
bind -T nvim-keys C-j if "$is_editor" "send C-w; send" "select-pane -U"
bind -T nvim-keys k if "$is_editor" "send C-w; send" "select-pane -D"
bind -T nvim-keys C-k if "$is_editor" "send C-w; send" "select-pane -D"
bind -T nvim-keys l if "$is_editor" "send C-w; send" "select-pane -R"
bind -T nvim-keys C-l if "$is_editor" "send C-w; send" "select-pane -R"
bind -T nvim-keys w if "$is_editor" "send C-w; send" "select-pane -t :.+"
bind -T nvim-keys C-w if "$is_editor" "send C-w; send" "select-pane -t :.+"
bind -T nvim-keys o { kill-pane -a; if "$is_editor" "send C-w; send" }
bind -T nvim-keys C-o { kill-pane -a; if "$is_editor" "send C-w; send" }
bind -T nvim-keys c if "$is_editor" "send C-w; send" 'if $is_other_panes kill-pane'
bind -T nvim-keys C-c if "$is_editor" "send C-w; send" 'if $is_other_panes kill-pane'
bind -T nvim-keys Any { send C-w; send }
bind -T root C-w switch-client -T nvim-keys
bind -T copy-mode-vi C-w switch-client -T nvim-keys

# Tmux bindings (optional).
set-window-option -g mode-key vi
bind P paste-buffer
bind \# kill-window
bind % if "$is_not_zoomed_window" "split-window -h -c \"#{pane_current_path}\"" "select-pane -t :.+"
bind \" if "$is_not_zoomed_window" "split-window -v -c \"#{pane_current_path}\"" "select-pane -t :.+"
