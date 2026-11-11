-- ~/.config/nvim/init.lua
-- Line numbers + a colour scheme built from Ghostty's base16-black-metal theme.
--
-- Accents (straight from the terminal palette):
--   teal     #5f8787  keywords: def, return, if, import ...
--   pink     #dd9999  strings
--   oxblood  #a06666  numbers, constants, types, decorators
-- Everything else is told apart by grey level and italics.

---------------------------------------------------------------------------
-- Options
---------------------------------------------------------------------------
vim.opt.number = true           -- line numbers
vim.opt.relativenumber = false  -- set to true for relative numbers
vim.opt.cursorline = true       -- faint bar on the current line
vim.opt.signcolumn = "yes"      -- keep text from shifting when signs appear
vim.opt.termguicolors = true    -- Ghostty does 24-bit colour
vim.opt.wrap = true             -- soft-wrap long lines
vim.opt.linebreak = true        -- wrap on word boundaries, not mid-word
vim.opt.breakindent = true      -- wrapped continuations keep the line's indent

---------------------------------------------------------------------------
-- Palette
---------------------------------------------------------------------------
local p = {
  bg       = "#000000", -- base00, terminal background
  bg1      = "#121212", -- base01, cursor line, menus
  bg2      = "#222222", -- base02, selection (same as Ghostty's)
  bg3      = "#333333", -- base03, borders, end-of-buffer
  gutter   = "#444444", -- base0F, line numbers
  comment  = "#6c6c6c", -- lifted from #333333 so comments are readable
  dim      = "#888888", -- base0D, punctuation and operators
  grey     = "#999999", -- base04, builtins and self
  fg       = "#c1c1c1", -- base05, normal text
  bright   = "#eeeeee", -- function names, titles
  teal     = "#5f8787", -- base08
  pink     = "#dd9999", -- base0B
  oxblood  = "#a06666", -- base0A
  docpink  = "#af8787", -- softer pink for docstrings
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.g.colors_name = "black-metal"

---------------------------------------------------------------------------
-- Editor UI
---------------------------------------------------------------------------
-- No bg on Normal, so Ghostty's own background (and opacity) shows through.
hi("Normal",       { fg = p.fg })
hi("NormalNC",     { fg = p.fg })
hi("NormalFloat",  { fg = p.fg, bg = p.bg1 })
hi("FloatBorder",  { fg = p.gutter, bg = p.bg1 })
hi("FloatTitle",   { fg = p.bright, bg = p.bg1, bold = true })

hi("LineNr",       { fg = p.gutter })
hi("CursorLineNr", { fg = p.fg, bold = true })
hi("CursorLine",   { bg = p.bg1 })
hi("CursorColumn", { bg = p.bg1 })
hi("ColorColumn",  { bg = p.bg1 })
hi("SignColumn",   {})
hi("FoldColumn",   { fg = p.gutter })
hi("Folded",       { fg = p.comment, bg = p.bg1, italic = true })
hi("NonText",      { fg = p.bg3 })
hi("EndOfBuffer",  { fg = p.bg3 })
hi("Whitespace",   { fg = p.bg3 })
hi("WinSeparator", { fg = p.bg3 })
hi("Conceal",      { fg = p.dim })

hi("Visual",       { bg = p.bg2 })
hi("Search",       { fg = p.bg, bg = p.oxblood })
hi("IncSearch",    { fg = p.bg, bg = p.pink, bold = true })
hi("CurSearch",    { link = "IncSearch" })
hi("Substitute",   { fg = p.bg, bg = p.pink })
hi("MatchParen",   { fg = p.bright, bg = p.bg3, bold = true })

hi("StatusLine",   { fg = p.fg, bg = p.bg2 })
hi("StatusLineNC", { fg = p.comment, bg = p.bg1 })
hi("TabLine",      { fg = p.comment, bg = p.bg1 })
hi("TabLineSel",   { fg = p.bright, bg = p.bg2, bold = true })
hi("TabLineFill",  { bg = p.bg1 })
hi("WinBar",       { fg = p.fg, bold = true })
hi("WinBarNC",     { fg = p.comment })

hi("Pmenu",        { fg = p.fg, bg = p.bg1 })
hi("PmenuSel",     { fg = p.bright, bg = p.bg3, bold = true })
hi("PmenuSbar",    { bg = p.bg2 })
hi("PmenuThumb",   { bg = p.gutter })

hi("Directory",    { fg = p.teal })
hi("Title",        { fg = p.bright, bold = true })
hi("ErrorMsg",     { fg = p.pink, bold = true })
hi("WarningMsg",   { fg = p.oxblood })
hi("MoreMsg",      { fg = p.teal })
hi("Question",     { fg = p.teal })
hi("ModeMsg",      { fg = p.fg, bold = true })

hi("DiffAdd",      { fg = p.teal })
hi("DiffDelete",   { fg = p.oxblood })
hi("DiffChange",   { fg = p.grey })
hi("DiffText",     { fg = p.pink, bold = true })

hi("SpellBad",     { undercurl = true, sp = p.pink })
hi("SpellCap",     { undercurl = true, sp = p.oxblood })
hi("SpellRare",    { undercurl = true, sp = p.teal })
hi("SpellLocal",   { undercurl = true, sp = p.grey })

---------------------------------------------------------------------------
-- Code (classic syntax groups; tree-sitter groups link to these by default)
---------------------------------------------------------------------------
hi("Comment",      { fg = p.comment, italic = true })

hi("String",       { fg = p.pink })
hi("Character",    { fg = p.pink })
hi("SpecialChar",  { fg = p.oxblood })              -- \n, {} in f-strings

hi("Constant",     { fg = p.oxblood })
hi("Number",       { fg = p.oxblood })
hi("Float",        { fg = p.oxblood })
hi("Boolean",      { fg = p.oxblood })

hi("Identifier",   { fg = p.fg })
hi("Function",     { fg = p.bright })

hi("Statement",    { fg = p.teal })
hi("Keyword",      { fg = p.teal })
hi("Conditional",  { fg = p.teal })
hi("Repeat",       { fg = p.teal })
hi("Exception",    { fg = p.teal })
hi("Label",        { fg = p.teal })
hi("Operator",     { fg = p.dim })

hi("PreProc",      { fg = p.teal })
hi("Include",      { fg = p.teal })                 -- import / from
hi("Define",       { fg = p.teal })
hi("Macro",        { fg = p.oxblood })

hi("Type",         { fg = p.oxblood, bold = true }) -- classes, int, float
hi("StorageClass", { fg = p.teal })
hi("Structure",    { fg = p.oxblood, bold = true })
hi("Typedef",      { fg = p.oxblood, bold = true })

hi("Special",      { fg = p.grey })
hi("Delimiter",    { fg = p.dim })                  -- ( ) [ ] , :
hi("Underlined",   { underline = true })
hi("Error",        { fg = p.pink, bold = true })
hi("Todo",         { fg = p.bg, bg = p.oxblood, bold = true })

---------------------------------------------------------------------------
-- Tree-sitter extras (only matter once a parser is installed)
---------------------------------------------------------------------------
hi("@variable",             { fg = p.fg })
hi("@variable.builtin",     { fg = p.grey, italic = true })   -- self, cls
hi("@variable.parameter",   { fg = p.fg, italic = true })
hi("@variable.member",      { fg = p.fg })
hi("@property",             { fg = p.fg })
hi("@module",               { fg = p.fg })
hi("@function.call",        { fg = p.fg })
hi("@function.method.call", { fg = p.fg })
hi("@function.builtin",     { fg = p.grey, italic = true })   -- print, len
hi("@constant.builtin",     { fg = p.oxblood, italic = true })-- None, True
hi("@attribute",            { fg = p.oxblood, italic = true })-- @decorators
hi("@string.documentation", { fg = p.docpink, italic = true })
hi("@punctuation",          { fg = p.dim })

-- Vim's built-in Python syntax (used when no parser is installed)
hi("pythonBuiltin",       { link = "@function.builtin" })
hi("pythonDecorator",     { link = "@attribute" })
hi("pythonDecoratorName", { link = "@attribute" })
hi("pythonExceptions",    { fg = p.oxblood })

---------------------------------------------------------------------------
-- Diagnostics (LSP / linters)
---------------------------------------------------------------------------
hi("DiagnosticError", { fg = p.pink })
hi("DiagnosticWarn",  { fg = p.oxblood })
hi("DiagnosticInfo",  { fg = p.teal })
hi("DiagnosticHint",  { fg = p.dim })
hi("DiagnosticOk",    { fg = p.teal })
hi("DiagnosticUnderlineError", { undercurl = true, sp = p.pink })
hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = p.oxblood })
hi("DiagnosticUnderlineInfo",  { undercurl = true, sp = p.teal })
hi("DiagnosticUnderlineHint",  { undercurl = true, sp = p.dim })

---------------------------------------------------------------------------
-- Plugin manager (lazy.nvim)
---------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
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

require("lazy").setup({
  spec = {
    {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      build = ":TSUpdate",
      config = function()
        require("nvim-treesitter").setup({})
        require("nvim-treesitter").install({ "markdown", "markdown_inline" })
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "markdown" },
          callback = function(ev)
            vim.treesitter.start(ev.buf)
          end,
        })
      end,
    },
    {
      "nvim-mini/mini.nvim",
      version = false,
      config = function()
        require("mini.icons").setup()
      end,
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
      ---@module "render-markdown"
      ---@type render.md.UserConfig
      opts = {
        bullet = {
          -- Extra indent per nest level (including first level).
          left_pad = function(ctx)
            return ctx.level * 2
          end,
        },
        -- Soft-wrapped bullet text stays indented with the list item.
        win_options = {
          wrap = { default = vim.o.wrap, rendered = true },
          linebreak = { default = vim.o.linebreak, rendered = true },
          breakindent = { default = vim.o.breakindent, rendered = true },
          -- list:-1 = hang-indent under the bullet; shift:2 ≈ first-level left_pad
          breakindentopt = {
            default = vim.o.breakindentopt,
            rendered = "list:-1,shift:2",
          },
        },
      },
      config = function(_, opts)
        require("render-markdown").setup(opts)
        -- So breakindentopt list:-1 matches markdown bullets (- * +) too.
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "markdown",
          callback = function()
            vim.opt_local.formatlistpat =
              [[^\s*\d\+[\]:.)}\t ]\s\+\|^\s*[-*+]\s\+]]
          end,
        })
      end,
    },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = true },
})
