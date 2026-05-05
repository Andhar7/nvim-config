vim.opt.termguicolors = true
vim.cmd.colorscheme("habamax") -- replaced after tokyonight.nvim loads below

local function set_transparent() -- set UI component to transparent
	local groups = {
		"Normal",
		"NormalNC",
		"EndOfBuffer",
		"NormalFloat",
		"FloatBorder",
		"SignColumn",
		"StatusLine",
		"StatusLineNC",
		"TabLine",
		"TabLineFill",
		"TabLineSel",
		"ColorColumn",
	}
	for _, g in ipairs(groups) do
		vim.api.nvim_set_hl(0, g, { bg = "#03002E" })
	end
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#03002E", fg = "#767676" })
end

set_transparent()

-- ============================================================================
-- OPTIONS
-- ============================================================================
vim.opt.number = true -- line number
vim.opt.relativenumber = true -- relative line numbers
vim.opt.cursorline = true -- highlight current line
vim.opt.wrap = false -- do not wrap lines by default
vim.opt.scrolloff = 10 -- keep 10 lines above/below cursor
vim.opt.sidescrolloff = 10 -- keep 10 lines to left/right of cursor

vim.opt.tabstop = 2 -- tabwidth
vim.opt.shiftwidth = 2 -- indent width
vim.opt.softtabstop = 2 -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indent
vim.opt.autoindent = true -- copy indent from current line

vim.opt.ignorecase = true -- case insensitive search
vim.opt.smartcase = true -- case sensitive if uppercase in string
vim.opt.hlsearch = true -- highlight search matches
vim.opt.incsearch = true -- show matches as you type

vim.opt.signcolumn = "yes" -- always show a sign column
vim.opt.colorcolumn = "100" -- show a column at 100 position chars
vim.opt.showmatch = true -- highlights matching brackets
vim.opt.cmdheight = 1 -- single line command line
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.showmode = false -- do not show the mode, instead have it in statusline
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- floating window transparency
vim.opt.conceallevel = 0 -- do not hide markup
vim.opt.concealcursor = "" -- do not hide cursorline in markup
vim.opt.lazyredraw = true -- do not redraw during macros
vim.opt.synmaxcol = 300 -- syntax highlighting limit
vim.opt.fillchars = { eob = " " } -- hide "~" on empty lines

local undodir = vim.fn.expand("~/.vim/undodir")
if
	vim.fn.isdirectory(undodir) == 0 -- create undodir if nonexistent
then
	vim.fn.mkdir(undodir, "p")
end

vim.opt.backup = false -- do not create a backup file
vim.opt.writebackup = false -- do not write to a backup file
vim.opt.swapfile = false -- do not create a swapfile
vim.opt.undofile = true -- do create an undo file
vim.opt.undodir = undodir -- set the undo directory
vim.opt.updatetime = 300 -- faster completion
vim.opt.timeoutlen = 500 -- timeout duration
vim.opt.ttimeoutlen = 50 -- key code timeout
vim.opt.autoread = true -- auto-reload changes if outside of neovim
vim.opt.autowrite = false -- do not auto-save

vim.opt.hidden = true -- allow hidden buffers
vim.opt.errorbells = false -- no error sounds
vim.opt.backspace = "indent,eol,start" -- better backspace behaviour
vim.opt.autochdir = false -- do not autochange directories
vim.opt.iskeyword:append("-") -- include - in words
vim.opt.path:append("**") -- include subdirs in search
vim.opt.selection = "inclusive" -- include last char in selection
vim.opt.mouse = "a" -- enable mouse support
vim.opt.clipboard:append("unnamedplus") -- use system clipboard
vim.opt.modifiable = true -- allow buffer modifications
vim.opt.encoding = "utf-8" -- set encoding

vim.opt.guicursor =
	"n-v-c:block,i-ci-ve:block,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175" -- cursor blinking and settings

-- Folding: requires treesitter available at runtime; safe fallback if not
vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- start with all folds open

vim.opt.splitbelow = true -- horizontal splits go below
vim.opt.splitright = true -- vertical splits go right

vim.opt.wildmenu = true -- tab completion
vim.opt.wildmode = "longest:full,full" -- complete longest common match, full completion list, cycle through with Tab
vim.opt.diffopt:append("linematch:60") -- improve diff display
vim.opt.redrawtime = 10000 -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000 -- increase max memory

-- ============================================================================
-- STATUSLINE — lualine (replaces hand-written statusline; theme tuned to #03002E)
-- NOTE: lualine is set up below in PLUGIN CONFIGS after vim.pack packages load
-- ============================================================================

-- ============================================================================
-- KEYMAPS
-- ============================================================================
vim.g.mapleader = " " -- space for leader
vim.g.maplocalleader = " " -- space for localleader

vim.g.python3_host_prog = vim.fn.expand("~/.pyenv/versions/3.12.0/bin/python")
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- better movement in wrapped text
vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>X", '"_d', { desc = "Delete without yanking" })

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- Ctrl+h/j/k/l navigation handled by vim-tmux-navigator (works across nvim splits AND tmux panes)

vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

vim.keymap.set("n", "<leader>pa", function() -- show file path
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy full file path" })

vim.keymap.set("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })

-- ============================================================================
-- AUTOCMDS
-- ============================================================================

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Format on save (ONLY real file buffers, ONLY when efm is attached)
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup,
	pattern = {
		"*.lua",
		"*.py",
		"*.go",
		"*.js",
		"*.jsx",
		"*.ts",
		"*.tsx",
		"*.json",
		"*.css",
		"*.scss",
		"*.html",
		"*.sh",
		"*.bash",
		"*.zsh",
		"*.c",
		"*.cpp",
		"*.h",
		"*.hpp",
	},
	callback = function(args)
		-- avoid formatting non-file buffers (helps prevent weird write prompts)
		if vim.bo[args.buf].buftype ~= "" then
			return
		end
		if not vim.bo[args.buf].modifiable then
			return
		end
		if vim.api.nvim_buf_get_name(args.buf) == "" then
			return
		end

		pcall(function() require("mini.trailspace").trim() end) -- remove trailing whitespace

		local has_efm = false
		for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
			if c.name == "efm" then
				has_efm = true
				break
			end
		end
		if not has_efm then
			return
		end

		pcall(vim.lsp.buf.format, {
			bufnr = args.buf,
			timeout_ms = 2000,
			filter = function(c)
				return c.name == "efm"
			end,
		})
	end,
})

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- return to last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	desc = "Restore last cursor position",
	callback = function()
		if vim.o.diff then -- except in diff mode
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
		local last_line = vim.api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if row < 1 or row > last_line then
			return
		end

		pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
	end,
})

-- Clean reading environment for markdown / text / git commits
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
		vim.opt_local.relativenumber = false -- no relative numbers while reading
		vim.opt_local.number = false         -- no line numbers while reading
		vim.opt_local.cursorline = false     -- no cursorline highlight
		vim.opt_local.colorcolumn = ""       -- no 100-char ruler
		vim.opt_local.signcolumn = "no"      -- no sign column
	end,
})
-- ============================================================================
-- PLUGINS (vim.pack)
-- ============================================================================
vim.pack.add({
	"https://www.github.com/lewis6991/gitsigns.nvim",
	"https://www.github.com/echasnovski/mini.nvim",
	"https://www.github.com/ibhagwan/fzf-lua",
	"https://www.github.com/nvim-tree/nvim-tree.lua",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},
	-- Language Server Protocols
	"https://www.github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/creativenull/efmls-configs-nvim",
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1.*"),
	},
	"https://github.com/L3MON4D3/LuaSnip",
	"https://github.com/rafamadriz/friendly-snippets", -- pre-made snippets: React, HTML, Python, Django
	-- UI & Navigation
	"https://github.com/folke/which-key.nvim",       -- shows keybindings as you type
	"https://github.com/folke/trouble.nvim",         -- professional diagnostics panel
	"https://github.com/nvim-tree/nvim-web-devicons", -- file icons for nvim-tree, fzf-lua, etc.
	"https://github.com/glepnir/lspsaga.nvim",       -- beautiful LSP UI: peek, hover, rename, actions
	-- Focused coding
	"https://github.com/folke/twilight.nvim",        -- dims inactive code paragraphs
	"https://github.com/folke/zen-mode.nvim",        -- distraction-free writing / study mode
	-- Statusline
	"https://github.com/nvim-lualine/lualine.nvim",  -- beautiful statusline
	-- Git
	"https://github.com/tpope/vim-fugitive",         -- full git: :Git commit, :Git log, :Git diff
	-- Tmux integration
	"https://github.com/christoomey/vim-tmux-navigator", -- Ctrl+h/j/k/l across nvim splits AND tmux panes
	-- Color
	"https://github.com/uga-rosa/ccc.nvim",          -- colour highlighter for CSS / Tailwind
	-- Colorscheme
	"https://github.com/folke/tokyonight.nvim",
})

local function packadd(name)
	vim.cmd("packadd " .. name)
end
packadd("nvim-treesitter")
packadd("gitsigns.nvim")
packadd("mini.nvim")
packadd("fzf-lua")
packadd("nvim-tree.lua")
-- LSP
packadd("nvim-lspconfig")
packadd("mason.nvim")
packadd("efmls-configs-nvim")
packadd("blink.cmp")
packadd("LuaSnip")
packadd("friendly-snippets")
packadd("which-key.nvim")
packadd("trouble.nvim")
packadd("nvim-web-devicons")
packadd("lspsaga.nvim")
packadd("twilight.nvim")
packadd("zen-mode.nvim")
packadd("lualine.nvim")
packadd("vim-fugitive")
packadd("vim-tmux-navigator")
packadd("ccc.nvim")
packadd("tokyonight.nvim")

-- ============================================================================
-- COLORSCHEME
-- ============================================================================

require("tokyonight").setup({
	style = "night",
	transparent = false,
	terminal_colors = true,
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		sidebars = "dark",
		floats = "dark",
	},
	sidebars = { "qf", "help", "terminal", "NvimTree" },
	on_colors = function(c)
		c.bg         = "#010020" -- deep pure navy main background
		c.bg_dark    = "#00001a" -- darker navy for sidebars / inactive splits
		c.bg_float   = "#00001a" -- hover docs / popups
		c.bg_popup   = "#00001a"
		c.bg_sidebar = "#00001a"
	end,
	on_highlights = function(hl, c)
		hl.LineNr       = { fg = c.dark5 }
		hl.CursorLineNr = { fg = c.orange, bold = true }
		hl.Normal       = { bg = "#010020" }
		hl.NormalNC     = { bg = "#00001a" }
	end,
})
vim.cmd.colorscheme("tokyonight-night")

-- ============================================================================
-- PLUGIN CONFIGS
-- ============================================================================

local setup_treesitter = function()
	local treesitter = require("nvim-treesitter")
	treesitter.setup({})
	local ensure_installed = {
		"vim",
		"vimdoc",
		"rust",
		"c",
		"cpp",
		"go",
		"html",
		"css",
		"javascript",
		"json",
		"lua",
		"markdown",
		"python",
		"typescript",
		"vue",
		"svelte",
		"bash",
		"dockerfile",
		"yaml",
		"markdown_inline",
	}

	local config = require("nvim-treesitter.config")

	local already_installed = config.get_installed()
	local parsers_to_install = {}

	for _, parser in ipairs(ensure_installed) do
		if not vim.tbl_contains(already_installed, parser) then
			table.insert(parsers_to_install, parser)
		end
	end

	if #parsers_to_install > 0 then
		treesitter.install(parsers_to_install)
	end

	local group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		callback = function(args)
			if vim.list_contains(treesitter.get_installed(), vim.treesitter.language.get_lang(args.match)) then
				vim.treesitter.start(args.buf)
			end
		end,
	})
end

setup_treesitter()

require("nvim-web-devicons").setup({
	override_by_extension = {
		lua  = { icon = "\xe2\x97\x88", color = "#51a0cf", name = "Lua" },
		py   = { icon = "\xe2\x97\x8f", color = "#98c379", name = "Python" },
		js   = { icon = "\xe2\x97\x86", color = "#e5c07b", name = "Js" },
		ts   = { icon = "\xe2\x97\x86", color = "#61afef", name = "Ts" },
		jsx  = { icon = "\xe2\x97\x86", color = "#e5c07b", name = "Jsx" },
		tsx  = { icon = "\xe2\x97\x86", color = "#61afef", name = "Tsx" },
		html = { icon = "\xe2\x9d\x96", color = "#e06c75", name = "Html" },
		css  = { icon = "\xe2\x97\x90", color = "#56b6c2", name = "Css" },
		json = { icon = "\xe2\x9d\xb4", color = "#e5c07b", name = "Json" },
		md   = { icon = "\xe2\x80\x94", color = "#abb2bf", name = "Md" },
		sh   = { icon = "\xe2\x86\x92", color = "#98c379", name = "Sh" },
		yaml = { icon = "\xe2\x88\xb4", color = "#c678dd", name = "Yaml" },
		yml  = { icon = "\xe2\x88\xb4", color = "#c678dd", name = "Yml" },
		toml = { icon = "\xe2\x88\xb4", color = "#c678dd", name = "Toml" },
	},
	default = true,
})

require("nvim-tree").setup({
	view = {
		width = 35,
	},
	filters = {
		dotfiles = false,
	},
	renderer = {
		group_empty = true,
	},
})
vim.keymap.set("n", "<leader>e", function()
	require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle NvimTree" })

vim.api.nvim_set_hl(0, "NvimTreeNormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeSignColumn", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { fg = "#2a2a2a", bg = "none" })
vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })

require("fzf-lua").setup({})

vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "FZF Files" })
vim.keymap.set("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end, { desc = "FZF Live Grep" })
vim.keymap.set("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>fh", function()
	require("fzf-lua").help_tags()
end, { desc = "FZF Help Tags" })
vim.keymap.set("n", "<leader>fx", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "FZF Diagnostics Document" })
vim.keymap.set("n", "<leader>fX", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "FZF Diagnostics Workspace" })

require("mini.ai").setup({})
require("mini.comment").setup({})
require("mini.move").setup({})
require("mini.surround").setup({})
require("mini.cursorword").setup({})
require("mini.indentscope").setup({})
require("mini.pairs").setup({})
require("mini.trailspace").setup({})
require("mini.bufremove").setup({})
require("mini.notify").setup({})
require("mini.icons").setup({
	extension = {
		lua  = { glyph = "\xe2\x97\x88", hl = "MiniIconsBlue" },   -- ◈
		json = { glyph = "\xe2\x9d\xb4", hl = "MiniIconsYellow" },  -- ❴
		py   = { glyph = "\xe2\x97\x8f", hl = "MiniIconsGreen" },   -- ●
		js   = { glyph = "\xe2\x97\x86", hl = "MiniIconsYellow" },  -- ◆
		ts   = { glyph = "\xe2\x97\x86", hl = "MiniIconsBlue" },    -- ◆
		html = { glyph = "\xe2\x9d\x96", hl = "MiniIconsRed" },     -- ❖
		css  = { glyph = "\xe2\x97\x90", hl = "MiniIconsCyan" },    -- ◐
		md   = { glyph = "\xe2\x80\x94", hl = "MiniIconsGrey" },    -- —
		sh   = { glyph = "\xe2\x86\x92", hl = "MiniIconsGreen" },   -- →
	},
	filetype = {
		lua        = { glyph = "\xe2\x97\x88", hl = "MiniIconsBlue" },
		python     = { glyph = "\xe2\x97\x8f", hl = "MiniIconsGreen" },
		javascript = { glyph = "\xe2\x97\x86", hl = "MiniIconsYellow" },
		typescript = { glyph = "\xe2\x97\x86", hl = "MiniIconsBlue" },
		html       = { glyph = "\xe2\x9d\x96", hl = "MiniIconsRed" },
		css        = { glyph = "\xe2\x97\x90", hl = "MiniIconsCyan" },
		sh         = { glyph = "\xe2\x86\x92", hl = "MiniIconsGreen" },
		json       = { glyph = "\xe2\x9d\xb4", hl = "MiniIconsYellow" },
		markdown   = { glyph = "\xe2\x80\x94", hl = "MiniIconsGrey" },
		dockerfile = { glyph = "\xe2\x96\xa3", hl = "MiniIconsBlue" },  -- ▣
		yaml       = { glyph = "\xe2\x88\xb4", hl = "MiniIconsPurple" }, -- ∴
	},
})
-- mock removed: using real nvim-web-devicons with custom Unicode overrides above

require("gitsigns").setup({
	signs = {
		add = { text = "\u{2590}" }, -- ▏
		change = { text = "\u{2590}" }, -- ▐
		delete = { text = "\u{2590}" }, -- ◦
		topdelete = { text = "\u{25e6}" }, -- ◦
		changedelete = { text = "\u{25cf}" }, -- ●
		untracked = { text = "\u{25cb}" }, -- ○
	},
	signcolumn = true,
	current_line_blame = false,
})

require("mason").setup({})

-- ============================================================================
-- LUALINE — statusline tuned to the #03002E deep-navy background
-- ============================================================================
local navy = "#03002E"
local lualine_theme = {
	normal   = { a = { bg = "#7aa2f7", fg = navy, gui = "bold" }, -- blue pill
	             b = { bg = "#0d0b2a", fg = "#c0caf5" },
	             c = { bg = navy,      fg = "#6272a4" } },
	insert   = { a = { bg = "#9ece6a", fg = navy, gui = "bold" }, -- green pill
	             b = { bg = "#0d0b2a", fg = "#c0caf5" } },
	visual   = { a = { bg = "#e0af68", fg = navy, gui = "bold" }, -- amber pill
	             b = { bg = "#0d0b2a", fg = "#c0caf5" } },
	replace  = { a = { bg = "#f7768e", fg = navy, gui = "bold" }, -- red pill
	             b = { bg = "#0d0b2a", fg = "#c0caf5" } },
	command  = { a = { bg = "#bb9af7", fg = navy, gui = "bold" }, -- purple pill
	             b = { bg = "#0d0b2a", fg = "#c0caf5" } },
	terminal = { a = { bg = "#73daca", fg = navy, gui = "bold" }, -- teal pill
	             b = { bg = "#0d0b2a", fg = "#c0caf5" } },
	inactive = { a = { bg = navy, fg = "#3b4261" },
	             b = { bg = navy, fg = "#3b4261" },
	             c = { bg = navy, fg = "#3b4261" } },
}

require("lualine").setup({
	options = {
		theme                = lualine_theme,
		component_separators = { left = "", right = "" },
		section_separators   = { left = "", right = "" },
		globalstatus         = true,
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			"branch",
			{ "diff", symbols = { added = " ", modified = " ", removed = " " } },
			{ "diagnostics", symbols = { error = "  ", warn = "  ", info = "  ", hint = " " } },
		},
		lualine_c = { { "filename", path = 1, symbols = { modified = "  ", readonly = "  ", unnamed = "[No Name]" } } },
		lualine_x = {
			{
				function()
					local ft = vim.bo.filetype
					if ft == "" then return "" end
					local icons = {
						lua          = "\xe2\x97\x88 lua",   -- ◈  solid diamond
						python       = "\xe2\x97\x8f python", -- ●  circle
						javascript   = "\xe2\x97\x86 js",    -- ◆  diamond
						typescript   = "\xe2\x97\x86 ts",
						javascriptreact   = "\xe2\x97\x86 jsx",
						typescriptreact   = "\xe2\x97\x86 tsx",
						html         = "\xe2\x9d\x96 html",  -- ❖  floral
						css          = "\xe2\x97\x90 css",   -- ◐  half circle
						json         = "\xe2\x9d\xb4 json",  -- ❴  curly bracket
						yaml         = "\xe2\x88\xb4 yaml",  -- ∴  therefore
						sh           = "\xe2\x86\x92 sh",    -- →  arrow
						dockerfile   = "\xe2\x96\xa3 docker",-- ▣  square
						markdown     = "\xe2\x80\x94 md",    -- —  dash
					}
					return icons[ft] or ("\xe2\x97\xa6 " .. ft) -- ◦  small circle fallback
				end,
				color = { fg = "#7aa2f7", gui = "bold" },
			}
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "location" },
	},
})

-- ============================================================================
-- WHICH-KEY — shows your keybindings as you type (essential for learning)
-- ============================================================================
require("which-key").setup({})
require("which-key").add({
	{ "<leader>b", group = "Buffer" },
	{ "<leader>d", group = "Diagnostics" },
	{ "<leader>f", group = "Find / FZF" },
	{ "<leader>g", group = "Go to (LSP / Saga)" },
	{ "<leader>h", group = "Git Hunks" },
	{ "<leader>o", group = "Organise Imports" },
	{ "<leader>r", group = "Rename" },
	{ "<leader>s", group = "Split" },
	{ "<leader>x", group = "Trouble" },
	{ "<leader>z", group = "Zen Mode" },
})
vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Show buffer keymaps" })

-- ============================================================================
-- TROUBLE — professional diagnostics / errors panel
-- ============================================================================
require("trouble").setup({})
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Workspace Diagnostics" })
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })

-- ============================================================================
-- LSPSAGA — beautiful LSP UI (peek definition, hover docs, code actions)
-- ============================================================================
require("lspsaga").setup({
	ui = { border = "rounded" },
	symbol_in_winbar = { enable = false },
})

-- ============================================================================
-- ZEN-MODE + TWILIGHT — distraction-free study / coding sessions
-- ============================================================================
require("twilight").setup({})
require("zen-mode").setup({
	window = {
		backdrop = 1,
		width = 0.65,
	},
	plugins = {
		options = { enabled = true, ruler = false, showcmd = false },
	},
	on_open  = function() pcall(function() require("twilight").enable()  end) end,
	on_close = function() pcall(function() require("twilight").disable() end) end,
})
vim.keymap.set("n", "<leader>z", function()
	require("zen-mode").toggle()
end, { desc = "Toggle Zen Mode" })

-- ============================================================================
-- CCC — colour highlighter: shows #ff6600, rgb(), hsl() inline (CSS / Tailwind)
-- ============================================================================
require("ccc").setup({
	highlighter = {
		auto_enable = true,
		lsp = true,
	},
})

vim.keymap.set("n", "]h", function()
	require("gitsigns").next_hunk()
end, { desc = "Next git hunk" })
vim.keymap.set("n", "[h", function()
	require("gitsigns").prev_hunk()
end, { desc = "Previous git hunk" })
vim.keymap.set("n", "<leader>hs", function()
	require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hr", function()
	require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })
vim.keymap.set("n", "<leader>hp", function()
	require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })
vim.keymap.set("n", "<leader>hb", function()
	require("gitsigns").blame_line({ full = true })
end, { desc = "Blame line" })
vim.keymap.set("n", "<leader>hB", function()
	require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle inline blame" })
vim.keymap.set("n", "<leader>hd", function()
	require("gitsigns").diffthis()
end, { desc = "Diff this" })

-- ============================================================================
-- LSP, Linting, Formatting & Completion
-- ============================================================================
local diagnostic_signs = {
	Error = " ",
	Warn = " ",
	Hint = "",
	Info = "",
}

vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
			[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
			[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
			[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		focusable = false,
		style = "minimal",
	},
})

do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "rounded"
		return orig(contents, syntax, opts, ...)
	end
end

local function lsp_on_attach(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		return
	end

	local bufnr = ev.buf
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- lspsaga — richer UI for all LSP interactions
	vim.keymap.set("n", "<leader>gd", "<cmd>Lspsaga peek_definition<CR>", vim.tbl_extend("force", opts, { desc = "Peek definition (float)" }))
	vim.keymap.set("n", "<leader>gD", "<cmd>Lspsaga goto_definition<CR>", vim.tbl_extend("force", opts, { desc = "Go to definition" }))
	vim.keymap.set("n", "<leader>gS", "<cmd>vsplit | Lspsaga goto_definition<CR>", vim.tbl_extend("force", opts, { desc = "Definition in split" }))
	vim.keymap.set("n", "<leader>gf", "<cmd>Lspsaga finder<CR>", vim.tbl_extend("force", opts, { desc = "LSP Finder (refs + def)" }))
	vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", vim.tbl_extend("force", opts, { desc = "Code action" }))
	vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
	vim.keymap.set("n", "<leader>D",  "<cmd>Lspsaga show_line_diagnostics<CR>", vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
	vim.keymap.set("n", "<leader>d",  "<cmd>Lspsaga show_cursor_diagnostics<CR>", vim.tbl_extend("force", opts, { desc = "Cursor diagnostics" }))
	vim.keymap.set("n", "<leader>nd", "<cmd>Lspsaga diagnostic_jump_next<CR>", vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
	vim.keymap.set("n", "<leader>pd", "<cmd>Lspsaga diagnostic_jump_prev<CR>", vim.tbl_extend("force", opts, { desc = "Prev diagnostic" }))
	vim.keymap.set("n", "K",          "<cmd>Lspsaga hover_doc<CR>", vim.tbl_extend("force", opts, { desc = "Hover documentation" }))

	vim.keymap.set("n", "<leader>fd", function()
		require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
	end, opts)
	vim.keymap.set("n", "<leader>fr", function()
		require("fzf-lua").lsp_references()
	end, opts)
	vim.keymap.set("n", "<leader>ft", function()
		require("fzf-lua").lsp_typedefs()
	end, opts)
	vim.keymap.set("n", "<leader>fs", function()
		require("fzf-lua").lsp_document_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fw", function()
		require("fzf-lua").lsp_workspace_symbols()
	end, opts)
	vim.keymap.set("n", "<leader>fi", function()
		require("fzf-lua").lsp_implementations()
	end, opts)

	if client:supports_method("textDocument/codeAction", bufnr) then
		vim.keymap.set("n", "<leader>oi", function()
			vim.lsp.buf.code_action({
				context = { only = { "source.organizeImports" }, diagnostics = {} },
				apply = true,
				bufnr = bufnr,
			})
			vim.defer_fn(function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, 50)
		end, opts)
	end
end

vim.api.nvim_create_autocmd("LspAttach", { group = augroup, callback = lsp_on_attach })

vim.keymap.set("n", "<leader>q", function()
	vim.diagnostic.setloclist({ open = true })
end, { desc = "Open diagnostic list" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<C-Space>"] = { "show", "hide" },
		["<CR>"] = { "accept", "fallback" },
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
	},
	appearance = { nerd_font_variant = "mono" },
	completion = { menu = { auto_show = true } },
	sources = { default = { "lsp", "path", "buffer", "snippets" } },
	snippets = {
		expand = function(snippet)
			require("luasnip").lsp_expand(snippet)
		end,
	},

	fuzzy = {
		implementation = "prefer_rust",
		prebuilt_binaries = { download = true },
	},
})

-- Load friendly-snippets (React, HTML, Django, Python patterns)
require("luasnip.loaders.from_vscode").lazy_load()

vim.lsp.config["*"] = {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
}

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			telemetry = { enable = false },
		},
	},
})
vim.lsp.config("pyright", {})   -- Django / Python
vim.lsp.config("bashls", {})
vim.lsp.config("ts_ls", {
	filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
	settings = { typescript = { indentStyle = "space", indentSize = 2 } },
})
vim.lsp.config("gopls", {})
vim.lsp.config("clangd", {})

-- ── Web Development LSPs ────────────────────────────────────────────────────
-- Install via Mason: emmet-ls, tailwindcss-language-server, html-lsp,
--                    css-lsp, yaml-language-server, dockerfile-language-server

vim.lsp.config("emmet_ls", {
	-- expands  div.container>ul>li*5  →  full HTML  (essential for HTML/CSS)
	filetypes = {
		"html", "css", "scss", "sass",
		"javascript", "javascriptreact",
		"typescript", "typescriptreact",
		"vue", "svelte",
	},
})

vim.lsp.config("tailwindcss", {
	-- Tailwind class autocomplete — used in React, React Native, Next.js
	filetypes = {
		"javascript", "javascriptreact",
		"typescript", "typescriptreact",
		"html", "vue", "svelte",
	},
})

vim.lsp.config("html", {
	filetypes = { "html" },
})

vim.lsp.config("cssls", {
	-- CSS property completion and validation
	filetypes = { "css", "scss", "sass", "less" },
})

vim.lsp.config("yamlls", {
	-- docker-compose.yml, GitHub Actions, Django fixtures
	settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/docker-compose.json"] = "docker-compose*.yml",
				["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.yml",
			},
			validate = true,
			format = { enable = true },
		},
	},
	filetypes = { "yaml" },
})

vim.lsp.config("dockerls", {
	filetypes = { "dockerfile" },
})

do
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")

	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")

	local prettier_d = require("efmls-configs.formatters.prettier_d")
	local eslint_d = require("efmls-configs.linters.eslint_d")

	local fixjson = require("efmls-configs.formatters.fixjson")

	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")

	local hadolint = require("efmls-configs.linters.hadolint") -- dockerfile linter

	vim.lsp.config("efm", {
		filetypes = {
			"css",
			"dockerfile",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"lua",
			"markdown",
			"python",
			"sh",
			"typescript",
			"typescriptreact",
			"vue",
			"svelte",
		},
		init_options = { documentFormatting = true },
		settings = {
			languages = {
				css = { prettier_d },
				dockerfile = { hadolint },
				html = { prettier_d },
				javascript = { eslint_d, prettier_d },
				javascriptreact = { eslint_d, prettier_d },
				json = { eslint_d, fixjson },
				jsonc = { eslint_d, fixjson },
				lua = { luacheck, stylua },
				markdown = { prettier_d },
				python = { flake8, black },
				sh = { shellcheck, shfmt },
				typescript = { eslint_d, prettier_d },
				typescriptreact = { eslint_d, prettier_d },
				vue = { eslint_d, prettier_d },
				svelte = { eslint_d, prettier_d },
			},
		},
	})
end

vim.lsp.enable({
	-- Core
	"lua_ls", "pyright", "bashls", "ts_ls",
	-- Web Development (Django, React, React Native, HTML, CSS)
	"emmet_ls", "tailwindcss", "html", "cssls", "yamlls", "dockerls",
	-- Linting & Formatting
	"efm",
})

-- ============================================================================
-- FLOATING TERMINAL
-- ============================================================================
vim.api.nvim_create_autocmd("TermClose", {
	group = augroup,
	callback = function()
		if vim.v.event.status == 0 then
			vim.api.nvim_buf_delete(0, {})
		end
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

local terminal_state = { buf = nil, win = nil, is_open = false }

local function FloatingTerminal()
	if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
		return
	end

	if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
		terminal_state.buf = vim.api.nvim_create_buf(false, true)
		vim.bo[terminal_state.buf].bufhidden = "hide"
	end

	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	vim.wo[terminal_state.win].winblend = 0
	vim.wo[terminal_state.win].winhighlight = "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"
	vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none" })

	local has_terminal = false
	local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
	for _, line in ipairs(lines) do
		if line ~= "" then
			has_terminal = true
			break
		end
	end
	if not has_terminal then
		vim.fn.termopen(os.getenv("SHELL"))
	end

	terminal_state.is_open = true
	vim.cmd("startinsert")

	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = terminal_state.buf,
		callback = function()
			if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
				vim.api.nvim_win_close(terminal_state.win, false)
				terminal_state.is_open = false
			end
		end,
		once = true,
	})
end

vim.keymap.set("n", "<leader>T", FloatingTerminal, { noremap = true, silent = true, desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc>", function()
	if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
	end
end, { noremap = true, silent = true, desc = "Close floating terminal" })

















