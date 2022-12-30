-- general
lvim.log.level = "warn"
lvim.format_on_save = true

-- ui
lvim.transparent_window = true
vim.g.catppuccin_flavour = "mocha"
lvim.colorscheme = "catppuccin"
vim.opt.wrap = true

-- spell
vim.opt.spell = true
vim.opt.spelllang = { "en", "ru" }

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- User config for builtin plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "bibtex",
  "c",
  "c_sharp",
  "cmake",
  "comment",
  "cpp",
  "css",
  "dart",
  "dockerfile",
  "dot",
  "go",
  "haskell",
  "html",
  "http",
  "java",
  "javascript",
  "jsdoc",
  "json",
  "kotlin",
  "latex",
  "llvm",
  "lua",
  "make",
  "markdown",
  "nix",
  "php",
  "python",
  "rasi",
  "regex",
  "ruby",
  "rust",
  "scss",
  "toml",
  -- TODO: what is "tsx"?
  "typescript",
  "vim",
  "yaml",
}
lvim.builtin.treesitter.highlight.enabled = true

lvim.lsp.installer.automatic_installation = true;
--require("lvim.lsp.manager").setup("dartls"); WARN: flutter-tools.nvim setup dartls themselves

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "rustfmt" },
  -- { name = "mdformat" }, It make [ to \[ that used in Zettelkasten
  { name = "jq" },
  { name = "yapf" },
  { name = "isort" },
}
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "proselint" },
  { name = "flake8" },
}
local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  { name = "proselint" },
}

-- Additional Plugins
lvim.plugins = {
  {
    "https://github.com/catppuccin/nvim",
    as = "catppuccin",
  },
  -- {
  --   "wfxr/minimap.vim",
  --   config = function()
  --     -- vim.g.
  --   end
  -- },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    module = "trouble",
    config = function()
      require("trouble").setup {}
      -- TODO: doesn't sets keys
      lvim.builtin.which_key.mappings["t"] = {
        name = "+Trouble",
        r = { "<cmd>Trouble lsp_references<cr>", "References" },
        f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
        d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
        q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
        l = { "<cmd>Trouble loclist<cr>", "LocationList" },
        w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
      }
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = {
          "gitcommit", "gitrebase", "svn", "hgcommit",
        },
        lastplace_open_folds = true,
      })
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("persistence").setup {
        dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      }
      lvim.builtin.which_key.mappings["S"] = {
        name = "Session",
        c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
        l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
        Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "itchyny/vim-cursorword",
    event = { "BufEnter", "BufNewFile" },
    config = function()
      vim.api.nvim_command("augroup user_plugin_cursorword")
      vim.api.nvim_command("autocmd!")
      vim.api.nvim_command("autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")
      vim.api.nvim_command("autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif")
      vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
      vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
      vim.api.nvim_command("augroup END")
    end
  },
  {
    "turbio/bracey.vim",
    cmd = { "Bracey", "BracyStop", "BraceyReload", "BraceyEval" },
    run = "npm install --prefix server",
  },
  {
    "dbeniamine/cheat.sh-vim"
  },
  {
    "mickael-menu/zk-nvim",
    ft = "markdown",
    config = function()
      require("zk").setup({
        picker = "telescope"
      })
      vim.cmd [[set backupcopy=yes]]
      lvim.builtin.which_key.mappings["z"] = {
        name = "Zettelkasten",
        n = { "<cmd>ZkNew{ title = vim.fn.input('Title: ') }<CR>", "New note" },
        N = { "<cmd>'<,'>ZkNewFromTitleSelection<CR>", "New note (Title from VISUAL)" },
        b = { "<cmd>ZkBacklinks<CR>", "Notes linking to the current buffer" },
        l = { "<Cmd>ZkLinks<CR>", "Notes linked by the current buffer" },
        z = { "<cmd>ZkNotes {sort = { 'modified' }}<CR>", "List notes" },
        Z = { "<cmd>'<,'>ZkMatch<CR>", "List notes matching visual" },
        t = { "<cmd>ZkTags<CR>", "List tags" },
        ["d"] = {
          name = "Diary",
          d = { "<cmd>ZkNew{dir = 'journal/daily'}<CR>", "New daily note" },
          w = { "<cmd>ZkNew{dir = 'journal/weekly'}<CR>", "New weekly note" },
          m = { "<cmd>ZkNew{dir = 'journal/monthly'}<CR>", "New monthly note" },
        }
      }
    end
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    requires = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap' },
    config = function()
      require("flutter-tools").setup {
        debugger = {
          -- enabled = true,
          -- run_via_dap = true,
        },
        -- flutter_lookup_cmd = "$(which flutter)",
        widget_guides = {
          enabled = true,
        },
        dev_tools = {
          auto_open_browser = true,
        },
        outline = {
          auto_open = true,
        },
      }
      require("telescope").load_extension("flutter")
      lvim.builtin.which_key.mappings["r"] = {
        name = "Flutter",
        r = { "<cmd>FlutterRun<CR>", "Run the current project" },
        m = { "<cmd>FlutterDevices<CR>", "A list of connected devices to select from" },
        e = { "<cmd>FlutterEmulators<CR>", "A list of emulators to select from" },
        h = { "<cmd>FlutterReload<CR>", "Reload the running project" },
        H = { "<cmd>FlutterRestart<CR>", "Restart the current project" },
        Q = { "<cmd>FlutterQuit<CR>", "Ends a running session" },
        q = { "<cmd>FlutterDetach<CR>", "Ends a running session locally but keeps the process running on the device" },
        o = { "<cmd>FlutterOutlineToggle<CR>", "The outline window showing the widget tree for the given file" },
        d = { "<cmd>FlutterDevTools<CR>", "Starts a Dart Dev Tools server" },
        D = { "<cmd>FlutterCopyProfilerUrl<CR>", "Copies the profiler url to your system clipboard" },
        L = { "<cmd>FlutterLspRestart<CR>", "Restart LSP server" },
        s = { "<cmd>FlutterSuper<CR>", "Go to super class" },
        R = { "<cmd>FlutterReanalyze<CR>", "Forces LSP server reanalyze" },
        c = { "<cmd>Telescope flutter commands<CR>", "List flutter commands" },
      }
    end
  },
  {
    "p00f/nvim-ts-rainbow",
    config = function()
      lvim.builtin.treesitter.rainbow.enable = true
    end
  },
  {
    "dccsillag/magma-nvim",
  },
}

local types = require("luasnip.util.types")
require 'luasnip'.config.setup({
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { "●", "GruvboxOrange" } }
      }
    },
    [types.insertNode] = {
      active = {
        virt_text = { { "●", "GruvboxBlue" } }
      }
    }
  },
})
require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/lvim/snippets" })

-- Additional Plugins config
vim.g.minimap_auto_start = 1
vim.g.minimap_width = 10
vim.g.livepreview_previewer = "zathura"

-- TODO: keybindings for Additional Plugins
-- FIX: Bracey doesn't compile .ts
