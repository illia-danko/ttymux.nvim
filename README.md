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

There several plugin among a community to address Tmux - Neovim navigation and
binding issues. They do the job, however:

- They rebind useful keymaps (such as Ctrl-K, which kills a line in tcsh like
  terminals);
- They provides *not native* vim/neovim keymaps;

[tmuxnvim](https://github.com/elijahdanko/tmuxnvim) gives a native
Tmux/Neovim workflow with core implemented features.

# Limitations

Neovim/vim has two equal methods of windows navigation: with a doubled Ctrl key
pressed and a single Ctrl prefix key, like `Ctrl-w Ctrl-w` and `Ctrl-w w`, both
are used to go to the next window.

The plugin supports only a single (prefix) Ctrl key method.

# License

MIT
