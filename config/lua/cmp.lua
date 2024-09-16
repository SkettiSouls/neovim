-- Set up nvim-cmp.
local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<TAB>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),

	sources = cmp.config.sources({
		{ name = 'path' },
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
		{ name = 'buffer' },
	}),

	window = {
		completion = cmp.config.window.bordered({
			col_offset = -1,
		}),
		documentation = cmp.config.window.bordered(),
	},

	view = {
		entries = { name = 'custom', selection_order = 'near_cursor' }
	},

	formatting = {
		-- fields = { "kind", "abbr", "menu" },
		format = lspkind.cmp_format({
			mode = "symbol_text",
			menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				latex_symbols = "[Latex]",
			})
		}),
	},
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' },
		{ name = 'buffer' },
	})
})
