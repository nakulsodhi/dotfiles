require("luasnip").config.set_config({
    enable_autosnippets = true,
})

function loadSnippets() 
    require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/lua/snippets/"})
end


loadSnippets()
