local M = {}

local tmux = require("ttymux.tmux")

local function exec_wincmd(cmd)
  pcall(vim.cmd, "wincmd " .. cmd)
end

M.navigate = function(direction)
  local nr = vim.fn.winnr()
  exec_wincmd(direction)

  if vim.fn.winnr() == nr then
    pcall(tmux.goto_pane, direction)
  end
end

M.close_current = function()
  local nr = vim.fn.winnr("$")
  exec_wincmd("c")

  if vim.fn.winnr("$") == nr then
    if not tmux.last_pane() then
      tmux.close_current_pane()
    end
  end
end

local function has_win(direction)
  local nr = vim.fn.win_getid()
  exec_wincmd(direction)
  if vim.fn.win_getid() == nr then
    return false
  end
  exec_wincmd("p")
  return true
end

M.next_window = function()
  if has_win("j") or has_win("l") then
    exec_wincmd("w")
  elseif not tmux.last_pane() then
    pcall(tmux.goto_next_pane)
  else
    exec_wincmd("w")
  end
end

return M
