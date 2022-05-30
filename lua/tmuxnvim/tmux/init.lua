local directions_table = {
  l = "R",
  h = "L",
  k = "U",
  j = "D",
}

local function goto_pane(vim_direction)
  local d = directions_table[vim_direction]
  vim.fn.system({"tmux", "select-pane", "-" .. d})
end

local function last_pane()
  local res = vim.fn.system({"tmux", "display-message", "-p", "#{window_panes}"})
  return res == "1\n"
end

local function close_current_pane()
  vim.fn.system({"tmux", "kill-pane"})
end

return {
  goto_pane = goto_pane,
  last_pane = last_pane,
  close_current_pane = close_current_pane,
}
