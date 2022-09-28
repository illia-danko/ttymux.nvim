local M = {}

local window = require("ttymux.window")

-- stylua: ignore
local function bind_default_keymap()
  vim.keymap.set("n", "<C-w>l", function() window.navigate("l") end)
  vim.keymap.set("n", "<C-w><C-l>", function() window.navigate("l") end)
  vim.keymap.set("n", "<C-w>h", function() window.navigate("h") end)
  vim.keymap.set("n", "<C-w><C-h>", function() window.navigate("h") end)
  vim.keymap.set("n", "<C-w>k", function() window.navigate("k") end)
  vim.keymap.set("n", "<C-w><C-k>", function() window.navigate("k") end)
  vim.keymap.set("n", "<C-w>j", function() window.navigate("j") end)
  vim.keymap.set("n", "<C-w><C-j>", function() window.navigate("j") end)
  vim.keymap.set("n", "<C-w>c", function() window.close_current() end)
  vim.keymap.set("n", "<C-w><C-c>", function() window.close_current() end)
  vim.keymap.set("n", "<C-w>w", function() window.next_window() end)
  vim.keymap.set("n", "<C-w><C-w>", function() window.next_window() end)
end

M.setup = function(user_config)
  local config = {}

  config.default_keymap = user_config.default_keymap
  if config.default_keymap == nil then
    config.default_keymap = true
  end

  if not vim.env.TMUX then
    return
  end

  if config.default_keymap then
    bind_default_keymap()
  end
end

return M
