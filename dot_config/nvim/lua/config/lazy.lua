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

require("lazy").setup({

	{
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		-- or                              , branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{ 'rose-pine/neovim', name = 'rose-pine' },
	{ "miikanissi/modus-themes.nvim", priority = 1000 },
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	{"theprimeagen/harpoon"},
	{"mbbill/undotree"},
	{"tpope/vim-fugitive"},


	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},

	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},

	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'hrsh7th/cmp-buffer'},
	{'hrsh7th/cmp-path'},
    {
        'L3MON4D3/LuaSnip',
        dependencies = {'saadparwaiz1/cmp_luasnip'}, 
        build = {"make install_jsregexp"}
    },
    {"rafamadriz/friendly-snippets"},


  { "AbdelrahmanDwedar/awesome-nvim-colorschemes" },
  { 'rebelot/kanagawa.nvim'},
  { 'nvim-tree/nvim-tree.lua'},
  { 'nvim-tree/nvim-web-devicons'},
  { 'nvim-lualine/lualine.nvim'},



  {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
          require("nvim-surround").setup({
              -- Configuration here, or leave empty to use defaults
          })
      end
  },

  {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      opts = {} -- this is equalent to setup({}) function
  },

  {
      "kawre/neotab.nvim",
      event = "InsertEnter",
      opts = {
          tabkey = "",
          act_as_tab = true,
          behavior = "nested", ---@type ntab.behavior
          pairs = { ---@type ntab.pair[]
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "<", close = ">" },
      },
      exclude = {},
      smart_punctuators = {
          enabled = true,
          semicolon = {
              enabled = true,
              ft = { "cs", "c", "cpp", "java", "rust" },
          },
          escape = {
              enabled = true,
              triggers = {}, ---@type table<string, ntab.trigger>
          },
      },
  }
  },
  {"folke/zen-mode.nvim"},
  {"lewis6991/gitsigns.nvim"},
  {'nvim-tree/nvim-web-devicons'},
  {'Pocco81/auto-save.nvim',
  init = function ()
      require("auto-save").setup {
          enabled = false,
          condition = function(buf)
              local fn = vim.fn
              local utils = require("auto-save.utils.data")
              if
                  fn.getbufvar(buf, "&modifiable") == 1
                  and utils.set_of({'md', 'tex', 'org', 'txt'})[fn.getbufvar(buf, "&filetype")]
                  then
                      return true -- met condition(s), can save
                  end
                  return false -- can't save
              end,
        }
      end,
  },
  {'lervag/vimtex',
  lazy = false
  },
    {'romgrk/barbar.nvim',
  dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function() vim.g.barbar_auto_setup = false  end,
  },
  { 'rust-lang/rust.vim' },
  {
      'mrcjkb/rustaceanvim',
      ft = { 'rust' },
  },
  {
      'mfussenegger/nvim-dap',
      dependencies = {
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
      },
    },

})
