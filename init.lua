--
--       ┬ ┬╔═╗┬─┐┌─┐┬┌─
--       └┬┘║ ║├┬┘├┤ ├┴┐
--        ┴ ╚═╝┴└─└─┘┴ ┴    NeoVim
--

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]] --

require('lazy').setup({
  'tpope/vim-sleuth',
  { 'numToStr/Comment.nvim', opts = {} },
  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').add {
        { "<leader>c", group = "[C]ode" },
        { "<leader>c_", hidden = true },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>d_", hidden = true },
        { "<leader>h", group = "Git [H]unk" },
        { "<leader>h_", hidden = true },
        { "<leader>r", group = "[R]ename" },
        { "<leader>r_", hidden = true },
        { "<leader>s", group = "[S]earch" },
        { "<leader>s_", hidden = true },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>t_", hidden = true },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>w_", hidden = true },
      }
      -- visual mode
      require('which-key').add(
        {{ "<leader>h", desc = "Git [H]unk", mode = "v" },}
      )
    end,
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      'nvim-telescope/telescope-ui-select.nvim',

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          -- set path display
          path_display = {
            shorten = {
              len = 1,
            }
          },
          layout_strategy = 'horizontal',
          layout_config = {
            bottom_pane = {
              height = 25,
              preview_cutoff = 120,
              prompt_position = "top"
            },
            center = {
              height = 0.4,
              preview_cutoff = 40,
              prompt_position = "top",
              width = 0.5
            },
            cursor = {
              height = 0.9,
              preview_cutoff = 40,
              width = 0.8
            },
            horizontal = {
              height = 0.9,
              preview_cutoff = 70,
              preview_width = 0.5,
              prompt_position = "bottom",
              width = 0.8
            },
            vertical = {
              height = 0.9,
              preview_cutoff = 40,
              prompt_position = "bottom",
              width = 0.8
            },
            -- set layout scroll_speed
            scroll_speed = 1
          },
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>si', builtin.lsp_incoming_calls, { desc = '[S]earch Lsp [I]ncomming Calls' })
      vim.keymap.set('n', '<leader>so', builtin.lsp_outgoing_calls, { desc = '[S]earch Lsp [O]utgoing Calls' })
      vim.keymap.set('n', '<leader>st', builtin.lsp_type_definitions, { desc = '[S]earch Lsp [T]ype Definitions' })
      vim.keymap.set('n', '<leader>sy', builtin.lsp_dynamic_workspace_symbols, { desc = '[S]earch Lsp Workspace S[y]mbols' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- { -- You can easily change to a different colorscheme.
  --   -- Change the name of the colorscheme plugin below, and then
  --   -- change the command in the config to whatever the name of that colorscheme is.
  --   --
  --   -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  --   'folke/tokyonight.nvim',
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   init = function()
  --     -- Load the colorscheme here.
  --     -- Like many other themes, this one has different styles, and you could load
  --     -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  --     vim.cmd.colorscheme 'tokyonight-night'
  --
  --     -- You can configure highlights by doing something like:
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },

  { 'norcalli/nvim-colorizer.lua' },
  -- {
  --   name = 'mokyo.nvim',
  --   dir = '/home/yorek/.local/share/nvim/lazy/mokyo.nvim',
  --   dev = true,
  --   priority = 1000,
  --   init = function()
  --     vim.cmd.colorscheme 'tokyonight'
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      local spec_treesitter = require'mini.ai'.gen_spec.treesitter
      require('mini.ai').setup {
        custom_textobjects = {
          -- a = mapped to args by mini.ai
          f = spec_treesitter({
            a = '@function.outer',
            i = '@function.inner',
          }),
          -- u = spec_treesitter({
          --    a = '@class.outer',
          --    i = '@class.outer', -- only outer is available
          -- }),
          -- j = spec_treesitter({
          --   a = '@loop.outer',
          --   i = '@loop.inner',
          -- }),
          -- o = spec_treesitter({
          --   a = '@block.outer',
          --   i = '@block.inner',
          -- }),
          -- r = spec_treesitter({
          --   a = '@parameter.outer',
          --   i = '@parameter.inner',
          -- }),
          -- i = spec_treesitter({
          --   a = '@conditional.outer',
          --   i = '@conditional.inner',
          -- }),
          -- m = spec_treesitter({
          --   a = '@comment.outer',
          --   i = '@comment.outer', -- only outer is available
          -- }),
          -- c = spec_treesitter({
          --   a = '@call.outer',
          --   i = '@call.inner',
          -- }),
          -- d = spec_treesitter({
          --   a = '@statement.outer',
          --   i = '@statement.inner',
          -- }),
        },
        n_lines = 1000,
      }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- Mode -----------------------------------------------------------------------
      -- Custom `^V` and `^S` symbols to make this file appropriate for copy-paste
      -- (otherwise those symbols are not displayed).
      local CTRL_S = vim.api.nvim_replace_termcodes('<C-S>', true, true, true)
      local CTRL_V = vim.api.nvim_replace_termcodes('<C-V>', true, true, true)
      -- stylua: ignore start
      local modes = setmetatable({
        ['n']    = { long = 'NORMAL',   short = 'N',   hl = 'MiniStatuslineModeNormal' },
        ['v']    = { long = 'VISUAL',   short = 'V',   hl = 'MiniStatuslineModeVisual' },
        ['V']    = { long = 'V-LINE',   short = 'V-L', hl = 'MiniStatuslineModeVisual' },
        [CTRL_V] = { long = 'V-BLOCK',  short = 'V-B', hl = 'MiniStatuslineModeVisual' },
        ['s']    = { long = 'SELECT',   short = 'S',   hl = 'MiniStatuslineModeVisual' },
        ['S']    = { long = 'S-LINE',   short = 'S-L', hl = 'MiniStatuslineModeVisual' },
        [CTRL_S] = { long = 'S-BLOCK',  short = 'S-B', hl = 'MiniStatuslineModeVisual' },
        ['i']    = { long = 'INSERT',   short = 'I',   hl = 'MiniStatuslineModeInsert' },
        ['R']    = { long = 'REPLACE',  short = 'R',   hl = 'MiniStatuslineModeReplace' },
        ['c']    = { long = 'COMMAND',  short = 'C',   hl = 'MiniStatuslineModeCommand' },
        ['r']    = { long = 'PROMPT',   short = 'P',   hl = 'MiniStatuslineModeOther' },
        ['!']    = { long = 'SHELL',    short = 'SH',  hl = 'MiniStatuslineModeOther' },
        ['t']    = { long = 'TERMINAL', short = 'T',   hl = 'MiniStatuslineModeOther' },
      }, {
      -- By default return 'Unknown' but this shouldn't be needed
      __index = function()
        return   { long = 'Unknown',  short = 'U',   hl = '%#MiniStatuslineModeOther#' }
      end,
      })
      -- stylua: ignore end

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_mode = function(args)
        local mode_info = modes[vim.fn.mode()]
        local mode = statusline.is_truncated(args.trunc_width) and mode_info.short or mode_info.long

        return mode, mode_info.hl
      end
      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'cpp', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.nvimlsp',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
  require 'kickstart.plugins.cmp',
  require 'kickstart.plugins.colorschema',
  require 'kickstart.plugins.conform',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    border = 'rounded',
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
