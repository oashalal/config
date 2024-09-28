require("plugins")
require("autoclose").setup()
require('lualine').setup()

local bo = vim.bo

vim.cmd [[colorscheme night-owl]]
-- vim.cmd [[hi Cursor guifg=black guibg=black]]
-- vim.cmd [[set guicursor=n-i-v-c:block-Cursor/lCursor]]

bo.tabstop = 4
bo.shiftwidth = 4 
bo.expandtab = true
vim.wo.number = true
vim.wo.wrap = false

vim.cmd [[colorscheme catppuccin]]
local lspconfig = require "lspconfig"
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local util = require('lspconfig/util')

require'lspconfig'.kotlin_language_server.setup{
    on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        vim.keymap.set('n', '<M-m>', vim.lsp.buf.format, {})
    end,
    capabilities = capabilities

}

lspconfig.clangd.setup{
    on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        vim.keymap.set('n', '<M-m>', vim.lsp.buf.format, {})
    end,
    capabilities = capabilities
}

lspconfig.gopls.setup{
    filetypes = { 'go', 'go.mod' },
    root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
    on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        vim.keymap.set('n', '<M-m>', vim.lsp.buf.format, {})
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {})
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, {})
    end,
    capabilities = capabilities
}

-- require'lspconfig'.nimsuggest.setup{
--   settings = {
--     nim = {
--       nimsuggestPath = "~/../usr/bin/nimsuggest"
--     }
--   },
--   capabilities = capabilities
-- }

local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup {

  -- formatting = {
  --   format = lspkind.cmp_format({
  --     mode = 'symbol_text',
  --     maxwidth = 50,
  --     ellipsis_char = '...',
  --     before = function (_, vim_item)
  --       return vim_item
  --     end
  --   })
  -- },
  formatting = {
  format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
          -- Cut additional info about autocompleted items
          before = function (_entry, vim_item)
            if (vim_item.menu ~= nil and string.len(vim_item.menu) > 45) then
              vim_item.menu = string.sub(vim_item.menu, 1, 42) .. "..."
            end

            return vim_item
          end
        })
    },

  sources = {
    { name = 'snippy' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'vsnip' },
    { name = 'buffer' }
  },
  snippet = {
    expand = function(args)
      require 'snippy'.expand_snippet(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  completion = {
    keyword_length = 1,
  },
  performance = {
    max_view_entries = 10,
  },
  view = {
    docs = {
      auto_open = false,
    },
  },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<M-z>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
require('nvim-tree').setup()

