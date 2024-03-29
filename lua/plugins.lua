local api = vim.api
local fn = vim.fn

local utils = require("utils")

-- The root dir to install all plugins. Plugins are under opt/ or start/ sub-directory.
vim.g.plugin_home = fn.stdpath("data") .. "/site/pack/packer"

--- Install packer if it has not been installed.
--- Return:
--- true: if this is a fresh install of packer
--- false: if packer has been installed
local function packer_ensure_install()
  -- Where to install packer.nvim -- the package manager (we make it opt)
  local packer_dir = vim.g.plugin_home .. "/opt/packer.nvim"

  if fn.glob(packer_dir) ~= "" then
    return false
  end

  -- Auto-install packer in case it hasn't been installed.
  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})

  local packer_repo = "https://github.com/wbthomason/packer.nvim"
  local install_cmd = string.format("!git clone --depth=1 %s %s", packer_repo, packer_dir)
  vim.cmd(install_cmd)

  return true
end

local fresh_install = packer_ensure_install()

-- Load packer.nvim
vim.cmd("packadd packer.nvim")

local packer = require("packer")
local packer_util = require("packer.util")

packer.startup {
  function(use)
    -- it is recommended to put impatient.nvim before any other plugins
    use { "lewis6991/impatient.nvim", config = [[require('impatient')]] }

    use { "wbthomason/packer.nvim", opt = true }

    use { "onsails/lspkind-nvim", event = "VimEnter" }

    -- auto-completion engine
    use { "hrsh7th/nvim-cmp", after = "lspkind-nvim", config = [[require('config.nvim-cmp')]] }

    -- nvim-cmp completion sources
    use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
    use { "hrsh7th/cmp-path", after = "nvim-cmp" }
    use { "hrsh7th/cmp-buffer", after = "nvim-cmp" }
    use { "hrsh7th/cmp-omni", after = "nvim-cmp" }

    use {
      's1n7ax/nvim-window-picker',
      tag = 'v1.*',
      config = function()
        require'window-picker'.setup()
      end,
    }

    use { "hrsh7th/cmp-emoji", after = "nvim-cmp" }

    use {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    }
    use { "williamboman/mason-lspconfig.nvim", after = "mason.nvim", config = [[require('config.mason-lspconfig')]] }
    use { "jayp0521/mason-null-ls.nvim", after = "mason.nvim", config = [[require('config.mason-null-ls')]] }

    -- nvim-lsp configuration (it relies on cmp-nvim-lsp, so it should be loaded after cmp-nvim-lsp).
    use { 'jose-elias-alvarez/typescript.nvim' }
    use {
      "neovim/nvim-lspconfig",
      after = { "cmp-nvim-lsp", "mason-lspconfig.nvim", 'typescript.nvim' },
      config = [[require('config.lsp')]],
    }

    use {
      "nvim-treesitter/nvim-treesitter",
      event = "BufEnter",
      run = ":TSUpdate",
      config = [[require('config.treesitter')]],
    }

    use {
      "nvim-treesitter/nvim-treesitter-context",
      config = function()
        require("treesitter-context").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end,
      after = "nvim-treesitter",
    }

    use {
      "folke/twilight.nvim",
      config = function()
        require("twilight").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end,
    }

    use {
      "folke/zen-mode.nvim",
      config = function()
        require("zen-mode").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
          plugins = {
            kitty = {
              enabled = true,
              font = "+4", -- font size increment
            },
            tmux = { enabled = true },
            gitsigns = { enabled = true },
          },
        }
      end,
    }

    use { "windwp/nvim-ts-autotag", after = "nvim-treesitter", config = [[require('config.nvim-ts-autotag')]] }

    use {
      "nvim-treesitter/nvim-treesitter-textobjects",
      after = "nvim-treesitter",
    }

    use("fladson/vim-kitty")
    use { "folke/tokyonight.nvim", config = [[require('config.tokyonight')]] }
    use {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      requires = { { "nvim-lua/plenary.nvim" } },
      config = [[require('config.telescope')]]
    }

    use {
      "ggandor/lightspeed.nvim",
      config = [[require('config.lightspeed')]]
    }

    -- search emoji and other symbols
    use { "nvim-telescope/telescope-symbols.nvim", after = "telescope.nvim" }

    use {
      "nvim-telescope/telescope-frecency.nvim",
      config = function()
        require("telescope").load_extension("frecency")
      end,
      requires = { "kkharji/sqlite.lua" },
      after = "telescope.nvim"
    }

    use {
      "vuki656/package-info.nvim",
      requires = "MunifTanjim/nui.nvim",
      config = [[require('config.package-info')]],
    }
    use {
      "jose-elias-alvarez/null-ls.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = [[require('config.null-ls')]],
    }

    use { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp", config = [[require('config.luasnip')]] }
    use {
      "L3MON4D3/LuaSnip",
      after = "nvim-cmp",
      config = function()
        require("luasnip.loaders.from_lua").lazy_load { include = { "all", "typescript" } }
      end,
    }
    use { "lukas-reineke/indent-blankline.nvim", config = [[require('config.indent-blankline')]] }
    use {
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons",
      config = [[require('config.trouble')]],
    }
    use("RRethy/vim-illuminate")
    use("sbdchd/neoformat")

    use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      config = [[require('config.statusline')]],
      after = "lspkind-nvim",
    }

    use { "akinsho/bufferline.nvim", event = "VimEnter", config = [[require('config.bufferline')]] }

    -- fancy start screen
    use { "glepnir/dashboard-nvim", requires = {'nvim-tree/nvim-web-devicons'}, event = "VimEnter", config = [[require('config.dashboard-nvim')]] }

    -- Highlight URLs inside vim
    use { "itchyny/vim-highlighturl", event = "VimEnter" }

    -- notification plugin
    use {
      "rcarriga/nvim-notify",
      event = "BufEnter",
      config = function()
        vim.defer_fn(function()
          require("config.nvim-notify")
        end, 2000)
      end,
    }

    -- For Windows and Mac, we can open an URL in the browser. For Linux, it may
    -- not be possible since we maybe in a server which disables GUI.
    -- open URL in browser
    use { "tyru/open-browser.vim", event = "VimEnter" }

    -- Autosave files on certain events
    use { "907th/vim-auto-save", event = "InsertEnter" }

    -- Show undo history visually
    use { "simnalamburt/vim-mundo", cmd = { "MundoToggle", "MundoShow" } }

    use { "svermeulen/vim-yoink", event = "VimEnter" }

    -- Git command inside vim
    use { "tpope/vim-fugitive", event = "User InGitRepo", config = [[require('config.fugitive')]] }

    -- Better git log display
    use { "rbong/vim-flog", requires = "tpope/vim-fugitive", cmd = { "Flog" } }

    use { "christoomey/vim-conflicted", requires = "tpope/vim-fugitive", cmd = { "Conflicted" } }

    use {
      "ruifm/gitlinker.nvim",
      requires = "nvim-lua/plenary.nvim",
      event = "User InGitRepo",
      config = [[require('config.git-linker')]],
    }

    -- Show git change (change, delete, add) signs in vim sign column
    use { "lewis6991/gitsigns.nvim", config = [[require('config.gitsigns')]] }

    -- Better git commit experience
    use { "rhysd/committia.vim", opt = true, setup = [[vim.cmd('packadd committia.vim')]] }

    use { "chrisbra/unicode.vim", event = "VimEnter" }

    -- showing keybindings
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      config = function()
        vim.defer_fn(function()
          require("config.which-key")
        end, 2000)
      end,
    }

    -- file explorer
    use {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      config = [[require('config.neo-tree')]],
      requires = { 
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      }
    }
    -- Asynchronous command execution
    use { "skywind3000/asyncrun.vim", opt = true, cmd = { "AsyncRun" } }

    use { "ii14/emmylua-nvim", ft = "lua" }

    use {
      "j-hui/fidget.nvim",
      after = "nvim-lspconfig",
      config = function()
        require("fidget").setup()
      end,
    }

    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end,
    }

    use ({
      "Bryley/neoai.nvim",
      require = { "MunifTanjim/nui.nvim" },
      config = [[require('config.neoai')]]
    })

    use { 
      "zbirenbaum/copilot.lua", 
      config = [[require('config.copilot')]]
    }

    use {
      "zbirenbaum/copilot-cmp",
      after = { "copilot.lua" },
      config = function ()
        require("copilot_cmp").setup()
      end
    }

    use({
      "glepnir/lspsaga.nvim",
      opt = true,
      branch = "main",
      event = "LspAttach",
      config = [[require('config.lspsaga')]],
      requires = {
        {"nvim-tree/nvim-web-devicons"},
        --Please make sure you install markdown and markdown_inline parser
        {"nvim-treesitter/nvim-treesitter"}
      }
    })

    use ({
      "nvim-tree/nvim-web-devicons",
      config = [[require('config.devicons')]],
    })
  end,
  config = {
    max_jobs = 16,
    compile_path = packer_util.join_paths(fn.stdpath("data"), "site", "lua", "packer_compiled.lua"),
  },
}

-- For fresh install, we need to install plugins. Otherwise, we just need to require `packer_compiled.lua`.
if fresh_install then
  -- We run packer.sync() here, because only after packer.startup, can we know which plugins to install.
  -- So plugin installation should be done after the startup process.
  packer.sync()
else
  local status, _ = pcall(require, "packer_compiled")
  if not status then
    local msg = "File packer_compiled.lua not found: run PackerSync to fix!"
    vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })
  end
end

-- Auto-generate packer_compiled.lua file
api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*/nvim/lua/plugins.lua",
  group = api.nvim_create_augroup("packer_auto_compile", { clear = true }),
  callback = function(ctx)
    local cmd = "source " .. ctx.file
    vim.cmd(cmd)
    vim.cmd("PackerCompile")
    vim.notify("PackerCompile done!", vim.log.levels.INFO, { title = "Nvim-config" })
  end,
})
