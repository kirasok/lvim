-- general
lvim.log.level = "warn"
lvim.format_on_save = true

-- ui
lvim.transparent_window = true
lvim.colorscheme = "onedark"
vim.opt.wrap = true
vim.opt.conceallevel = 2

-- spell
vim.opt.spell = true -- enable only in specific files
vim.opt.spelllang = { "en", "es", "ru" }
lvim.keys.insert_mode["<C-l>"] = "<Esc>[s1z=`]a"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- User config for builtin plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

-- nvimtree
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

-- remove buffer as source
local sources_to_delete = {
  "buffer",
}
local new_sources = vim.tbl_filter(function(source)
  return not vim.tbl_contains(sources_to_delete, source.name)
end, lvim.builtin.cmp.sources)
lvim.builtin.cmp.cmdline.enable = true

vim.list_extend(new_sources, {
  { name = "git",  priority_weight = 110 },
  { name = "papis" },
})

lvim.builtin.cmp.sources = new_sources

-- lsp installer
lvim.lsp.installer.setup.automatic_installation = false   -- do not install lsp server automatically
--require("lvim.lsp.manager").setup("dartls"); WARN: flutter-tools.nvim setup dartls themselves
require("lvim.lsp.manager").setup("nil")                  -- nix
require("lvim.lsp.manager").setup("clangd")               -- c/c++
require("lvim.lsp.manager").setup("texlab")               -- latex
require("lvim.lsp.manager").setup("pyright")              -- python
require("lvim.lsp.manager").setup("yaml-language-server") -- yaml (why not?)
require("lvim.lsp.manager").setup("lemminx")              -- xml (why not?)
require("lvim.lsp.manager").setup("kotlin-language-server")
require("lvim.lsp.manager").setup("gopls")

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "prettier" }, -- markdown/js/etc
}
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "flake8" }, -- python
}
local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
}

-- highlight luasnip nodes
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
vim.g.livepreview_previewer = "zathura"

-- Trouble keybinds BUG:should be move to it's respective plugin but not work here
lvim.builtin.which_key.mappings["t"] = {
  name = "Trouble",
  t = { "<cmd>Trouble<cr>", "Trouble" },
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
}

-- TODO: keybindings for Additional Plugins
-- FIX: Bracey doesn't compile .ts

-- Additional Plugins
lvim.plugins = {
  {
    -- Colorize colors
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, {
        names    = true,  -- "Name" codes like Blue
        hsl_fn   = false, -- CSS hsl() and hsla() functions
        RGB      = true,  -- #RGB hex codes
        RRGGBB   = true,  -- #RRGGBB hex codes
        RRGGBBAA = true,  -- #RRGGBBAA hex codes
        rgb_fn   = true,  -- CSS rgb() and rgba() functions hsl_fn = true, -- CSS hsl() and hsla() functions css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn   = true,  -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  {
    -- Print function signature in popup window
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require "lsp_signature".on_attach() end,
  },
  {
    -- Outline of symobls in right bar
    "simrat39/symbols-outline.nvim",
    config = function()
      require('symbols-outline').setup()
    end
  },
  {
    -- list checkers messages
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    -- open fiels in the last place you left
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
    -- Colorize words
    "folke/todo-comments.nvim",
    dependencies = { "folke/trouble.nvim", },
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    -- highlight cursor word
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
    -- live js server
    "turbio/bracey.vim",
    cmd = { "Bracey", "BracyStop", "BraceyReload", "BraceyEval" },
    build = "npm install --prefix server",
  },
  {
    -- manage zettelkasten
    "mickael-menu/zk-nvim",
    ft = "markdown",
    config = function()
      require("zk").setup({
        picker = "telescope"
      })
      vim.cmd [[set backupcopy=yes]]
      lvim.builtin.which_key.mappings["z"] = {
        name = "Zettelkasten",
        n = { "<cmd>ZkNew{ title = vim.fn.input('Title: '), dir = vim.fn.input('Dir: ', './') }<CR>", "New note" },
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
    -- autoclose and autorename html tags
    "windwp/nvim-ts-autotag",
    ft = "html",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    -- tools to use with flutter
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    dependencies = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap' },
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
    -- rainbow parentheses
    "p00f/nvim-ts-rainbow",
    config = function()
      lvim.builtin.treesitter.rainbow.enable = true
      require("nvim-treesitter.configs").setup {
        rainbow = {
          enable = true,
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        }
      }
    end
  },
  {
    -- better %
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    -- diffview for git
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    -- know whom to blame for this code
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      require('gitblame').disable() -- BUG: not works (see https://github.com/f-person/git-blame.nvim/issues/65)
    end,
  },
  {
    -- show current ccontext eg class -> function -> loop
    "romgrk/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup {
        enable = true,   -- Enable this plugin (Can be enabled/disabled later via commands)
        throttle = true, -- Throttles plugin updates (may improve performance)
        max_lines = 0,   -- How many lines the window should span. Values <= 0 mean no limit.
        patterns = {
          -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
          -- For all filetypes
          -- Note that setting an entry here replaces all other patterns for this entry.
          -- By setting the 'default' entry below, you can control which nodes you want to
          -- appear in the context window.
          default = {
            'class',
            'function',
            'method',
          },
        },
      }
    end
  },
  {
    -- removes all unnecessary views and centers text
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
      }
    end
  },
  -- TODO: fix appearing in markdown outside latex context
  -- {
  --   -- snippets for latex, thanks iurimateus and gillescastel
  --   "iurimateus/luasnip-latex-snippets.nvim",
  --   ft = { "tex", "markdown" },
  --   dependencies = { "L3MON4D3/LuaSnip", "nvim-treesitter/nvim-treesitter" },
  --   config = function()
  --     require 'luasnip-latex-snippets'.setup({ use_treesitter = true })
  --   end,
  -- },
  {
    -- configs texlab to sync cursor position with zathura BUG: not working
    'f3fora/nvim-texlabconfig',
    ft = { 'tex', 'bib' },
    config = function()
      require('texlabconfig').setup()
      local lspconfig = require('lspconfig')
      local executable = 'zathura'
      local args = {
        '--synctex-editor-command',
        [[nvim-texlabconfig -file '%{input}' -line %{line}]],
        '--synctex-forward',
        '%l:1:%f',
        '%p',
      }

      lspconfig.texlab.setup({
        settings = {
          texlab = {
            build = {
              executable = 'latexmk',
              args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
              onSave = true,
              forwardSearchAfter = true,
            },
            chktex = {
              onOpenAndSave = true,
            },
            forwardSearch = {
              executable = executable,
              args = args,
            },
            formatterLineLength = 0,
          },
        },
      })
    end,
    build = 'go build -o ~/.local/bin/'
  },
  {
    -- conceal things for better document editing
    'KeitaNakamura/tex-conceal.vim',
    ft = "tex",
    config = function()
      vim.g["tex_conceal"] = "abdgm"
    end,
  },
  {
    -- plugin to sync .py with .ipynb
    "untitled-ai/jupyter_ascending.vim",
    ft = "python",
    config = function()
      lvim.builtin.which_key.mappings["r"] = {
        name = "Jupyter",
        r = { "<cmd>call jupyter_ascending#execute()<CR>", "Execute cell" },
        R = { "<cmd>call jupyter_ascending#execute_all()<CR>", "Execute all cells" },
        q = { "<cmd>call jupyter_ascending#restart()<CR>", "Restart kernel" },
      }
    end,
  },
  {
    -- preview markdown
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    init = function()
      vim.g.mkdp_filetypes = {
        "markdown"
      }
    end,
  },
  {
    -- ledger plugin for (neo)vim
    "ledger/vim-ledger",
    ft = { "ledger" },
  },
  {
    -- paste image from clipboard
    -- WARN: use of fork until upstream fixes health
    "kirasok/clipboard-image.nvim",
    ft = { "markdown" },
    config = function()
      require 'clipboard-image'.setup {
        default = {
          img_dir = { "%:p:h", "static" } -- Relative to current file
        },
        markdown = {
          img_dir = { "%:p:h", "static" },
          img_dir_txt = "static",
          affix = "![clipboard_img](%s)"
        }
      }
    end,
  },
  {
    -- surround with parentheses
    'kylechui/nvim-surround',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  {
    "luizribeiro/vim-cooklang",
    ft = { "cook" },
  },
  { 'navarasu/onedark.nvim' },
  -- {
  --   "jghauser/papis.nvim",
  --   dependencies = {
  --     "kkharji/sqlite.lua",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function()
  --     require("papis").setup({
  --     })
  --   end,
  -- },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = { --[[ things you want to change go here]] }
  },
  {
    'kirasok/cmp-hledger',
    ft = "ledger",
    config = function()
      local cmp = require('cmp')
      local config = cmp.get_config()
      table.insert(config.sources, {
        name = 'hledger',
      })
      cmp.setup(config)
    end
  },
  { url = 'https://github.com/73/vim-klog' }
}

lvim.keys.insert_mode["<C-f>"] =
"<cmd>exec '.!inkscape-figures create '.getline('.').' ./figures/'<CR><CR>"
lvim.keys.normal_mode["<C-f>"] =
"<cmd>exec '!inkscape-figures edit ./figures/ > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>"
lvim.keys.insert_mode["<C-k>"] = require("luasnip.extras.select_choice")
lvim.keys.insert_mode["jj"] = "<ESC>"
