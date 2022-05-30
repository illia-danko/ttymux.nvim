local collection = require('tmuxnvim.utils.collection')
local window = require('tmuxnvim.window')
local config = {}

local function setup(user_config)
  config = collection.merge_table(config, user_config)

  if not vim.env.TMUX then
    return
  end

  local opts = { silent = true, noremap = true }
  vim.api.nvim_set_keymap("n", "<C-w>l", [[<Cmd>lua require'tmuxnvim.window'.navigate("l")<CR>]], opts)
  vim.api.nvim_set_keymap("n", "<C-w>h", [[<Cmd>lua require'tmuxnvim.window'.navigate("h")<CR>]], opts)
  vim.api.nvim_set_keymap("n", "<C-w>k", [[<Cmd>lua require'tmuxnvim.window'.navigate("k")<CR>]], opts)
  vim.api.nvim_set_keymap("n", "<C-w>j", [[<Cmd>lua require'tmuxnvim.window'.navigate("j")<CR>]], opts)
  vim.api.nvim_set_keymap("n", "<C-w>c", [[<Cmd>lua require'tmuxnvim.window'.close_current()<CR>]], opts)
end

return {
  setup = setup
}
