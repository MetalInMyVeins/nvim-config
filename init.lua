-- ==========================
-- Keymap Logs
-- ==========================
-- n | <leader>;   | Show diagnostics in floating window
-- n | <S-M>       | Open nvim-tree
-- n | W           | Focus nvim-tree if open
-- n | <leader>[   | Create new tab with nvim-tree
-- n | <leader>]   | Close current tab
-- n | <leader>'   | Show LSP hover documentation (lspsaga)
-- n | <leader>q   | Close SnipRun window
-- n | <leader>h   | View notification history (telescope)
-- n | <leader>-   | Number Python cells (# %%)
-- n | <leader>c   | Evaluate current Python cell (Molten)
-- n | <leader>r   | Run selected Python code block (Molten)
-- n | <leader>p   | Enter molten output window
-- n | <leader>0   | Show/enter molten output (noautocmd)
-- n | <leader>g   | Jump to Python cell by number (custom)
-- n | ]c          | Jump to next Python cell (custom)
-- n | [c          | Jump to previous Python cell (custom)
-- n | <localleader>mi | Initialize Molten (Python kernel)
-- n | <localleader>e  | Evaluate motion/operator (Molten)
-- n | <localleader>rl | Evaluate current line (Molten)
-- n | <localleader>rr | Re-evaluate current cell (Molten)
-- v | <localleader>r  | Evaluate visual selection (Molten)
-- n | <F5>        | Run entire file with SnipRun
-- n | <C-K>       | Run current Python cell (# %%) with SnipRun
-- n | <C-P>       | Run current Python cell with Molten
-- n | <leader>\   | Toggle floaterm
-- n | <S-T>       | Launch floaterm
-- n | <C-S>       | Enter normal mode
-- t | <C-S>       | Toggle floaterm
-- t | <ESC><ESC>  | Enter normal mode in floaterm
-- t | <leader><BS> | Enter normal mode in floaterm
-- n | <leader><BS> | Toggle Molten virtual output
-- n | <C-D>       | Save file
-- i | <C-D>       | Save file
-- n | <C-A>       | Select all
-- i | <C-A>       | Select all
-- n | <C-L>       | Safe exit Vim (handles unsaved buffers)
-- n | <C-Q>       | Force quit current file
-- n | <S-Q>       | Next tab
-- n | <S-Tab>     | Previous tab
-- n | =           | Go to end of line
-- n | -           | Go to start of line
-- n | <leader>d   | Toggle spell check
-- n | <leader>s   | Toggle symbol table of current file (outline.nvim)
-- n | <Alt-M>     | Go to end of line and enter insert mode (a)
-- n | <Alt-N>     | Go to start of line and enter insert mode (i)
-- n | <Alt-O>     | Insert line above (o) and go back
-- i | <Alt-[>     | Exit insert mode
-- i | <Alt-H>     | Move left in insert mode
-- i | <Alt-J>     | Move down in insert mode
-- i | <Alt-K>     | Move up in insert mode
-- i | <Alt-L>     | Move right in insert mode
-- i | <Tab>       | Jump past closing brace/quote if possible
-- n | <leader>=   | Jump to specific window (nvim-window)
-- n | <F12>       | Toggle breakpoint (DAP)
-- n | <F11>       | Continue debugging (DAP)
-- n | <F8>        | Step over (DAP)
-- n | <F9>        | Step into (DAP)
-- n | <F10>       | Step out (DAP)
-- n | <leader>dr  | Open DAP REPL
--
-- t | j           | Scroll 3 lines down in floaterm
-- t | k           | Scroll 3 lines up in floaterm
--
-- Notes:
-- - <leader> = "\"
-- - <localleader> = "\"
-- - :SendCell <n> sends a specific Python cell to tmux (custom command)
-- - :Pycell renumbers all Python cells marked with # %%




-- ==========================
-- Plugin Manager Setup
-- ==========================
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- optionally enable 24-bit colour
vim.opt.termguicolors = true

if not vim.o.sessionoptions:match("localoptions") then
  vim.o.sessionoptions = vim.o.sessionoptions .. ",localoptions"
end


require("lazy").setup({
  spec =
  {
    {
      "voldikss/vim-floaterm",
      cmd = { "FloatermToggle", "FloatermNew", "FloatermNext", "FloatermPrev" },
    },
    {
      --"preservim/nerdtree",
    },
    {
      --"Xuyuanp/nerdtree-git-plugin",
    },
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies =
      {
        "nvim-tree/nvim-web-devicons",
      },
    },
    {
      "airblade/vim-gitgutter",
    },
    {
      --"lewis6991/gitsigns.nvim",
    },
    {
      "OXY2DEV/markview.nvim",
      lazy = false,
    },
    {
      "nvim-treesitter/nvim-treesitter",
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    {
      "nvim-tree/nvim-web-devicons",
    },
    {
      "echasnovski/mini.icons",
    },
    {
      "neovim/nvim-lspconfig",
    },
    {
      "nvimdev/lspsaga.nvim",
      dependencies =
      {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
      }
    },
    {
      "DetachHead/basedpyright",
    },
    {
      'hrsh7th/cmp-nvim-lsp',
    },
    {
      'hrsh7th/cmp-buffer',
    },
    {
      'hrsh7th/cmp-path',
    },
    {
      'hrsh7th/cmp-cmdline',
    },
    {
      'hrsh7th/nvim-cmp',
      opts = function(_, opts)
        opts.sources = opts.sources or {}
        table.insert(opts.sources, {
          name = "lazydev",
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        })
      end,
    },
    {
      'hrsh7th/cmp-vsnip',
    },
    {
      'hrsh7th/vim-vsnip',
    },
    {
      'hrsh7th/vim-vsnip-integ',
    },
    {
      "lukas-reineke/indent-blankline.nvim",
    },
    {
      "HiPhish/rainbow-delimiters.nvim",
    },
    {
      --"petertriho/nvim-scrollbar",
      --event = "VeryLazy",
    },
    {
      "kylechui/nvim-surround",
      version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies =
      {
        'nvim-tree/nvim-web-devicons',
      }
    },
    {
      "michaelb/sniprun",
      cmd = { "SnipRun", },
      branch = "master",
      build = "sh install.sh",
    },
    {
      "folke/noice.nvim",
      event = "VeryLazy",
      dependencies =
      {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
      }
    },
    {
      "nvim-telescope/telescope.nvim",
      cmd = { "Telescope", },
      branch = '0.1.x',
      dependencies =
      {
        'nvim-lua/plenary.nvim',
      },
    },
    {
      'RRethy/vim-illuminate',
    },
    {
      'tikhomirov/vim-glsl',
    },
    {
      'mfussenegger/nvim-dap',
    },
    {
      "rcarriga/nvim-dap-ui",
      dependencies =
      {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
      },
    },
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    --[[{
      'mfussenegger/nvim-dap-python',
    },]]--
    {
      'klen/nvim-config-local',
    },
    {
      "kwkarlwang/bufresize.nvim",
      config = function()
        require("bufresize").setup()
      end
    },
    {
      --'github/copilot.vim',
      --config = function()
        --require("copilot").setup()
      --end
    },
    {
      "benlubas/molten-nvim",
      --version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
      dependencies = { "3rd/image.nvim" },
      build = ":UpdateRemotePlugins",
      init = function()
        -- Configure molten-nvim
        vim.g.molten_image_provider = "image.nvim"
        vim.g.molten_output_win_max_height = 20
        vim.g.molten_output_win_hide_on_leave = true
        vim.g.molten_image_location = "float"
        vim.g.molten_virt_text_output = true
        vim.g.molten_auto_open_output = false
        vim.g.molten_auto_image_popup = false
        vim.g.molten_use_border_highlights = true
        vim.g.molten_output_win_style = "minimal"
        vim.g.molten_output_virt_lines = false
        vim.g.molten_output_show_more = true
      end,
    },
    {
      "3rd/image.nvim",
      opts = {
        backend = "ueberzug", -- kitty or "ueberzug" etc., based on terminal
        processor = "magick_cli",
        max_width = 100,
        max_height = 12,
        max_height_window_percentage = math.huge,
        max_width_window_percentage = math.huge,
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = true,
            download_remote_images = true,
            only_render_image_at_cursor = true,
            only_render_image_at_cursor_mode = "float",
            floating_windows = true,
            filetypes = { "markdown", "vimwiki" },
          },
        },
        --[[integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            only_render_image_at_cursor_mode = "popup",
            floating_windows = false, -- if true, images will be rendered in floating markdown windows
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
          },
          neorg = {
            enabled = true,
            filetypes = { "norg" },
          },
          typst = {
            enabled = true,
            filetypes = { "typst" },
          },
          html = {
            enabled = false,
          },
          css = {
            enabled = false,
          },
        },--]]
      }
    },
    --[[{
      "sphamba/smear-cursor.nvim",
      opts =
      {
        -- Smear cursor when switching buffers or windows.
        smear_between_buffers = true,

        -- Smear cursor when moving within line or to neighbor lines.
        -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
        smear_between_neighbor_lines = true,

        -- Draw the smear in buffer space instead of screen space when scrolling
        scroll_buffer_space = true,

        -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
        -- Smears will blend better on all backgrounds.
        legacy_computing_symbols_support = true,

        -- Smear cursor in insert mode.
        -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
        smear_insert_mode = false,
      },
    },--]]
    --[[{
      "echasnovski/mini.nvim",
      version = '*',
      config = function()
        require('mini.animate').setup()
      end
    },--]]
    {
      "karb94/neoscroll.nvim",
      opts = {},
    },
    --[[{
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      ---@type snacks.Config
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        picker = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
      },
    },]]--
    --[[{
      'goolord/alpha-nvim',
      config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
      end
    },]]--
    {
      "folke/twilight.nvim",
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
      config = function()
        require('twilight').setup({})
      end
    },
    {
      --"eandrju/cellular-automaton.nvim",
    },
    {
      "shellRaining/hlchunk.nvim",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("hlchunk").setup({
          chunk = {
            enable = true,
          },
        })
      end
    },
    --[[{
      "nvimtools/none-ls.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
    },]]--
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
      -- use opts = {} for passing setup options
      -- this is equivalent to setup({}) function
    },
    {
      "Vimjas/vim-python-pep8-indent",
    },
    {
      "numToStr/Comment.nvim",
      -- Usage: `gc` for visual block, `gcc` for single line
      opts = {
        -- add any options here
      },
      config = function()
        require("Comment").setup({
        })
      end
    },
    {
      "yorickpeterse/nvim-window",
      keys = {
        { "<leader>=", "<cmd>lua require('nvim-window').pick()<cr>", desc = "nvim-window: Jump to window" },
      },
      config = true,
    },
    {
      "hedyhli/outline.nvim",
      config = function()
        -- Example mapping to toggle outline
        vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

        require("outline").setup {
        -- Your setup opts here (leave empty to use defaults)
        }
      end,
    },
    --[[{
      'goerz/jupytext.nvim',
      version = '0.2.0',
      opts = {},  -- see Options
    },
    {
      "GCBallesteros/jupytext.nvim",
      config = true,
     --Depending on your nvim distro or config you may need to make the loading not lazy
     --lazy=false,
    },]]--
    {
      "folke/persistence.nvim",
      event = "BufReadPre", -- this will only start session saving when an actual file was opened
      opts = {
        -- add any custom options here
      }
    },
    {
      "natecraddock/sessions.nvim",
      config = function()
        require("sessions").setup {
        }
      end,
    },
    {
      'isakbm/gitgraph.nvim',
      opts = {
        git_cmd = "git",
        symbols = {
          merge_commit = 'M',
          commit = '*',
        },
        format = {
          timestamp = '%H:%M:%S %d-%m-%Y',
          fields = { 'hash', 'timestamp', 'author', 'branch_name', 'tag' },
        },
        hooks = {
          on_select_commit = function(commit)
            print('selected commit:', commit.hash)
          end,
          on_select_range_commit = function(from, to)
            print('selected range:', from.hash, to.hash)
          end,
        },
      },
      keys = {
        {
          "<leader>gl",
          function()
            require('gitgraph').draw({}, { all = true, max_count = 5000 })
          end,
          desc = "GitGraph - Draw",
        },
      },
      symbols = {
        merge_commit = '',
        commit = '',
        merge_commit_end = '',
        commit_end = '',

        -- Advanced symbols
        GVER = '',
        GHOR = '',
        GCLD = '',
        GCRD = '╭',
        GCLU = '',
        GCRU = '',
        GLRU = '',
        GLRD = '',
        GLUD = '',
        GRUD = '',
        GFORKU = '',
        GFORKD = '',
        GRUDCD = '',
        GRUDCU = '',
        GLUDCD = '',
        GLUDCU = '',
        GLRDCL = '',
        GLRDCR = '',
        GLRUCL = '',
        GLRUCR = '',
      },
    },
  },
  install =
  {
    colorscheme = { "habamax" }
  },
  checker =
  {
    enabled = true,
  },
})




--[[vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    require("smear-cursor").enabled = false
  end,
})--]]

require('config-local').setup{
  -- Default options (optional)

  -- Config file patterns to load (lua supported)
  config_files = { ".nvim.lua", ".nvimrc", ".exrc" },

  -- Where the plugin keeps files data
  hashfile = vim.fn.stdpath("data") .. "/config-local",

  autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
  commands_create = true,     -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalDeny)
  silent = false,             -- Disable plugin messages (Config loaded/denied)
  lookup_parents = false,     -- Lookup config files in parent directories
}

--[[require("jupytext").setup({
  style = "hydrogen",
  output_extension = "auto",  -- Default extension. Don't change unless you know what you are doing
  force_ft = nil,  -- Default filetype. Don't change unless you know what you are doing
  custom_language_formatting = {
    python = {
      extension = "md",
      style = "markdown",
      force_ft = "markdown", -- you can set whatever filetype you want here
    },
  },
})]]--

vim.keymap.set("v", "<leader>r", ":<C-u>MoltenEvaluateVisual<CR>", { desc = "Molten: Run Visual Selection" })
vim.keymap.set("n", "<leader>c", ":MoltenReevaluateCell<CR>", { desc = "Molten: Evaluate Current Cell" })



-- ============================
-- Global Options
-- ============================
vim.opt.updatetime = 300
vim.g.python3_host_prog = 'python3'

-- Diagnostic floating window: wrap text and limit max width
vim.diagnostic.config({
  virtual_text = {
    spacing = 2,
    severity_limit = "Warning",
    -- You can truncate long messages by using `format` instead of wrap
    --[[format = function(diagnostic)
      -- Truncate message to 80 characters and append ellipsis
      local msg = diagnostic.message
      if #msg > 30 then
        return msg:sub(1, 27) .. "..."
      end
      return msg
    end,--]]
  },
  float = {
    border = "rounded",
    max_width = 80,        -- Limit width to prevent overflow
    wrap = true,           -- Enable word wrap (Neovim 0.10+)
    focusable = true,
    source = true,
  },
  update_in_insert = false,
  severity_sort = true,
})

--[[
-- Open diagnostics on floating window when cursor is on offending
-- line.
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      focus = false,
      border = "rounded",
      max_width = 80,
      wrap = true, -- Only in Neovim 0.10+
    })
  end,
})--]]

-- Manually open diagnostic window when cursor is on offending
-- line.
vim.keymap.set("n", "<leader>;", function()
  vim.diagnostic.open_float(nil, {
    focus = false,
    border = "rounded",
    max_width = 80,
    wrap = true, -- Only in Neovim 0.10+
  })
end, { desc = "Show diagnostics in float" })



-- Number python cells correctly when saving python files
--[[vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local new_lines = {}
    local cell_count = 1

    for i, line in ipairs(lines) do
      local trimmed = vim.trim(line)
      if trimmed:match("^# %%%%") then
        -- Replace line with numbered cell marker
        new_lines[i] = "# %% [" .. cell_count .. "]"
        cell_count = cell_count + 1
      else
        new_lines[i] = line
      end
    end

    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
  end,
})]]--



-- :Pycell, Number python cells manually by running :Pycell
vim.api.nvim_create_user_command("Pycell", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[bufnr].filetype
  if filetype ~= "python" then
    print("This command only works on Python files.")
    return
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local new_lines = {}
  local cell_count = 1

  for i, line in ipairs(lines) do
    local trimmed = vim.trim(line)
    if trimmed:match("^# %%%%") then
      new_lines[i] = "# %% [" .. cell_count .. "]"
      cell_count = cell_count + 1
    else
      new_lines[i] = line
    end
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
  print("Updated " .. (cell_count - 1) .. " cells.")
end, { desc = "Renumber Python cells marked with # %%" })

vim.keymap.set("n", "<leader>-", ":Pycell<CR>:w<CR>", { desc = "Number python cells" })





-- Jump to Python cell by number
function GotoPythonCell(num)
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for i, line in ipairs(lines) do
    if line:match("^# %%%% %[(" .. num .. ")%]") then
      vim.api.nvim_win_set_cursor(0, { i, 0 })
      vim.cmd("normal! zz")  -- center cursor
      vim.notify("Jumped to cell " .. num, vim.log.levels.INFO)
      return
    end
  end

  vim.notify("Cell " .. num .. " not found.", vim.log.levels.WARN)
end

-- Command: :GotoCell 3
vim.api.nvim_create_user_command("GotoCell", function(opts)
  local num = tonumber(opts.args)
  if not num then
    vim.notify("Usage: :GotoCell <number>", vim.log.levels.ERROR)
    return
  end
  GotoPythonCell(num)
end, { nargs = 1 })

-- Optional keymap: <leader>g then enter cell number
vim.keymap.set("n", "<leader>g", function()
  local input = vim.fn.input("Cell number: ")
  local num = tonumber(input)
  if num then
    GotoPythonCell(num)
  else
    vim.notify("Invalid number.", vim.log.levels.ERROR)
  end
end, { desc = "Go to Python cell by number" })





-- Navigate between Python cells marked as "# %% ..."
local function goto_next_cell()
  local cur_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")

  for i = cur_line + 1, total_lines do
    if vim.fn.getline(i):match("^%s*# %%%%") then
      vim.api.nvim_win_set_cursor(0, { i, 0 })
      vim.cmd("normal! zz")
      vim.notify("Next cell", vim.log.levels.INFO)
      return
    end
  end
  vim.notify("No next cell found.", vim.log.levels.WARN)
end

local function goto_prev_cell()
  local cur_line = vim.fn.line(".")

  for i = cur_line - 1, 1, -1 do
    if vim.fn.getline(i):match("^%s*# %%%%") then
      vim.api.nvim_win_set_cursor(0, { i, 0 })
      vim.cmd("normal! zz")
      vim.notify("Previous cell", vim.log.levels.INFO)
      return
    end
  end
  vim.notify("No previous cell found.", vim.log.levels.WARN)
end

vim.keymap.set("n", "]c", goto_next_cell, { desc = "Go to next Python cell (# %%)" })
vim.keymap.set("n", "[c", goto_prev_cell, { desc = "Go to previous Python cell (# %%)" })





-- Send python cell to tmux denoted by `# %% [<n>]`
-- Usage:
-- :SendCell <n>
-- Dependency:
-- ~/.bin/sendcell
-- tmux session should be started by:
-- tmux new -s py
vim.api.nvim_create_user_command('SendCell', function(opts)
  local file = vim.fn.expand('%')
  local cmd = string.format("sendcell %s %s", file, opts.args)
  vim.cmd("!" .. cmd)
end, { nargs = 1 })



-- Awesome Tab-out feature!
-- nvim-autopairs provides autocompletion of braces and quotes
-- Going past the closing braces or quotes is a pain with arrows
-- This enables going past them pressing Tab
vim.keymap.set("i", "<Tab>", function()
  local col = vim.fn.col(".")
  local line = vim.fn.getline(".")
  local next_char = line:sub(col, col)
  if next_char:match("[%]%)}'\"]") then
    return "<Right>"
  else
    return "<Tab>"
  end
end, { expr = true, noremap = true })





-- ========================
-- Plugin Settings
-- ========================
-- nerdtree ---------------
--[[vim.cmd([[
" Start NERDTree, unless a file or session is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | NERDTree | endif | execute "normal! \<C-W>w"

" NERDTree window size
let g:NERDTreeWinSize=23
" Show hidden files
let g:NERDTreeShowHidden=1
]]--]]

--vim.api.nvim_set_keymap('n', '<S-M>', [[:NERDTree<CR>]], { silent = true })





-- nerdtree-git --------------
--[[vim.cmd([[
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
]]--]]





-- nvim-tree ------------------
require("nvim-tree").setup(
{
  sort =
  {
    sorter = "case_sensitive",
  },
  view =
  {
    width = 23,
    signcolumn = "no",
    side = "left",
    number = false,
    relativenumber = false,
    float =
    {
      enable = false,
    }
  },
  renderer =
  {
    group_empty = true,
    symlink_destination = false,
    root_folder_label = function(path)
      local max_len = 24 -- Set your desired max length
      local shortened = vim.fn.fnamemodify(path, ":~") -- use ~/ instead of full home
      if #shortened > max_len then
        return "…" .. string.sub(shortened, -max_len + 1)
      else
        return shortened
      end
    end,
  },
  filters =
  {
    dotfiles = false,
  },
  git =
  {
    ignore = false,
  },
})

-- Open nvim-tree if any file is specified, else no.
-- Create a global flag like s:std_in = 1 if reading from stdin
vim.api.nvim_create_autocmd("StdinReadPre", {
  callback = function()
    vim.g.std_in = 1
  end,
})
-- On VimEnter, only open nvim-tree if no files and not reading from stdin or session
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and vim.g.std_in == nil and vim.v.this_session == '' then
      require("nvim-tree.api").tree.open()
      vim.cmd("wincmd w")
    end
  end,
})

vim.cmd [[
hi! NvimTreeNormal cterm=bold gui=bold guifg=#a8775f
hi! NvimTreeExecFile cterm=bold gui=bold guifg=#008000
hi! NvimTreeSymlink cterm=bold,italic gui=bold,italic guifg=#a8775f
hi! NvimTreeSymlinkIcon cterm=bold,italic gui=bold,italic guifg=NvimLightCyan
hi! NvimTreeFileIcon cterm=bold gui=bold guifg=DeepSkyBlue2
hi! NvimTreeRootFolder cterm=bold gui=bold guifg=DeepSkyBlue4
hi! NvimTreeFolderName cterm=bold gui=bold guifg=DeepSkyBlue3
hi! NvimTreeOpenedFolderName cterm=bold gui=bold guifg=DeepSkyBlue2
hi! NvimTreeFolderIcon cterm=bold gui=bold guifg=DeepSkyBlue2
hi! NvimTreeOpenedFolderIcon cterm=bold gui=bold guifg=DeepSkyBlue2
hi! NvimTreeClosedFolderIcon cterm=bold gui=bold guifg=DeepSkyBlue2
hi! NvimTreeSymlinkFolderName cterm=bold,underline gui=bold,underline guifg=Red
hi! NvimTreeEmptyFolderName cterm=bold gui=bold guifg=Grey32
]]

vim.keymap.set('n', '<S-M>', [[:NvimTreeOpen<CR>]])

vim.keymap.set("n", "W", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.bo[buf].filetype
    if ft == "NvimTree" then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
  vim.notify("nvim-tree is not open", vim.log.levels.WARN)
end, { desc = "Focus nvim-tree if open" })





-- vim-gitgutter ---------------
vim.g.gitgutter_enabled = 0
--vim.keymap.set('n', '<leader>g', [[:GitGutterToggle<CR>]])





-- treesitter --------------------
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "python", "html", "typst", "yaml", "r", "java", "kotlin", "csv", "json", "css", "cmake", "rust", "bash", "fish", "regex", "groovy", "jsonc", "yuck", "scss", "ini", "toml", "hyprlang", "latex", "gitignore" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    --[[disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,--]]

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}





-- markview -----------------------
require("markview").setup({
  experimental = {
    check_rtp_message = false, -- Hide the message
    -- check_rtp = false, -- Or disable the check and fix entirely if you're sure
  },
  -- other markview.nvim options
})

require("markview.extras.checkboxes").setup({
    --- Default checkbox state(used when adding checkboxes).
    ---@type string
    default = "X",

    --- Changes how checkboxes are removed.
    ---@type
    ---| "disable" Disables the checkbox.
    ---| "checkbox" Removes the checkbox.
    ---| "list_item" Removes the list item markers too.
    remove_style = "disable",

    --- Various checkbox states.
    ---
    --- States are in sets to quickly change between them
    --- when there are a lot of states.
    ---@type string[][]
    states = {
        { " ", "/", "X" },
        { "<", ">" },
        { "?", "!", "*" },
        { '"' },
        { "l", "b", "i" },
        { "S", "I" },
        { "p", "c" },
        { "f", "k", "w" },
        { "u", "d" }
    }
})

require("markview.extras.editor").setup();
require("markview.extras.headings").setup();





-- nvim-lspconfig ---------------------
vim.lsp.enable('basedpyright')


local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.enable('clangd')
vim.lsp.config('clangd', {
  cmd = {
    "clangd",
    "--clang-tidy=false",
    "--header-insertion=never",
    "--completion-style=detailed",
    "--all-scopes-completion",
    "--include-ineligible-results"
  },
  capabilities = capabilities,
})


vim.lsp.enable('r_language_server')


vim.lsp.enable('cmake')
vim.lsp.config('cmake-language-server',
{
  cmd = { "cmake-language-server" },
})


vim.lsp.enable('jdtls')
vim.lsp.config('jdtls',
{
  cmd = { "jdtls" },
  on_attach = function(client, bufnr)
    if client.name == "jdtls" then
      vim.diagnostic.config({
        update_in_insert = false,
      }, bufnr)
    end
  end,
})


vim.lsp.enable('bashls')


vim.lsp.enable('fish_lsp')
vim.lsp.config('fish_lsp',
{
  cmd = { "fish-lsp", "start" },
  cmd_env = { fish_lsp_show_client_popups = false },
  filetypes = { "fish" },
  root_markers = { ".git" },
})


--[[vim.lsp.enable('rls')
vim.lsp.config('rls', {
  settings = {
    rust = {
      unstable_features = true,
      build_on_save = false,
      all_features = true,
    },
  },
})
vim.lsp.enable('rust_analyzer')
vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true;
      }
    }
  }
})


vim.lsp.enable('kotlin_language_server')
vim.lsp.config('kotlin_language_server',
{
  cmd = { "kotlin-language-server" },
  filetypes = { "kotlin" },
  root_dir = require("lspconfig.util").root_pattern("settings.gradle", "build.gradle", ".git"),
})--]]


--vim.lsp.enable('lua_ls')
vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      local uv = vim.uv or vim.loop
      if
        path ~= vim.fn.stdpath('config')
        and (uv.fs_stat(path .. '/.luarc.json') or uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths
          -- here.
          -- '${3rd}/luv/library'
          -- '${3rd}/busted/library'
        }
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})


-- basedpyright
--local lspconfig = require("lspconfig")
--lspconfig.basedpyright.setup{}





-- nvim-cmp ---------------------------
-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

      -- For `mini.snippets` users:
      -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
      -- insert({ body = args.body }) -- Insert at cursor
      -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
      -- require("cmp.config").set_onetime({ sources = {} })
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    --['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ['<CR>'] = cmp.mapping(function(fallback)
      if cmp.visible() and cmp.get_selected_entry() then
        cmp.confirm({ select = false })
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    {
      name = 'path',
      option = {
        pathMappings = {
        ['@'] = '${folder}/src',
        -- ['/'] = '${folder}/src/public/',
        -- ['~@'] = '${folder}/src',
        -- ['/images'] = '${folder}/src/images',
        -- ['/components'] = '${folder}/src/components',
        },
      },
    },
    { name = 'buffer', },
  }),
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})
require("cmp_git").setup()--]]

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)


-- Set up lspconfig.
--local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--require('lspconfig')['basedpyright'].setup {
--  capabilities = capabilities
--}
--require('lspconfig')['clangd'].setup {
--  capabilities = capabilities
--}


--[[local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').clangd.setup {
  cmd = {
    "clangd",
    "--clang-tidy=false",
    "--header-insertion=never",
    "--completion-style=detailed",
    "--all-scopes-completion",
    "--include-ineligible-results",
  },
  capabilities = capabilities,
}]]--


-- nvim-cmp Tab completion
--local cmp = require'cmp'

--[[cmp.setup({
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ['<CR>'] = cmp.mapping(function(fallback)
      if cmp.visible() and cmp.get_selected_entry() then
        cmp.confirm({ select = false })
      else
        fallback()
      end
    end, { "i", "s" }),
  }
})--]]





-- lspsaga ----------------------------
require('lspsaga').setup(
{
  lightbulb =
  {
    enable = true,
    sign = false,
  },
  breadcrumb =
  {
    enable = true,
  },
  signature_help =
  {
    enable = true,
  },
})

-- view docs: <leader>'
vim.keymap.set('n', "<leader>'", [[:Lspsaga hover_doc<CR>]])

vim.keymap.set("i", "<C-E>", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end, { desc = "Close floating windows" })





-- indent-blankline -------------
--local highlight = {
--  "RainbowRed",
--  "RainbowYellow",
--  "RainbowBlue",
--  "RainbowOrange",
--  "RainbowGreen",
--  "RainbowViolet",
--  "RainbowCyan",
--}
local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  --vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  --vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  --vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  --vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  --vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  --vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  --vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#CD5C5C" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#FFD700" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#00FFFF" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#00FF00" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#8A2BE2" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#FF4500" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#8B008B" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup
{
  scope = { highlight = highlight },
  indent = { highlight = highlight, smart_indent_cap = true, },
}
hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    require("ibl").setup_buffer(0, { enabled = false })
  end,
})





-- scrollbar ----------------------
--require("scrollbar").setup()





-- nvim-surround ------------------
require("nvim-surround").setup()

vim.cmd([[
hi Vert1 guibg=NONE guifg=#5e87ff gui=bold cterm=bold
hi Vert2 guibg=NONE guifg=#d7875f gui=bold cterm=bold
]])





-- lualine ------------------------
local custom_gruvbox = require'lualine.themes.gruvbox'
-- #a89984
local Vert1 = '#5e87ff'
--local Vert2 = '#d7875f'
--local Vert2 = '#d6453c'
local Vert2 = '#2f885c'
-- Change the background of lualine_c section for normal mode
custom_gruvbox.normal.a.bg = Vert2
custom_gruvbox.normal.b.bg = '#303030'
--custom_gruvbox.normal.c.bg = '#303030'
custom_gruvbox.normal.c.bg = '#1c1c1c'

--custom_gruvbox.normal.a.fg = '#5e87ff'
custom_gruvbox.normal.b.fg = Vert2
custom_gruvbox.normal.c.fg = Vert2

custom_gruvbox.insert.a.bg = Vert1
custom_gruvbox.insert.b.bg = '#303030'
custom_gruvbox.insert.c.bg = '#1c1c1c'

custom_gruvbox.insert.a.fg = '#1c1c1c'
custom_gruvbox.insert.b.fg = Vert2
custom_gruvbox.insert.c.fg = Vert2

custom_gruvbox.visual.a.bg = '#008000'
custom_gruvbox.visual.b.bg = Vert2
custom_gruvbox.visual.c.bg = '#1c1c1c'

custom_gruvbox.visual.a.fg = '#1c1c1c'
custom_gruvbox.visual.b.fg = '#1c1c1c'
custom_gruvbox.visual.c.fg = Vert2

--custom_gruvbox.inactive.a.bg = ''
--custom_gruvbox.inactive.b.bg = ''
custom_gruvbox.inactive.c.bg = '#1c1c1c'

--custom_gruvbox.inactive.a.fg = '#1c1c1c'
--custom_gruvbox.inactive.b.fg = '#1c1c1c'
custom_gruvbox.inactive.c.fg = '#4e4e4e'

--custom_gruvbox.command.a.bg = ''
--custom_gruvbox.command.b.bg = ''
custom_gruvbox.command.c.bg = '#1c1c1c'

--custom_gruvbox.command.a.fg = '#1c1c1c'
--custom_gruvbox.command.b.fg = '#1c1c1c'
custom_gruvbox.command.c.fg = '#4e4e4e'

require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = custom_gruvbox,
    --component_separators = { left = '', right = ''},
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    --lualine_c = {'filename'},
    lualine_c =
    {
      {
        'filename',
        path = 1,  -- optional: 0 = just name, 1 = relative, 2 = absolute
        --[[color = function()
          if vim.bo.modified then
            return { fg = 'DeepPink3', gui = 'bold' } -- Modified: orange and bold
          end
        end,--]]
        symbols = {
          modified = '', -- Optional: show [+] if modified
          readonly = '',
          unnamed = '[No Name]',
        }
      },
      {
        function()
          if vim.bo.readonly then
            return '[RO]'
          elseif vim.bo.modified then
            return '[+]'
          else
            return ''
          end
        end,
        --color = { fg = 'Cyan', gui = 'bold' }, -- Customize color
        color = function()
          if vim.bo.readonly then
            return { fg = 'Cyan', gui = 'bold' }
          elseif vim.bo.modified then
            return { fg = 'DeepPink3', gui = 'bold' }
          else
            return { fg = 'None', }
          end
        end,
        padding = { left = 0, right = 0 },
      },
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    --lualine_z = {'location'}
    lualine_z = {
    {
      function()
        local current_line = vim.fn.line('.')
        local total_lines = vim.fn.line('$')
        local col = vim.fn.col('.')
        local line_content = vim.fn.getline('.')
        local total_cols = vim.fn.strdisplaywidth(line_content)

        --local progress = math.floor((current_line / total_lines) * 100)
        --return string.format("%2d%%%% | %d/%d | %d:%d", progress, current_line, total_lines, col, total_cols)
        return string.format(" %d:%d☰ %d:%d", current_line, total_lines, col, total_cols)
      end,
      icon = '', -- optional, you can set an icon
      padding = 1
    }}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
})





-- sniprun -------------------
require'sniprun'.setup({
  snipruncolors = {
    SniprunVirtualTextOk   =  {bg="#66eeff", fg="#000000", ctermbg="Cyan", ctermfg="Black"},
    SniprunFloatingWinOk   =  {fg="#66eeff", ctermfg="Cyan"},
    SniprunVirtualTextErr  =  {bg="#881515", fg="#000000", ctermbg="DarkRed", ctermfg="Black"},
    SniprunFloatingWinErr  =  {fg="#881515", ctermfg="DarkRed", bold=true},
  },

  display =
  {
    --"Classic",                    --# display results in the command-line  area
    --"VirtualTextOk",              --# display ok results as virtual text (multiline is shortened)
    --"VirtualTextErr",

    "VirtualText",             --# display results as virtual text
    --"VirtualLine",             --# display results as virtual lines
    --"TempFloatingWindow",      --# display results in a floating window
    --"LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText[Ok/Err]
    --"Terminal",                --# display results in a vertical split
    "TerminalWithCode",        --# display results and code history in a vertical split
    -- "NvimNotify",              --# display with the nvim-notify plugin
    -- "Api"                      --# return output to a programming interface 
  },

  display_options =
  {
    terminal_width = 40
  },

  --live_display = { "VirtualTextOk" },
  --live_mode_toggle = 'on',

  selected_interpreters = {"Python3_fifo"},     --# use those instead of the default for the current filetype
  repl_enable = {"Python3_fifo"},               --# enable REPL-like behavior for the given interpreters
  repl_disable = {},              --# disable REPL-like behavior for the given interpreters
})

_G.saved_cursor = nil
-- Select current # %% code block
function SelectPythonCell()
  _G.saved_cursor = vim.api.nvim_win_get_cursor(0) -- {line, col}
  local start_pat = "^%s*# %%%%.*"
  local end_pat = "^%s*# %%%%.*"
  local cur_line = vim.fn.line(".")
  local start = cur_line
  local end_ = cur_line
  local total_lines = vim.fn.line("$")

  -- Search upwards for the start
  while start > 1 do
    local line = vim.fn.getline(start)
    if string.match(line, start_pat) and start ~= cur_line then
      break
    end
    start = start - 1
  end

  -- Search downwards for the end
  while end_ < total_lines do
    local line = vim.fn.getline(end_ + 1)
    if string.match(line, end_pat) then
      break
    end
end_ = end_ + 1
  end

  -- Visually select the block
  vim.cmd(string.format("%d", start + 1))
  vim.cmd("normal! V")
  vim.cmd(string.format("%d", end_))
end

function GotoLine()
  vim.api.nvim_win_set_cursor(0, _G.saved_cursor)
end

vim.g.molten_auto_open_output = true
vim.g.molten_auto_close_output = false
vim.cmd([[
"nnoremap <F5> :let b:caret = winsaveview()<CR>:%SnipRun<CR>:call winrestview(b:caret)<CR>
]])
vim.api.nvim_set_keymap('n', '<C-K>', [[:lua SelectPythonCell()<CR>:SnipRun<CR>:lua GotoLine()<CR>]], { silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', [[:SnipClose<CR>]], { silent = true })
vim.api.nvim_set_keymap('n', '<F5>', ':lua b_caret = vim.fn.winsaveview()<CR>:%SnipRun<CR>:lua vim.fn.winrestview(b_caret)<CR>', { noremap = true, silent = false })



-- molten.nvim ----------------------------------
vim.keymap.set("n", "<localleader>mi", ":MoltenInit python<CR>",
    { silent = true, desc = "Initialize the plugin" })
vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>",
    { silent = true, desc = "run operator selection" })
vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>",
    { silent = true, desc = "evaluate line" })
vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>",
    { silent = true, desc = "re-evaluate cell" })
vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
    { silent = true, desc = "evaluate visual selection" })

vim.api.nvim_set_keymap('n', '<C-P>', [[:lua SelectPythonCell()<CR><ESC>:MoltenEvaluateVisual<CR>:lua GotoLine()<CR>]], { silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', [[:MoltenEnterOutput<CR>]], { silent = true })
-- Enter cursor in molten output window
vim.keymap.set("n", "<leader>0", ":noautocmd MoltenEnterOutput<CR>", { silent = true, desc = "show/enter output" })
vim.keymap.set("n", "<leader><BS>", ":MoltenToggleVirtual<CR>", { silent = true, desc = "toggle molten virtual output" })




-- image.nvim -------------------------------
--[[require("image").setup({
  backend = "ueberzug",
  processor = "magick_rock", -- or "magick_rock"
  integrations = {
    markdown = {
      enabled = true,
      clear_in_insert_mode = true,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      only_render_image_at_cursor_mode = "popup",
      floating_windows = false, -- if true, images will be rendered in floating markdown windows
      filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
    },
    neorg = {
      enabled = true,
      filetypes = { "norg" },
    },
    typst = {
      enabled = true,
      filetypes = { "typst" },
    },
    html = {
      enabled = false,
    },
    css = {
      enabled = false,
    },
  },
  max_width = nil,
  max_height = nil,
  max_width_window_percentage = nil,
  max_height_window_percentage = 50,
  window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
  window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
  editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
  tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
})
--]]





-- noice ---------------------------
require("noice").setup({
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = true, -- use a classic bottom cmdline for search
    command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
})





-- telescope ----------------------
--require('telescope').load_extension("persisted")
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
-- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

vim.keymap.set('n', '<leader>h', [[:Telescope notify<CR>]])





-- notify --------------------
require("notify").setup({
  background_colour = "#1e1e2e", -- or any solid background you prefer
})





-- lazydev -------------------
require("lazydev").setup({
  library = { "nvim-dap-ui" },
})





-- vim-illuminate --------------------
require('illuminate').configure({
  delay = 200,
})

-- Then override highlights
vim.api.nvim_set_hl(0, 'IlluminatedWordText', { underline = true, bg = '#550000' })
vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { underline = true, bg = '#003355' })
vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { underline = true, bg = '#003300' })





-- outline -------------------
vim.keymap.set('n', '<leader>s', [[:Outline<CR>]])





-- vim-glsl ----------------------------
vim.cmd([[
autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl
]])





-- neoscroll ---------------------------
--[[require('neoscroll').setup({
  mappings = {                 -- Keys to be mapped to their corresponding default scrolling animation
    '<C-u>', '<C-d>',
    '<C-b>', '<C-f>',
    '<C-y>', '<C-e>',
    'zt', 'zz', 'zb',
  },
  hide_cursor = true,          -- Hide cursor while scrolling
  stop_eof = true,             -- Stop at <EOF> when scrolling downwards
  respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
  cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
  duration_multiplier = 1.0,   -- Global duration multiplier
  easing = 'linear',           -- Default easing function
  pre_hook = nil,              -- Function to run before the scrolling animation starts
  post_hook = nil,             -- Function to run after the scrolling animation ends
  performance_mode = false,    -- Disable "Performance Mode" on all buffers.
  ignored_events = {           -- Events ignored while scrolling
      'WinScrolled', 'CursorMoved'
  },
})]]--





-- nvim-dap ------------------
local dap = require("dap")
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}





-- dap-python -----------------
--require("dap-python").setup("python3")
-- If using the above, then `python3 -m debugpy --version`
-- must work in the shell


-- Example setup for nvim-dap and dap-python
--local dap = require('dap')
local dapui = require("dapui")

-- DAP UI setup
dapui.setup()

-- Auto-open and close DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.keymap.set('n', '<F12>', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<F11>', function() require('dap').continue() end)
vim.keymap.set('n', '<F8>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F9>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)





-- vim-persistence -----------------------
-- load the session for the current directory
vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end)
-- select a session to load
vim.keymap.set("n", "<leader>qS", function() require("persistence").select() end)
-- load the last session
vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end)
-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end)

-- Reopen nvim-tree in all tabs after restoring a persistence session
vim.api.nvim_create_autocmd("SessionLoadPost", {
    callback = function()
        local api = require("nvim-tree.api")

        -- Iterate through all tabs restored by the session
        for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
            vim.api.nvim_set_current_tabpage(tab)
            api.tree.open()
        end
    end,
})






-- ===========================
-- Functions
-- ===========================
vim.cmd([[
" automatic line wrap if textwidth exceeds 67
function! SetupTxtFormat67()
  setlocal textwidth=67
  setlocal formatoptions+=t
  setlocal formatoptions-=c
  setlocal formatoptions-=r
  setlocal formatoptions-=o
  setlocal formatoptions+=l
  setlocal wrap
  setlocal linebreak
  setlocal noautoindent
  setlocal formatprg=par\ 67q
  " Use a custom keybinding to format paragraphs with 3-space indent
  nnoremap <buffer> <leader>f vip:!par 67q\ -p3<CR>
endfunction



" automatic line wrap if textwidth exceeds 163
function! SetupTxtFormat163()
  setlocal textwidth=163
  setlocal formatoptions+=t
  setlocal formatoptions-=c
  setlocal formatoptions-=r
  setlocal formatoptions-=o
  setlocal formatoptions+=l
  setlocal wrap
  setlocal linebreak
  setlocal noautoindent
  setlocal formatprg=par\ 163q
  " Use a custom keybinding to format paragraphs with 3-space indent
  nnoremap <buffer> <leader>f vip:!par 163q\ -p3<CR>
endfunction



" func: SafeExitVim
" Invoke with <C-L> to exit vim.
" In exit, it checks for any unsaved buffers,
" doesn't exit if any unsaved buffer exists.
" Kills floaterm if exiting would be okay,
" doesn't kill if exiting is not okay.
function! SafeExitVim()
    let unsaved_buffers = filter(range(1, bufnr('$')), 'bufexists(v:val) && getbufvar(v:val, "&modified") && getbufvar(v:val, "&filetype") != "floaterm"')

    if empty(unsaved_buffers)
        FloatermKill!
        qa
    else
        let unsaved_names = map(unsaved_buffers, 'bufname(v:val)')
        echo "Unsaved buffers detected. Vim will not exit. Unsaved buffers: " . join(unsaved_names, ", ")
    endif
endfunction



" func: MyTabLine
" CUSTOM TABLINE
set tabline=%!MyTabLine()  " custom tab pages line
function! MyTabLine()
  let s = ''
  " loop through each tab page
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#' " WildMenu
    else
      "let s .= '%#Title#'
    endif
    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T '
    " set page number string
    let s .= 'Tab '
    let s .= i + 1 . ':'
    " get buffer names and statuses
    let n = ''  " temp str for buf names
    let m = 0   " &modified counter
    let buflist = tabpagebuflist(i + 1)
    let bufcount = 0
    " loop through each buffer in a tab
    for b in buflist
      if getbufvar(b, "&buftype") == 'help'
        " let n .= '[H]' . fnamemodify(bufname(b), ':t:s/.txt$//')
      elseif getbufvar(b, "&buftype") == 'quickfix'
        " let n .= '[Q]'
      elseif getbufvar(b, "&modifiable")
        if bufname(b) != ''
          if bufcount > 0
            let n .= ' | '
          endif
          let n .= fnamemodify(bufname(b), ':t')
          let bufcount += 1
        endif
      endif
      if getbufvar(b, "&modified")
        let m += 1
      endif
    endfor
    " add modified label
    if m > 0
      let s .= '+'
    endif
    if i + 1 == tabpagenr()
      let s .= ' %#TabLineSel#'
    else
      let s .= ' %#TabLine#'
    endif
    " add buffer names
    if n == ''
      let s.= '[New]'
    else
      let s .= n
    endif
    " switch to no underlining and add final space
    let s .= ' '
  endfor
  let s .= '%#TabLineFill#%T'
  return s
endfunction



" func: FileSizeLimit
" Function to get file size in bytes
function! FileSizeLimit(max_size_in_MB)
  let max_size_bytes = a:max_size_in_MB * 1024 * 1024  " Convert MB to bytes
  " Get file information
  let file_info = getfsize(expand('%'))
  " If file does not exist or is unreadable, return true (to avoid unexpected errors)
  if file_info == -1
    return 1
  endif
  " If file size is greater than max size, return false
  if file_info > max_size_bytes
    echohl WarningMsg
    echom "File is too large to open in vim (greater than " . a:max_size_in_MB . " MB)."
    echohl None
    return 0
  endif
  " If file size is within limit, return true
  return 1
endfunction
]])





-- ===========================
-- Syntax and Environment
-- ===========================
vim.opt.mouse = "a"

vim.cmd([[
set ttimeout        " time out for key codes
set ttimeoutlen=0 " wait up to 0ms after Esc for special key

" Change cursor shape in different modes.
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" From Nvim 0.10.0, they changed the default colorscheme and
" made termguicolors enabled by default. So I had to override
" these here.
"colorscheme vim
"set notermguicolors

set mouse=a

syntax on

set showmatch
hi MatchParen cterm=bold,underline ctermbg=black ctermfg=green

set cursorline

set number
set tabstop=2 shiftwidth=2 expandtab
set whichwrap+=<,>,[,]
"autocmd FileType python setlocal shiftwidth=2 tabstop=2 expandtab autoindent

set autoindent
set smartindent

set clipboard=unnamedplus

" show commands in lower right screen
set showcmd

set encoding=utf-8

" Return to last edit position when opening files
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif


" aarch64 Assembly
autocmd FileType asm setlocal smartindent
" Automatically set filetype to ARM assembly for .S or .s files
autocmd BufRead,BufNewFile *.s set filetype=asm


" Set .bangu files to use C++ indentation
autocmd BufRead,BufNewFile *.bongo set filetype=s
autocmd BufRead,BufNewFile *.bg set filetype=s
autocmd BufRead,BufNewFile *.bir set filetype=s

set wildmode=longest,list
set wildmenu
" Keep cursor line vertically centered
"set scrolloff=999

" Turn on neovim session management
"set sessionoptions=blank,buffers,curdir,folds,help,options,tabpages,winsize

" Set tab width to 2 spaces for Python files
"autocmd FileType python setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType java setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType rust setlocal ts=2 sts=2 sw=2 expandtab

augroup python_indent
  autocmd! * <buffer>
  autocmd BufEnter,BufNewFile *.py setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
augroup END

augroup java_indent
  autocmd! * <buffer>
  autocmd BufEnter,BufNewFile *.java setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END

" Only apply to .txt files
autocmd BufRead,BufNewFile *.txt call SetupTxtFormat67()
" Only apply to .note files
autocmd BufRead,BufNewFile *.note call SetupTxtFormat163()
" Autocmd to check file size on BufRead.
" Don't open file larger than 100 MiB
autocmd BufReadPre * if !FileSizeLimit(150) | q | endif
]])










-- ===========================
-- Keymaps
-- ===========================
vim.cmd([[
map <C-D> <ESC>:w<Enter>
imap <C-D> <ESC>:w<Enter>

"map <C-E> <ESC>:wqa<Enter>
"imap <C-E> <ESC>:wqa<Enter>

map <C-A> <ESC>ggVG<Enter>
imap <C-A> <ESC>ggVG<Enter>

nnoremap <silent> <C-L> :call SafeExitVim()<CR>
map <C-Q> <ESC>:q!<Enter>

" next tab
map <S-Q> <ESC>:tabn<Enter>
" previous tab
map <S-Tab> <ESC>:tabp<Enter>

" open new tab with NERDTree
map <leader>[ <ESC>:tabnew<Enter><S-M><C-W>w
" close the current tab
map <leader>] <ESC>:tabclose<Enter>

" In vim-floaterm normal mode, scroll 3 lines per keypress
" by pressing j/k.
" Enter normal mode by pressing double ESC.
autocmd FileType floaterm nnoremap <buffer> j 3jzz
autocmd FileType floaterm nnoremap <buffer> k 3kzz
" Automatically open a floaterm window when Vim starts
"autocmd VimEnter * FloatermNew --height=0.9 --width=0.77

autocmd VimEnter * call s:StartFloatermAndSend()
" Nvim starts, create a floaterm silently, check if
" .envrc contains in current directory, if exists, reload
" the environment in floaterm by sending the command to floaterm.
function! s:StartFloatermAndSend() abort
  " Open Floaterm with specified size
  FloatermNew --silent --height=0.9 --width=0.77
  " Check for specific file (e.g., .envrc)
    if filereadable(".envrc")
      " Wait a bit to ensure Floaterm initializes, then send the command
      call timer_start(100, { -> execute('FloatermSend direnv reload') })
    endif
endfunction
" Automatically close all floaterm windows when neovim exits
"autocmd VimLeave * FloatermKill!
autocmd QuitPre * FloatermKill!

command Fmt :%!astyle --mode=c --style=allman -s2

command LaunchFloaterm :FloatermNew --height=0.9 --width=0.77 --wintype=float --name=floaterm1 --title=Floaterm --position=center --autoclose=1
" Run command under vim statusline.
command! -nargs=1 Cmd echo system(<q-args>)

command Pyrun :FloatermSend tput setaf 4 && echo "RUNNING...." && tput setaf 45 && python src/main.py

map <C-]> <ESC>:Pyrun<Enter><C-\><C-N>:FloatermToggle<CR>
"-------------------------
map <S-T> <ESC>:LaunchFloaterm<Enter>
" Enter into normal mode in floating terminal
tnoremap <Esc><Esc> <C-\><C-n>
tnoremap <leader><BS> <C-\><C-n>
map <leader>\ :FloatermToggle<CR>
"map <C-B> <ESC><S-T>bdrn<Enter>
"map <C-B> <ESC>:FloatermToggle<Enter>bdrn<Enter>
"tnoremap <C-S> <C-\><C-N>:FloatermToggle<CR>
imap <C-S> <C-\><C-N>

nnoremap = $
nnoremap - ^
" Toggle spell check
map <leader>d :setlocal spell!<CR>
"map <leader> :wincmd =<CR>
map <leader>t :Twilight<CR>

map <M-.> :vert res +5<CR>
map <M-,> :vert res -5<CR>
]])


-- ================
-- Custom Commands
-- ================
vim.cmd([[
command! CompileCxx :FloatermSend bash -c 'tput setaf 4; echo -n "Compiling "; tput setaf 45; echo -n %; tput setaf 4; echo " ..."; clang++ -std=c++20 -g -Wall -Wextra -Wpedantic -Werror -Wno-unused-variable -Wno-unused-private-field -Wno-unused-parameter %:p -o vimbin && echo "done"; tput sgr0;'

command! CompileCxxRun :FloatermSend bash -c 'tput setaf 4; echo -n "Compiling "; tput setaf 45; echo -n %; tput setaf 4; echo " ..."; clang++ -std=c++20 -g -Wall -Wextra -Wpedantic -Werror -Wno-unused-variable -Wno-unused-private-field -Wno-unused-parameter %:p -o vimbin && echo "Running..." && tput setaf 45 && ./vimbin; tput sgr0;'

command! ScriptRun :FloatermSend bash -c 'bash script.sh $@'
]])


-- =======================
-- Custom Command Keymaps
-- =======================
-- Compile current buffer C++ program in floaterm
vim.keymap.set('n', '<S-J>', [[:CompileCxx<CR><C-\><C-N>:FloatermToggle<CR>]])
-- Compile and run current buffer C++ program in floaterm
vim.keymap.set('n', '<C-J>', [[:CompileCxxRun<CR><C-\><C-N>:FloatermToggle<CR>]])


-- Navigate in insert mode
-- Alt+h/j/k/l
vim.keymap.set('i', '<M-h>', '<Left>')
vim.keymap.set('i', '<M-j>', '<Down>')
vim.keymap.set('i', '<M-k>', '<Up>')
vim.keymap.set('i', '<M-l>', '<Right>')

-- Set wrapping to prevent words from being cut mid-word
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "↪ "

-- For long lines, j, k navigation doesn't work: they go
-- through the entire line. This enables navigation by
-- screen lines.
-- Normal mode
vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })
-- Visual mode
vim.keymap.set("v", "j", "gj", { noremap = true })
vim.keymap.set("v", "k", "gk", { noremap = true })


-- Go to end of line and insert (a) mode: Alt+M
vim.keymap.set('n', '<M-m>', '$a')
-- Go to start of line and insert (i) mode: Alt+N
vim.keymap.set('n', '<M-n>', '^i')
-- Go to normal mode conveniently: Alt+[
vim.keymap.set('i', '<M-[>', '<ESC>')
-- Go to insert mode (o) and go back
-- to the previous line: Alt+o
vim.keymap.set('n', '<M-o>', 'o<Up>')

vim.keymap.set('n', '<C-B>', [[:FloatermSend bdrn<CR><C-\><C-N>:FloatermToggle<CR>]])
vim.keymap.set('n', '<S-B>', [[:FloatermSend bd<CR><C-\><C-N>:FloatermToggle<CR>]])
vim.keymap.set('n', '<C-V>', [[:FloatermSend tput setaf 4 && echo "Running build.sh ...." && tput setaf 0 && bash build.sh && tput setaf 4 && echo "done"<CR><C-\><C-N>:FloatermToggle<CR>]])

-- Hide floaterm in terminal mode
vim.keymap.set('t', '<C-S>', [[<C-\><C-N>:FloatermToggle<CR>]])

-- Run script.sh from current directory
vim.keymap.set('n', '<S-F>', [[:ScriptRun<CR><C-\><C-N>:FloatermToggle<CR>]])

-- Insert "# %%" in current line and go to next line
vim.keymap.set("n", "<S-P>", function()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { "# %%" })
end, { desc = "Insert '# %%' at current line" })

-- Function to handle Shift+Enter in Python files
local function python_shift_enter()
  -- Get current line number
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  
  -- Calculate target lines (n+2 and n+3)
  local target_line1 = current_line + 2
  local target_line2 = current_line + 3
  
  -- Insert blank lines if needed
  local line_count = vim.api.nvim_buf_line_count(0)
  if target_line2 > line_count then
    local lines_to_add = target_line2 - line_count
    vim.api.nvim_buf_set_lines(0, line_count, line_count, false, vim.fn["repeat"]({""}, lines_to_add))
  end
  
  -- Insert # %% in n+2 line
  vim.api.nvim_buf_set_lines(0, target_line1 - 1, target_line1 - 1, false, {"# %%"})
  
  -- Move cursor to n+3 line and enter insert mode
  vim.api.nvim_win_set_cursor(0, {target_line2, 0})
  vim.cmd("startinsert")
end

-- Set up the keymap for Python files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.keymap.set("i", "<S-CR>", python_shift_enter, { buffer = true })
  end
})

-- ===========================
-- Highlights
-- ===========================
vim.cmd([[
runtime colors/default-copy.vim

hi Custom1 cterm=bold guifg=#a8775f
hi Custom2 cterm=bold guifg=Orange4
hi Custom3 cterm=bold guifg=Grey46
hi Custom4 cterm=bold guifg=Gold3
hi Custom5 cterm=bold guibg=#ff0000
hi Vert1 guibg=NONE guifg=#5e87ff gui=bold cterm=bold
"hi Vert2 guibg=NONE guifg=#00ff87
"hi Vert2 guibg=NONE guifg=#d7875f gui=bold cterm=bold
"hi Vert2 guibg=NONE guifg=#d6453c gui=bold cterm=bold
hi Vert2 guibg=NONE guifg=#2f885c gui=bold cterm=bold
hi Vert3 guibg=NONE guifg=#d70056
hi Vert4 guibg=none guifg=#5e87ff gui=bold cterm=bold
hi Vert5 guibg=NONE guifg=#008000 gui=bold cterm=bold

hi Normal cterm=bold gui=bold guibg=none guifg=#a0a0a0
hi Comment cterm=none guifg=Grey30
hi Function cterm=bold guifg=Green4
hi EndOfBuffer cterm=bold guifg=#000000  " tildes (~)

hi Type cterm=bold,italic guifg=DeepSkyBlue4  "005faf

hi LineNr cterm=none guifg=Grey30

hi Cursor cterm=bold ctermfg=9 guibg=NONE guifg=red
"hi CursorLine gui=none guibg=Grey15 cterm=bold
"hi CursorLine gui=underline,bold guibg=none guisp=#2f885c
hi CursorLine gui=underline,bold guibg=none guisp=Grey27
hi CursorLineNr gui=none guifg=Red1 cterm=bold
hi Include cterm=bold,italic guifg=#a8775f
hi String cterm=bold guifg=SandyBrown

"hi VertSplit cterm=bold guifg=#ff0000 guibg=#ff0000
"hi VertSplit guifg=#ff0000 guibg=NONE
"highlight VertSplit guifg=#ff0000 gui=bold
hi link WinSeparator Vert2
hi link VertSplit Vert2


" Highlight settings for different modes
augroup ModeChangeHighlight
  autocmd!
  " Normal mode settings
  autocmd InsertLeave,ModeChanged *:[^vV\x16]* hi! link WinSeparator Vert2
  " Insert mode settings
  autocmd InsertEnter,ModeChanged *:i* hi! link WinSeparator Vert1
  " Visual mode settings
  autocmd ModeChanged *:[vV\x16]* hi! link WinSeparator Vert5
  " Replace mode settings
  autocmd ModeChanged *:R* hi! link WinSeparator Vert3
augroup END


hi Identifier cterm=bold guifg=DarkSeaGreen4
hi Boolean cterm=bold guifg=Purple3
hi Number cterm=bold guifg=DarkMagenta
hi Operator cterm=bold guifg=SteelBlue1
hi Statement cterm=bold guifg=DeepSkyBlue4
hi Label cterm=bold guifg=DeepSkyBlue4
hi Keyword cterm=bold guifg=DeepSkyBlue4
hi Structure cterm=bold guifg=DeepSkyBlue4
hi Typedef cterm=bold guifg=DeepSkyBlue4
hi StorageClass cterm=bold guifg=DeepSkyBlue4
hi link Character Number
hi MatchParen cterm=bold guifg=Lime guibg=NONE
hi MsgArea cterm=bold guifg=DeepSkyBlue4
hi MoreMsg cterm=bold guifg=DeepSkyBlue4
hi ModeMsg cterm=bold guifg=Green4
hi Visual cterm=bold guibg=Grey15 guifg=Grey30
hi TablineSel cterm=bold guifg=Black guibg=Grey30
hi TablineFill cterm=bold guibg=NONE guifg=Black
hi Tabline cterm=bold guibg=NONE guifg=Grey30
"hi Search cterm=bold guibg=NONE guifg=Red
"hi ShowCommand cterm=bold ctermbg=NONE ctermfg=9
hi IPythonCell cterm=bold,underline guibg=NONE guifg=Lime


"hi NERDTreeExecFile cterm=bold guifg=Lime
hi link NERDTreeExecFile Function
hi NERDTreeDir cterm=bold guifg=DeepSkyBlue4
hi link NERDTreeUp Custom2
"hi NERDTreeOpenable cterm=bold guifg=Red
hi link NERDTreeOpenable Custom2
"hi NERDTreeClosable cterm=bold guifg=Red
hi link NERDTreeClosable Function
hi NERDTreeFile cterm=bold guifg=#a8775f
"hi link NERDTreeFile Custom1
hi FloatermBorder guibg=NONE guifg=#3584e4 gui=bold


hi link YcmInlayHint Comment
hi YcmErrorSign cterm=bold guifg=Red1
"hi YcmErrorSign cterm=bold guifg=Lime
hi YcmWarningSign cterm=bold guifg=Yellow
"hi YcmErrorLine cterm=bold guibg=none ctermfg=NONE
hi YcmErrorSection cterm=bold guifg=Red1
hi YcmWarningSection cterm=bold guifg=Yellow
hi vimError cterm=bold guifg=Red1
hi Pmenu cterm=bold guibg=Grey15 guifg=DeepSkyBlue1
hi PmenuSel cterm=bold guibg=Grey7 guifg=Green1
hi PmenuSbar cterm=bold guibg=Grey15 guifg=NONE
hi PmenuThumb cterm=bold guibg=Green3 guifg=NONE
hi SignColumn guibg=#1f1f1f guifg=Red gui=bold
hi Error cterm=bold,underline guibg=NONE guifg=Red1 gui=bold
" popup color
hi YcmErrorText cterm=bold guifg=Red1
hi YcmWarningText cterm=bold guifg=Yellow
]])


-- Custom semantic highlighting
-- C++
vim.api.nvim_set_hl(0, "@lsp.type.enum.cpp", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.enumMember.cpp", { fg="#5f00af", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.namespace.cpp", { fg="Orange4", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.class.cpp", { fg="#a8775f", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.parameter.cpp", { fg="Gold3", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.operator.cpp", { fg="SteelBlue1", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.variable.cpp", { fg="DarkSeaGreen4", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.function.cpp", { fg="Green4", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.property.cpp", { fg="DarkSeaGreen4", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.method.cpp", { fg="Green4", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.type.cpp", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.macro.cpp", { fg="Purple3", bold=true })

vim.api.nvim_set_hl(0, "@keyword.cpp", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@keyword.import.cpp", { fg="#a8775f", bold=true, italic=true })
vim.api.nvim_set_hl(0, "@keyword.modifier.cpp", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@keyword.type.cpp", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@keyword.repeat.cpp", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@keyword.conditional.cpp", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@keyword.return.cpp", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@keyword.exception.cpp", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@keyword.directive.cpp", { fg="#5f00af", bold=true })

vim.api.nvim_set_hl(0, "@type.builtin.cpp", { fg="Aqua", bold=true, italic=true })
vim.api.nvim_set_hl(0, "@variable.builtin.cpp", { fg="SpringGreen1", bold=true, italic=true })
vim.api.nvim_set_hl(0, "@variable.cpp", { fg="DarkSeaGreen4", bold=true })
vim.api.nvim_set_hl(0, "@operator.cpp", { fg="SteelBlue1", bold=true })
vim.api.nvim_set_hl(0, "@string.cpp", { fg="SandyBrown", bold=true })
vim.api.nvim_set_hl(0, "@function.cpp", { fg="Green4", bold=true })
vim.api.nvim_set_hl(0, "@number.cpp", { fg="DarkMagenta", bold=true })
vim.api.nvim_set_hl(0, "@character.cpp", { fg="DarkMagenta", bold=true })
vim.api.nvim_set_hl(0, "@property.cpp", { fg="DarkSeaGreen4", bold=true })
vim.api.nvim_set_hl(0, "@function.method.cpp", { fg="Green4", bold=true })
vim.api.nvim_set_hl(0, "@punctuation.delimiter.cpp", { fg="NvimLightGrey2", bold=true })
vim.api.nvim_set_hl(0, "@comment.cpp", { fg="Grey30", bold=true })



-- C
vim.api.nvim_set_hl(0, "@lsp.type.enum.c", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.enumMember.c", { fg="#5f00af", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.namespace.c", { fg="Orange4", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.class.c", { fg="#a8775f", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.parameter.c", { fg="Gold3", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.operator.c", { fg="SteelBlue1", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.variable.c", { fg="DarkSeaGreen4", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.function.c", { fg="Green4", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.property.c", { fg="DarkSeaGreen4", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.method.c", { fg="Green4", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.type.c", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.macro.c", { fg="Purple3", bold=true })

vim.api.nvim_set_hl(0, "@keyword.c", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@keyword.import.c", { fg="#a8775f", bold=true, italic=true })
vim.api.nvim_set_hl(0, "@keyword.modifier.c", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@keyword.type.c", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@keyword.repeat.c", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@keyword.conditional.c", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@keyword.return.c", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@keyword.exception.c", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@keyword.directive.c", { fg="#5f00af", bold=true })

vim.api.nvim_set_hl(0, "@type.builtin.c", { fg="Aqua", bold=true, italic=true })
vim.api.nvim_set_hl(0, "@variable.builtin.c", { fg="SpringGreen1", bold=true, italic=true })
vim.api.nvim_set_hl(0, "@variable.c", { fg="DarkSeaGreen4", bold=true })
vim.api.nvim_set_hl(0, "@operator.c", { fg="SteelBlue1", bold=true })
vim.api.nvim_set_hl(0, "@string.c", { fg="SandyBrown", bold=true })
vim.api.nvim_set_hl(0, "@function.c", { fg="Green4", bold=true })
vim.api.nvim_set_hl(0, "@number.c", { fg="DarkMagenta", bold=true })
vim.api.nvim_set_hl(0, "@character.c", { fg="DarkMagenta", bold=true })
vim.api.nvim_set_hl(0, "@property.c", { fg="DarkSeaGreen4", bold=true })
vim.api.nvim_set_hl(0, "@function.method.c", { fg="Green4", bold=true })
vim.api.nvim_set_hl(0, "@punctuation.delimiter.c", { fg="NvimLightGrey2", bold=true })
vim.api.nvim_set_hl(0, "@comment.c", { fg="Grey30", bold=true })



-- CMake
vim.api.nvim_set_hl(0, "@variable.cmake", { fg="DeepSkyBlue4", bold=true, italic=true })
vim.api.nvim_set_hl(0, "@function.builtin.cmake", { fg="Green4", bold=true })
vim.api.nvim_set_hl(0, "@constant.cmake", { fg="Purple3", bold=true })
vim.api.nvim_set_hl(0, "@boolean.cmake", { fg="Purple3", bold=true })



-- Lua
vim.api.nvim_set_hl(0, "@string.lua", { fg="SandyBrown", bold=true })



-- Bash
vim.api.nvim_set_hl(0, "@function.call.bash", { fg="Green4", bold=true })



-- Python
vim.api.nvim_set_hl(0, "@keyword.import.python", { fg="DeepSkyBlue4", bold=true })
vim.api.nvim_set_hl(0, "@module.python", { fg="DeepSkyBlue4", bold=true, italic=true })
vim.api.nvim_set_hl(0, "@variable.python", { fg="DarkSeaGreen4", bold=true })
vim.api.nvim_set_hl(0, "@lsp.type.variable.python", { fg="DarkSeaGreen4", bold=true })



-- Custom autocmds
vim.cmd([[
autocmd FileType text syntax match BoldAllText /.*/ | highlight BoldAllText cterm=bold gui=bold
]])


