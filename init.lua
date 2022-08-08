-- ================================================================== --
-- ===                      EDITOR SETTINGS                       === --
-- ================================================================== --

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.ai = true

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30

vim.g.mapleader = ' '

vim.keymap.set({'n', 'x'}, 'cp', '"+y')
vim.keymap.set({'n', 'x'}, 'cv', '"+p')
vim.keymap.set({'n', 'x'}, 'x', '"_x')
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>')
vim.keymap.set('n', '<leader>a', ':keepjumps( normal! ggVG<CR>')

local group = vim.api.nvim_create_augroup('user_cmds', {clear = true})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight on yank',
  group = group,
  callback = function()
    vim.highlight.on_yank({higroup = 'Visual', timeout = 200})
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'help', 'man'},
  group = group,
  command = 'nnoremap <buffer> q <cmd>quit<cr>'
})

-- ================================================================== --
-- ===                          PLUGINS                           === --
-- ================================================================== --

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print('Installing packer...')
  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
  print('Done.')

  vim.cmd('packadd packer.nvim')
  install_plugins = true
end

vim.api.nvim_create_user_command(
  'ReloadConfig',
  'source $MYVIMRC | PackerCompile',
  {}
)

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'	-- Package manager
	use "williamboman/mason.nvim"
  use 'joshdick/onedark.vim'
  use 'nvim-lualine/lualine.nvim'
	use 'nvim-lua/plenary.nvim'
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requiere = { {'nvim-lua/plenary.nvim'} }
	}
	use {
  	'kyazdani42/nvim-tree.lua',
  	requires = {
    	'kyazdani42/nvim-web-devicons',	-- optional, for file icons
  	},
  	tag = 'nightly'	-- optional, updated every week. (see issue #1193)
	}
	use 'neovim/nvim-lspconfig'	-- Configurations for Nvim LSP
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
	}
  if install_plugins then
    require('packer').sync()
  end
end)

if install_plugins then
  return
end


-- ================================================================== --
-- ===                    PLUGIN CONFIGURATION                    === --
-- ================================================================== --

---
-- Colorscheme
---

vim.opt.termguicolors = true
vim.cmd('colorscheme onedark')


---
-- lualine.nvim (statusline)
---

vim.opt.showmode = false
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
})

--- 
-- nvim-tree
---
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

---
--
---
require("mason").setup()
require('lspconfig').pyright.setup{}
