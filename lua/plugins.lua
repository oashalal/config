return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim'
  use 'mfussenegger/nvim-jdtls'
  use 'catppuccin/nvim'
  use 'm4xshen/autoclose.nvim'

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/vim-vsnip'

  use 'nvim-telescope/telescope.nvim'
  use 'nvim-lualine/lualine.nvim'

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }
  use {
    "neovim/nvim-lspconfig",
    config = function()
    require("nvchad.configs.lspconfig").defaults()
    require "configs.lspconfig"
    end,
  }
    
  use 'dcampos/cmp-snippy'
  use 'dcampos/nvim-snippy'
  use 'honza/vim-snippets'
  use 'onsails/lspkind.nvim'
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-tree/nvim-tree.lua'
  
  -- Packer:
  use "olimorris/onedarkpro.nvim"
  use("oxfist/night-owl.nvim")
end)
