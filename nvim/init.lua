vim.pack.add({
  {src='https://github.com/nvim-tree/nvim-tree.lua'},
  {src='https://github.com/nvim-lua/plenary.nvim'},
  {src='https://github.com/nvim-tree/nvim-web-devicons'},
  {src='https://github.com/nvim-telescope/telescope.nvim'},
  {src='https://github.com/nvim-treesitter/nvim-treesitter'},
  {src='https://github.com/neovim/nvim-lspconfig'},
  {src='https://github.com/mason-org/mason.nvim'},
  {src='https://github.com/mason-org/mason-lspconfig.nvim'},
  {src='https://github.com/hrsh7th/nvim-cmp'},
  {src='https://github.com/hrsh7th/cmp-nvim-lsp'},
  {src='https://github.com/L3MON4D3/LuaSnip'},
  {src='https://github.com/windwp/nvim-ts-autotag'},
})

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({
  view ={
    width = 35,
  }
})

-- colorscheme
vim.cmd("syntax on")
vim.cmd("syntax enable")
vim.cmd("packadd! dracula_pro")
vim.g.dracula_colorterm = 0
vim.cmd("colorscheme dracula_pro_alucard")

--vim.api.nvim_set_hl(0, 'CursorLine', {bg = 35})
--vim.api.nvim_set_hl(0, 'ColorColumn', {bg = 35})
vim.api.nvim_set_hl(0, 'DraculaTodo', {bg = 'none'})

-- Visual settings
vim.o.number=true
vim.o.relativenumber=true
vim.o.numberwidth=1
vim.o.cursorline=true

vim.o.clipboard=unnamed,unnamedplus
vim.o.splitright=true
vim.o.splitbelow=true
vim.o.wrap=true
vim.o.linebreak=true
vim.o.autowrite=true
vim.o.textwidth=80
vim.o.colorcolumn="81"
vim.o.autoindent=true
vim.o.incsearch=true
vim.o.hlsearch=true

-- Indentation settings
vim.o.softtabstop=2
vim.o.shiftwidth=2
vim.o.tabstop=2
vim.o.expandtab=true
-- Round indent to multiple of shiftwidth
vim.o.shiftround=true

vim.o.clipboard = 'unnamedplus'

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = 'python',
  callback = function()
    vim.api.nvim_buf_set_option(0, "softtabstop", 4)
    vim.api.nvim_buf_set_option(0, "shiftwidth", 4)
  end
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = 'php',
  callback = function()
    vim.api.nvim_buf_set_option(0, "softtabstop", 4)
    vim.api.nvim_buf_set_option(0, "shiftwidth", 4)
  end
})

vim.g.mapleader = " "

-- tks @philss for the mappings below 👍(from https://github.com/philss/dotfiles)
-- Mapping <tab> to change tabs navigation
vim.api.nvim_set_keymap('n', '<tab>', ':tabnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-tab>', ':tabprevious<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', 'fj', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('i', 'fj', '<esc>', { noremap = true })
vim.api.nvim_set_keymap('v', 'fj', '<esc>', { noremap = true })

-- Make splits navigation easies
vim.api.nvim_set_keymap('n', '<c-k>', '<c-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>l', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-j>', '<c-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w>h', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>q', ':q!<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>w', ':w!<CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>t', ':NvimTreeToggle<CR>', { noremap = true })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>gg', builtin.git_files)
vim.keymap.set('n', '<leader>ff', builtin.find_files)

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "javascript", "typescript", "ruby", "html", "css" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- note: diagnostics are not exclusive to lsp servers
-- so these can be global keybindings
vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>') 

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local default_setup = function(server)
  require('lspconfig')[server].setup({
    capabilities = lsp_capabilities,
  })
end

require('mason').setup({})
require('mason-lspconfig').setup({
  -- https://mason-registry.dev/registry/list
  ensure_installed = {
    'ruby_lsp',
    'ts_ls',
  },
  handlers = {
    default_setup,
  },
})

local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = cmp.mapping.preset.insert({
    -- Enter key confirms completion item
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl + space triggers completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

require('nvim-ts-autotag').setup({
  opts = {
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing </
  },
})
