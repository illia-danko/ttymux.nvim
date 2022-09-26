Neovim-TMUX native navigator.

## Requirements

- Neovim 0.7+
- Tmux 3.3-rc+

# Features

- `[C-w l]` or `[C-w C-l]` to move to the left tmux pane or nvim window.
- `[C-w r]` or `[C-w C-r]` to move to the right tmux pane or nvim window.
- `[C-w k]` or `[C-w C-k]` to move to the bottom tmux pane or nvim window.
- `[C-w j]` or `[C-w C-j]` to move to the down tmux pane or nvim window.
- `[C-w w]` or `[C-w C-w]` to walk over tmux panes or nvim windows. See [Known
  issues](#known-issues) section.
- `[C-w c]` or `[C-w C-c]` to close the current tmux pane or nvim window (if not
  the last one).
- `[C-w o]` or `[C-w C-o]` to close others tmux panes or nvim windows.

# Rationale

There are several plugin among the community to address Tmux - Neovim
navigation. They do the job, however:

- They rebind useful keymaps (such as Ctrl-K, which kills a line in tcsh like
  terminals);
- They provide *not native* neovim keymaps.
- They do not work upon others focused (non neovim) TUI tools.

[ttymux.nvim](https://github.com/elijahdanko/ttymux.nvim) gives a native smooth
Tmux <-> Neovim workflow. No needs to memorize the tmux prefix key command group
and neovim C-w command group to manipulate windows: in most cases they are
identical.

# Tmux config example

```bash
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
set-window-option -g mode-key vi
bind P paste-buffer
bind \# kill-window
bind t choose-session
bind % if "$is_not_zoomed_window" "split-window -h -c \"#{pane_current_path}\"" "select-pane -t :.+"
bind \" if "$is_not_zoomed_window" "split-window -v -c \"#{pane_current_path}\"" "select-pane -t :.+"
bind n new-window -c "#{pane_current_path}"
```

# Known issues

- `[C-w w]` or `[C-w C-w]` switches to the next neovim window _before_ moving to
  an other tmux pane. This behaviour is good enough when you are circling
  windows, however might cause inconvenience in other usages.

# License

MIT
