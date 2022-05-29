Neovim-TMUX native navigator.

## Requirements

- Neovim 0.5+
- Tmux 3.3-rc+

# Features

- [C-W l] to move to the left tmux pane or nvim window;
- [C-W r] to move to the right tmux pane or nvim window;
- [C-W k] to move to the bottom tmux pane or nvim window;
- [C-W j] to move to the down tmux pane or nvim window;
- [C-W c] to close the current tmux pane or nvim window (if not the last one);
- [C-W o] to close others tmux panes or nvim windows.

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

Neovim/vim has two equal methods of windows navigation: with a doubled Ctrl key
and a single Ctrl key prefix, like `Ctrl-w Ctrl-w` and `Ctrl-w w` to go to the
next window.

The plugin supports only a single (prefix) Ctrl key method.

# License

MIT
