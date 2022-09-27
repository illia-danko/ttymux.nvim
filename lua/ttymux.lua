local M = {}

local window = require("ttymux.window")

M.setup = function(user_config)
  local config = {}

  config.default_mapping = user_config.default_mapping
  if config.default_mapping == nil then
    config.default_mapping = true
  end

  if not vim.env.TMUX then
    return
  end

  if config.default_mapping then
    local opts = { silent = true, noremap = true }
    vim.api.nvim_set_keymap(
      "n",
      "<C-w>l",
      [[<Cmd>lua require'ttymux.window'.navigate("l")<CR>]],
      opts
    )
    vim.api.nvim_set_keymap(
      "n",
      "<C-w><C-l>",
      [[<Cmd>lua require'ttymux.window'.navigate("l")<CR>]],
      opts
    )
    vim.api.nvim_set_keymap(
      "n",
      "<C-w>h",
      [[<Cmd>lua require'ttymux.window'.navigate("h")<CR>]],
      opts
    )
    vim.api.nvim_set_keymap(
      "n",
      "<C-w><C-h>",
      [[<Cmd>lua require'ttymux.window'.navigate("h")<CR>]],
      opts
    )
    vim.api.nvim_set_keymap(
      "n",
      "<C-w>k",
      [[<Cmd>lua require'ttymux.window'.navigate("k")<CR>]],
      opts
    )
    vim.api.nvim_set_keymap(
      "n",
      "<C-w><C-k>",
      [[<Cmd>lua require'ttymux.window'.navigate("k")<CR>]],
      opts
    )
    vim.api.nvim_set_keymap(
      "n",
      "<C-w>j",
      [[<Cmd>lua require'ttymux.window'.navigate("j")<CR>]],
      opts
    )
    vim.api.nvim_set_keymap(
      "n",
      "<C-w><C-j>",
      [[<Cmd>lua require'ttymux.window'.navigate("j")<CR>]],
      opts
    )
    vim.api.nvim_set_keymap(
      "n",
      "<C-w>c",
      [[<Cmd>lua require'ttymux.window'.close_current()<CR>]],
      opts
    )
    vim.api.nvim_set_keymap(
      "n",
      "<C-w><C-c>",
      [[<Cmd>lua require'ttymux.window'.close_current()<CR>]],
      opts
    )
    vim.api.nvim_set_keymap(
      "n",
      "<C-w>w",
      [[<Cmd>lua require'ttymux.window'.next_window()<CR>]],
      opts
    )
    vim.api.nvim_set_keymap(
      "n",
      "<C-w><C-w>",
      [[<Cmd>lua require'ttymux.window'.next_window()<CR>]],
      opts
    )
  end
end

return M
