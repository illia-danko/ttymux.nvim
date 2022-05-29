local collection = require('neotmux.utils.collection')
local config = {}

local navigate_prefix = "<C-w>"

local function navigate(direction)
  return function()
    local cmd = "normal! \<C-w>" .. direction
    vim.cmd(":exec " .. cmd)
  end
end

local function setup(user_config)
  config = collection.merge_table(config, user_config)

  if not vim.env.TMUX then
    return
  end

  vim.api.nvim_set_keymap("n", "<C-w>l", navigate("l"))
  vim.api.nvim_set_keymap("n", "<C-w>h", navigate("h"))
  vim.api.nvim_set_keymap("n", "<C-w>k", navigate("k"))
  vim.api.nvim_set_keymap("n", "<C-w>j", navigate("j"))
end

return {
  setup = setup
}
