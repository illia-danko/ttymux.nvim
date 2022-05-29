Neovim-TMUX native navigator.

## Requirements

- Neovim 0.5+
- Tmux 3.3-rc+

# Features

- [c-w l] to move to the left tmux pane or nvim window;
- [c-w r] to move to the right tmux pane or nvim window;
- [c-w k] to move to the bottom tmux pane or nvim window;
- [c-w j] to move to the down tmux pane or nvim window;
- [c-w c] to close the current tmux pane or nvim window (if not the last one);
- [c-w o] to close others tmux panes or nvim windows.

# Rationale

There several plugin among the comunitty to address Tmux - Neovim navigation and
binding issues. They do the job, however:

- They rebind useful keymaps (such as Ctrl-K, which kills a line in tcsh like
  terminals);
- They provides *not native* vim/neovim keymaps;
- They are features limited.

[tmuxnvim](https://github.com/elijahdanko/tmuxnvim) gives a native
Tmux/Neovim workfolow with many implemented fatures.

# Limitations

Neovim/vim has two equal ways to manipulate windows: with doubled ctrl key and a
single Ctrl key prefix, like `Ctrl-w Ctrl-w` and `Ctrl-w w` to go to the next
window.

The plugin supports only a single (prefix) Ctrl key method.

# License

MIT
