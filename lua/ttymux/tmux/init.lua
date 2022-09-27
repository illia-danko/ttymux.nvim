local M = {}

local directions_table = {
  l = "R",
  h = "L",
  k = "U",
  j = "D",
}

M.goto_pane = function(vim_direction)
  local d = directions_table[vim_direction]
  vim.fn.system({ "tmux", "select-pane", "-" .. d })
end

M.goto_next_pane = function()
  vim.fn.system({ "tmux", "select-pane", "-t", ":.+" })
end

M.last_pane = function()
  local res = vim.fn.system({ "tmux", "display-message", "-p", "#{window_panes}" })
  return res == "1\n"
end

M.close_current_pane = function()
  vim.fn.system({ "tmux", "kill-pane" })
end

return M
