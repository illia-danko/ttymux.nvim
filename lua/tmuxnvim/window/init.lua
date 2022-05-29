local tmux = require("tmuxnvim.tmux")

local function navigate(direction)
  local nr = vim.fn.winnr()
  pcall(vim.cmd, "wincmd " .. direction)

  if vim.fn.winnr() == nr then
    pcall(tmux.goto_pane, direction)
  end
end

return {
  navigate = navigate
}
