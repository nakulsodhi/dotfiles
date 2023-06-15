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





ls.add_snippets("tex",
{

--TODO:rewrite using fmt 
    s("quickstart", {
        t({"%! TeX root = main.tex","","\\documentclass{article}","", "\\usepackage{amsmath,inputenc,graphicx}",""}),
        t("\\title{"),
        i(1,"title"),
        t({"}",""}),
        t({"\\author{Nakul Sodhi}",""}),
        t({"\\begin{document}","","\\maketitle",""}),
        i(2),
        t({"","\\end{document}"})

    })
})

ls.add_snippets("python",
{
    s({trig="doc_scr",dscr="Docstring template for script"}, fmt(
   [[ """
    PURPOSE: <>
    AUTHOR: <>
    DATE: <> 
    PARAMETERS: <>
    COMMENTS: <>
    """   ]],
    {i(1),i(2),i(3),i(4),i(5)},
    {delimiters = "<>"}
    )

    )}
)

ls.add_snippets("mail", {
    s({trig="para", dscr="new paragraph"},fmt(
    [[
    <p>
    {}<br>
    </p>
    ]], {i(1,"Type Here")}, {delimiters="{}"}
    )
    )
})

ls.add_snippets("mail", {
    s({trig="newline", dscr="new line"},fmt(
    [[
    <br>
    {}
    ]], {i(1,"Type Here")}, {delimiters="{}"}
    )
    )
})


