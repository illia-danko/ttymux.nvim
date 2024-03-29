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

- They rebind useful key sequences, such as, `C-h`, `C-l`, `C-j` and `C-k`.
- They provide *not native* neovim window access.
- They do not work upon others focused (non neovim) TUI tools.

[ttymux.nvim](https://github.com/elijahdanko/ttymux.nvim) gives a native smooth
Tmux <-> Neovim workflow. No needs to memorize a tmux prefix key command group
and neovim C-w command group to manipulate windows: in most cases they are
identical.

# Installation

With Packer.nvim:

Add this in your init.lua or plugins.lua

```lua
use({
  "elijahdanko/ttymux.nvim",
  config = function()
    require("ttymux").setup({})
  end
})
```

# Default configuration

```lua
require("ttymux").setup({
    default_keymap = true,
})
```

# API

```lua
require("ttymux.window").navigate("l") -- navigate right
require("ttymux.window").navigate("h") -- navigate left
require("ttymux.window").navigate("k") -- navigate top
require("ttymux.window").navigate("j") -- navigate bottom
require("ttymux.window").close_current() -- close a window or pane
require("ttymux.window").next_window() -- cycle over windows
```

## Example: use arrows keys for window navigations

Neovim:

```lua
vim.keymap.set("n", "<Left>", function() require("ttymux.window").navigate("h") end)
vim.keymap.set("n", "<Right>", function() require("ttymux.window").navigate("l") end)
vim.keymap.set("n", "<Down>", function() require("ttymux.window").navigate("j") end)
vim.keymap.set("n", "<Up>", function() require("ttymux.window").navigate("k") end)
```

Tmux:

```bash
is_editor="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|nvim)(diff)?$'"
bind -T root Left if "$is_editor" "send Left" "select-pane -L"
bind -T root Right if "$is_editor" "send Right" "select-pane -R"
bind -T root Down if "$is_editor" "send Down" "select-pane -D"
bind -T root Up if "$is_editor" "send Up" "select-pane -U"
```

# Tmux config examples

## C-w as a prefix key

```bash
# Change prefix-key (optional).
unbind C-b
set -g prefix C-w
bind C-w send-prefix

is_not_zoomed_window="echo '#{window_zoomed_flag}' | grep -qwE '0'"
is_other_panes='echo "#{window_panes}" | grep -vqwE "1"'
is_editor="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|nvim)(diff)?$'"

# Bindings.
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

## C-x as a prefix key

```bash
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
bind c new-window -c "#{pane_current_path}"
```

# Known issues

- `[C-w w]` or `[C-w C-w]` switches to the next neovim window _before_ moving to
  an other tmux pane. This behaviour is good enough when you are circling
  windows, however might cause inconvenience in other usages.

# License

MIT
