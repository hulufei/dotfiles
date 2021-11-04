-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- Writing print(vim.inspect(x)) every time you want to inspect the contents of an object can get pretty tedious.
-- It might be worthwhile to have a global wrapper function. https://github.com/nanotee/nvim-lua-guide#tips-3
function _G.put(...)
	local objects = {}
	for i = 1, select("#", ...) do
		local v = select(i, ...)
		table.insert(objects, vim.inspect(v))
	end

	print(table.concat(objects, "\n"))
	return ...
end

-- general
-- lvim.log.level = "debug"
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.lsp.document_highlight = false
lvim.colorscheme = "base16-solarized-light"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.insert_mode["jk"] = nil
lvim.keys.insert_mode["kj"] = nil

lvim.builtin.which_key.mappings["o"] = { "<cmd>NvimTreeFocus<cr>", "Focus explorer" }

lvim.builtin.telescope.active = true
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
-- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
-- see: https://github.com/akinsho/toggleterm.nvim/pull/9
-- Tweak log viewer background in light theme
lvim.builtin.terminal.shading_factor = 3
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }

vim.list_extend(lvim.lsp.override, { "rust" })

-- Additional Plugins
lvim.plugins = {
	{ "RRethy/nvim-base16" },
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"tpope/vim-surround",
		keys = { "c", "d", "y" },
	},
	-- ]n and [n jump to conflict section is awesome
	{ "tpope/vim-unimpaired" },
	-- NOTICE: custom rust lsp, remember to remove setup in ftplugin/rust.lua
	{
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({
				tools = {
					autoSetHints = true,
					hover_with_actions = true,
					runnables = {
						use_telescope = true,
					},
				},
				server = {
					cmd = { vim.fn.stdpath("data") .. "/lsp_servers/rust/rust-analyzer" },
					on_attach = require("lvim.lsp").common_on_attach,
					on_init = require("lvim.lsp").common_on_init,
				},
			})
		end,
		ft = { "rust", "rs" },
	},
}

lvim.lang.lua.formatters = { { exe = "stylua" } }
lvim.lang.json.formatters = { { exe = "prettier" } }
lvim.lang.typescriptreact.formatters = { { exe = "prettier" } }
lvim.lang.rust.formatters = { { exe = "rustfmt" } }

require("lspconfig").zeta_note.setup({
	cmd = { "zeta-note" },
	on_attach = require("lvim.lsp").common_on_attach,
	on_init = require("lvim.lsp").common_on_init,
	capabilities = require("lvim.lsp").common_capabilities(),
})

-- Go to previously opened buffer, which is more ergonomic
vim.api.nvim_set_keymap("n", "<S-TAB>", ":b#<CR>", { noremap = true, silent = true })
-- Use the tab key match bracket pairs. It's a hell of a lot easier to type <tab> than <%>
vim.api.nvim_set_keymap("n", "<TAB>", "%", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<TAB>", "%", { noremap = true, silent = true })
-- <C-q> not my taste
vim.api.nvim_set_keymap("", ",q", ":call QuickFixToggle()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
	"n",
	",A",
	"<cmd>lua require('telescope.builtin').live_grep({default_text = vim.fn.expand('<cword>')})<cr>",
	{}
)
-- Tweak terminal
vim.api.nvim_set_keymap("n", ",t", ":terminal<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<ESC>", "<C-\\><C-N>:bd!<cr>", { noremap = true, silent = true })

vim.cmd("set timeoutlen=300")
vim.cmd("nnoremap ; :")
vim.cmd([[
" Don’t reset cursor to start of line when moving around.
set nostartofline

set foldlevel=99
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

set showbreak=↪
set lcs=tab:▸\ ,eol:¬,nbsp:_
" Shortcut to rapidly toggle `set list`
nmap ,l :set list!<CR>

" Copy current buffer absolute path to system clipboard
nnoremap ,yp :let @*=expand("%:p")<cr>:echo "Copied file path to clipboard"<cr>
" Copy current filename to system clipboard
nnoremap ,yf :let @*=expand("%:t")<cr>:echo "Copied file name to clipboard"<cr>
" Copy current buffer absolute path without filename to system clipboard
nnoremap ,yd :let @*=expand("%:p:h")<cr>:echo "Copied file directory to clipboard"<cr>

" vertical line ruler
map ,ch :call SetColorColumn()<CR>
function! SetColorColumn()
  let col_num = virtcol(".")
  let cc_list = split(&cc, ',')
  if count(cc_list, string(col_num)) <= 0
    execute "set cc+=".col_num
  else
    execute "set cc-=".col_num
  endif
endfunction

" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
  let spccol = repeat(' ', a:cols)
  let result = substitute(a:indent, spccol, '\t', 'g')
  let result = substitute(result, ' \+\ze\t', '', 'g')
  if a:what == 1
    let result = substitute(result, '\t', spccol, 'g')
  endif
  return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
  let savepos = getpos('.')
  let cols = empty(a:cols) ? &tabstop : a:cols
  execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
  call histdel('search', -1)
  call setpos('.', savepos)
endfunction
command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)
]])

--[[
# Tips and Tricks

## Search and replace in quickfix window
- `:cdo s/from/to`
- `:cfdo update`
- Even `:cfdo undo`
Combile with nvim-bqf's ability to filter items of quickfix list can be powerful.
Simply as `<tab>` to sign item, `zn` to create new list for signed items.
See https://github.com/kevinhwang91/nvim-bqf#function-table for more info.

## Toggle help window
1. Inside help window, just :q
2. Outside help window, <C-w>o or :on[ly] Make the current window the only one on the screen.

## Terminal Usage
- Just use tmux, and CTRL-D to exit
- Or if use :terminal, tnoremap :bd! to exist quickly
--]]
