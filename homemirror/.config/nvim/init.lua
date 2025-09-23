local home = vim.fn.expand("~")
local uv = vim.loop

cwd = vim.fn.getcwd()
ll_modules = {}

-- Utility: Read file into a Lua string
local function read_file_to_string(path)
  local fd = uv.fs_open(path, "r", 438)     -- 438 = octal 0666
  if not fd then return nil end
  local stat = uv.fs_fstat(fd)
  if not stat then
    uv.fs_close(fd)
    return nil
  end
  local data = uv.fs_read(fd, stat.size, 0)
  uv.fs_close(fd)
  return data
end

-- Utility: Check if a substring is prefix of a string
local function starts_with(str, prefix)
  return string.sub(str, 1, #prefix) == prefix
end

local function check_code_override()
  if starts_with(cwd, home) then
    local lcwd = string.sub(cwd, #home + 2)
    if starts_with(lcwd, "code/") then
      return true
    end
    if starts_with(lcwd, "work/") then
      return true
    end
    if starts_with(lcwd, ".../bin") then
      return true
    end
  end

  local config_path = cwd .. "/ignoreme-neovim.json"

  -- Check if the file exists
  if uv.fs_stat(config_path) then
    -- Read file contents
    local json_str = read_file_to_string(config_path)

    if json_str then
      local ok, config = pcall(vim.fn.json_decode, json_str)
      if ok and type(config) == "table" then
        if config.modules == "code" then
          return true
        end
      else
        vim.notify("Failed to parse ignoreme-neovim.json", vim.log.levels.ERROR)
      end
    else
      vim.notify("ignoreme-neovim.json exists but cannot be read", vim.log.levels.WARN)
    end
  end

  return false
end

code_override = check_code_override()

-- ## Modularity stuff

local modules_always = dofile(home .. "/.config/nvim/modules-always.lua")

if code_override then
  local modules_code = dofile(home .. "/.config/nvim/modules-code.lua")
  _G.ll_modules = vim.list_extend(
    modules_always.l_modules or {},
    modules_code.l_modules or {}
  )
else
  _G.ll_modules = modules_always.l_modules
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not uv.fs_stat(lazypath) then
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

-- Mimic Vim's "no hidden buffers" default behavior
vim.opt.hidden = false

-- Build the full path for ignoreme-env.lua
local file_path = cwd .. '/ignoreme-env.lua'
-- Check if the file exists (filereadable returns 1 if yes)
if vim.fn.filereadable(file_path) == 1 then
  -- Execute the Lua file once
  dofile(file_path)
end

-- Recycling the `q` bindings
vim.api.nvim_set_keymap('n', 'q', '<Nop>', { noremap = true, silent = true })

if code_override then
  local auto_lsp = dofile(home .. "/.config/nvim/auto-lsp.lua")
end

local vimrc = vim.fn.stdpath("config") .. "/nvim_init.vim"
vim.cmd.source(vimrc)

vim.cmd.colorscheme('xtsimple')
