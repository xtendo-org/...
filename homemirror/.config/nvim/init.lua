local home = vim.fn.expand("~")
local cwd = vim.fn.getcwd()

local modules_always = dofile(home .. "/.config/nvim/modules-always.lua")

local function starts_with(str, prefix)
  return string.sub(str, 1, #prefix) == prefix
end

if starts_with(cwd, home) then
  home_rel = string.sub(cwd, #home + 2)
  if starts_with(home_rel, "code/") or home_rel == "serverprint" or home_rel == ".../bin" then
    local modules_code = dofile(home .. "/.config/nvim/modules-code.lua")
    ll_modules = vim.list_extend(
      modules_always.l_modules or {},
      modules_code.l_modules or {}
    )
  else
    ll_modules = modules_always.l_modules
  end
else
  ll_modules = modules_always.l_modules
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup(ll_modules)

-- some custom settings

vim.g.mapleader = " "
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.nu = true

-- Get the current working directory
local cwd = vim.fn.getcwd()
-- Build the full path for ignoreme-env.lua
local file_path = cwd .. '/ignoreme-env.lua'
-- Check if the file exists (filereadable returns 1 if yes)
if vim.fn.filereadable(file_path) == 1 then
  -- Execute the Lua file once
  dofile(file_path)
end

if home_rel and starts_with(home_rel, "code/") or home_rel == "serverprint" or home_rel == ".../bin" then
  local auto_lsp = dofile(home .. "/.config/nvim/auto-lsp.lua")
end

local vimrc = vim.fn.stdpath("config") .. "/nvim_init.vim"
vim.cmd.source(vimrc)

vim.cmd.colorscheme('xtsimple')
