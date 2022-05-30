local tmux = require("tmuxnvim.tmux")

local function exec_wincmd(cmd)
  pcall(vim.cmd, "wincmd " .. cmd)
end

local function navigate(direction)
  local nr = vim.fn.winnr()
  exec_wincmd(direction)

  if vim.fn.winnr() == nr then
    pcall(tmux.goto_pane, direction)
  end
end

local function close_current()
  local nr = vim.fn.winnr("$")
  exec_wincmd("c")

  pcall(function()
    if vim.fn.winnr("$") == nr then
      if not tmux.last_pane() then
        tmux.close_current_pane()
      end
    end
  end)
end

return {
  navigate = navigate,
  close_current = close_current,
}
