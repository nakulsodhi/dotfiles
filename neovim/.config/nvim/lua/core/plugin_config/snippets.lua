local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet


<<<<<<< HEAD

=======
local filename = function()
  return f(function(_args, snip)
    local name = vim.split(snip.snippet.env.TM_FILENAME, ".", true)
    return name[1] or ""
  end)
end
>>>>>>> 8e91809 (First Commit)


ls.add_snippets("tex",
{

--TODO:rewrite using fmt 
    s("quickstart", {
<<<<<<< HEAD
        t({"%! TeX root = main.tex","","\\documentclass{article}","", "\\usepackage{amsmath,inputenc,graphicx}",""}),
        t("\\title{"),
        i(1,"title"),
        t({"}",""}),
        t({"\\author{Nakul Sodhi}",""}),
        t({"\\begin{document}","","\\maketitle",""}),
        i(2),
        t({"","\\end{document}"})

    })
=======
        t({"%! TeX root ="}),
        i(1,"filename"),
        t({"","\\documentclass{article}","", "\\usepackage{amsmath,inputenc,graphicx}",""}),
        t("\\title{"),
        i(2,"title"),
        t({"}",""}),
        t({"\\author{Nakul Sodhi}",""}),
        t({"\\begin{document}","","\\maketitle",""}),
        i(3),
        t({"","\\end{document}"})

    }),

>>>>>>> 8e91809 (First Commit)
})


ls.add_snippets("eml",{
    s("n", 
    fmt(
    [[
    <p>
    {}
    </p>
    ]],
    {i(1)},
    { delimiters = "{}" }
    ))
})
