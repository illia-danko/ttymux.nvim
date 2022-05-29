local collection = require('nvimtmux.utils.collection')
local config = {}

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function navigate(direction)
  return function()
    vim.cmd(t("normal! <C-w>" .. direction))
  end
end

local function setup(user_config)
  config = collection.merge_table(config, user_config)

  if not vim.env.TMUX then
    return
  end

  vim.keymap.set("n", "<C-w>l", navigate("l"))
  vim.keymap.set("n", "<C-w>h", navigate("h"))
  vim.keymap.set("n", "<C-w>k", navigate("k"))
  vim.keymap.set("n", "<C-w>j", navigate("j"))
end

return {
  setup = setup
}
