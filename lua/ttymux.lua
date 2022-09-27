local M = {}

local window = require("ttymux.window")

local function bind_default_keymap()
  vim.keymap.set("n", "<C-w>l", function()
    require("ttymux.window").navigate("l")
  end)
  vim.keymap.set("n", "<C-w><C-l>", function()
    require("ttymux.window").navigate("l")
  end)
  vim.keymap.set("n", "<C-w>h", function()
    require("ttymux.window").navigate("h")
  end)
  vim.keymap.set("n", "<C-w><C-h>", function()
    require("ttymux.window").navigate("h")
  end)
  vim.keymap.set("n", "<C-w>k", function()
    require("ttymux.window").navigate("k")
  end)
  vim.keymap.set("n", "<C-w><C-k>", function()
    require("ttymux.window").navigate("k")
  end)
  vim.keymap.set("n", "<C-w>j", function()
    require("ttymux.window").navigate("j")
  end)
  vim.keymap.set("n", "<C-w><C-j>", function()
    require("ttymux.window").navigate("j")
  end)
  vim.keymap.set("n", "<C-w>c", function()
    require("ttymux.window").close_current()
  end)
  vim.keymap.set("n", "<C-w><C-c>", function()
    require("ttymux.window").close_current()
  end)
  vim.keymap.set("n", "<C-w>w", function()
    require("ttymux.window").next_window()
  end)
  vim.keymap.set("n", "<C-w><C-w>", function()
    require("ttymux.window").next_window()
  end)
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
