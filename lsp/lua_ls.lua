-- *Should* fix LazyDev
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        pathStrict = false,
      }
    }
  },
})
