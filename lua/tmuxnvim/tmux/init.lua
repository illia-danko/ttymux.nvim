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

return {
  is_last_pane = is_last_pane,
  goto_pane = goto_pane,
}
