is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
is_other_panes="echo '#{window_panes}' | grep -vqwE '1'"
bind -T vim-keys h if "$is_vim" "send C-w; send" "select-pane -L"
bind -T vim-keys C-h if "$is_vim" "send C-w; send" "select-pane -L"
bind -T vim-keys j if "$is_vim" "send C-w; send" "select-pane -U"
bind -T vim-keys C-j if "$is_vim" "send C-w; send" "select-pane -U"
bind -T vim-keys k if "$is_vim" "send C-w; send" "select-pane -D"
bind -T vim-keys C-k if "$is_vim" "send C-w; send" "select-pane -D"
bind -T vim-keys l if "$is_vim" "send C-w; send" "select-pane -R"
bind -T vim-keys C-l if "$is_vim" "send C-w; send" "select-pane -R"
bind -T vim-keys w if "$is_vim" "send C-w; send" "select-pane -t :.+"
bind -T vim-keys C-w if "$is_vim" "send C-w; send" "select-pane -t :.+"
bind -T vim-keys o { kill-pane -a; if "$is_vim" "send C-w; send"  }
bind -T vim-keys C-o { kill-pane -a; if "$is_vim" "send C-w; send"  }
bind -T vim-keys c if "$is_vim" "send C-w; send" 'if $is_other_panes kill-pane'
bind -T vim-keys C-c if "$is_vim" "send C-w; send" 'if $is_other_panes kill-pane'
bind -T vim-keys Any { send C-w; send }
bind -T root C-w switch-client -T vim-keys
bind -T copy-mode-vi C-w switch-client -T vim-keys
