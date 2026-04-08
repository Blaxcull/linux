-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`

vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
use {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}

use({
  'rose-pine/neovim',
  as = 'rose-pine',
  config = function()
    require("rose-pine").setup({
      styles = {
        bold = true,
        italic = false,
      },
    })
    vim.cmd('colorscheme rose-pine')
  end
})

use { "catppuccin/nvim", as = "catppuccin" }
use { "ellisonleao/gruvbox.nvim" }

use {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  config = function()
    require('nvim-treesitter.config').setup({
      ensure_installed = { "javascript","typescript","python","cpp","c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}



-- use('nvim-treesitter/playground')  -- Disabled due to compatibility issues with Neovim 0.11.6

use('ThePrimeagen/harpoon')
use('mbbill/undotree')
use('tpope/vim-fugitive')



use({
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({})


  end,
})

 use {
      'VonHeikemen/lsp-zero.nvim',
      requires = {
        -- LSP Support
      {
            'neovim/nvim-lspconfig',
            tag = 'v2.1.0'  -- pre-deprecation version
        },
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'saadparwaiz1/cmp_luasnip'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-nvim-lua'},

        -- Snippets
        {'L3MON4D3/LuaSnip'},
        {'rafamadriz/friendly-snippets'},
      }
    }
 use ('tmux-plugins/tmux-resurrect')
 use ('ThePrimeagen/vim-be-good')
end)
