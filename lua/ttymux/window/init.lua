local tmux = require("ttymux.tmux")

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

local function next_window()
  if has_win("j") or has_win("l") then
    exec_wincmd("w")
  elseif not tmux.last_pane() then
    pcall(tmux.goto_next_pane)
  else
    exec_wincmd("w")
  end
end

return {
  navigate = navigate,
  close_current = close_current,
  next_window = next_window,
}
