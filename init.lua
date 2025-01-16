package.path = package.path .. ";/home/nathan/.config/nvim/?.lua"

--[[

 TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.
 NOTE: Look for lines like this

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info

I hope you enjoy your Neovim journey,
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15

--- NOTE: Nathan changes

vim.opt.equalalways = false
vim.opt.tabstop = 6
vim.opt.shiftwidth = 6
-- The silly tree
--vim.keymap.set("n", "<C-t>", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<C-t>", ":10sp +term<CR>")
vim.keymap.set("n", "<CS-j>", "i<CR><esc>")
vim.keymap.set("n", "<CA-u>", ":UndotreeToggle<CR>")
--- NOTE: Luarocks feature
package.path = package.path
	.. ";"
	.. vim.fn.expand("$HOME")
	.. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
--- TODO: figure out wrapping in text docs then using gj gk
vim.opt.wrap = false
local nmap = vim.keymap.set
nmap("n", "<C-u>", "<C-u>zz")
nmap("n", "<C-d>", "<C-d>zz")
nmap("n", "<C-f>", "<C-f>zz")
nmap("n", "<C-b>", "<C-b>zz")
nmap("t", "<C-space>", "<space>")
nmap("t", "<S-space>", "<space>")
nmap("t", "<C-Bs>", "<Bs>")
nmap("t", "<S-Bs>", "<Bs>")
--[[nmap("n", "<C-S-h>", "<C-w><Left>")
nmap("n", "<C-S-l>", "<C-w><Left>")
nmap("n", "<C-S-k>", "<C-w>+")
nmap("n", "<C-S-j>", "<C-w>-")]]

-- vim.opt.includeexpr = [[substitute(v:fname, '^file://\(.*\)#L\(\d\+\)', '\1', '')]]

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = "*",
	callback = function(event)
		local buf = event.buf

		-- hackery to overload lsp to also do stuff when no lsp and man page
		local function lsp_map(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = buf, desc = "LSP: " .. desc })
		end

		lsp_map("gd", function(...)
			if vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()):find("man://") then
				return vim.api.nvim_command(":ManGD")
			end
			return require("telescope.builtin").lsp_definitions(...)
		end, "[G]oto [D]efinition")

		vim.api.nvim_buf_create_user_command(buf, "ManGD", function()
			local buf_name = vim.api.nvim_buf_get_name(buf)
			local man = "man://"
			if buf_name:sub(1, man:len()) ~= man then return end
			local cur_line = vim.api.nvim_get_current_line()
			local cursor = vim.api.nvim_win_get_cursor(0)
			local start_section = cur_line:sub(1, cursor[2])
			local word_begin = start_section:len()
				- (start_section:reverse():find(" ") or start_section:len() + 1)
				+ 2
			if word_begin == nil then return end
			local page_container = cur_line:sub(word_begin)
			local page_end = (page_container:find("[, ]") or page_container:len() + 1) - 1
			local page = page_container:sub(1, page_end)
			print(page)
			vim.api.nvim_command(":Man " .. page)
		end, {})
	end,
})

local function exec(cmd)
	print(cmd)
	vim.api.nvim_command(cmd)
end

nmap("n", "gf", function()
	local cur_line = vim.api.nvim_get_current_line()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local FILE = "file:"
	local start_section = cur_line:sub(1, cursor[2] + FILE:len())
	local file_begin = start_section:find(FILE)
	if file_begin == nil then return end
	local path_container = cur_line:sub(file_begin)
	local path_end = path_container:find("[ )]")
	local path = path_container:sub(1, path_end - 1)
	local line
	if path:find("#L") then
		local line_str = path:sub(path:find("#L") + 2)
		line = tonumber(line_str)
		path = path:sub(1, path:find("#L") - 1)
	end
	path = path:sub(FILE:len() + 1)
	print(path, line)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w><C-j>", true, true, true), "n", false)
	if line then
		exec(":edit +" .. line .. " " .. path)
	else
		exec(":edit " .. path)
	end
end, { noremap = true, silent = true })

vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set(
	"n",
	"[d",
	vim.diagnostic.goto_prev,
	{ desc = "Go to previous [D]iagnostic message" }
)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set(
	"n",
	"<leader>e",
	vim.diagnostic.open_float,
	{ desc = "Show diagnostic [E]rror messages" }
)
vim.keymap.set(
	"n",
	"<leader>q",
	vim.diagnostic.setloclist,
	{ desc = "Open diagnostic [Q]uickfix list" }
)

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", "")
vim.keymap.set("n", "<right>", "")
vim.keymap.set("n", "<up>", "")
vim.keymap.set("n", "<down>", "")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--	See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

--  To check the current status of your plugins, run
--	:Lazy
--
--  To update plugins, you can run
--	:Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup(require("lua/custom/plugins"))
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=6 sts=0 sw=0 noexpandtab
