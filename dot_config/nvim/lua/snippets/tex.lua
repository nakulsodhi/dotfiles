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


 
-- Some LaTeX-specific conditional expansion functions (requires VimTeX)

local tex_utils = {}
tex_utils.in_mathzone = function()  -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function()  -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() == 1
end
tex_utils.in_env = function(name)  -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
tex_utils.in_equation = function()  -- equation environment detection
    return tex_utils.in_env('equation')
end
tex_utils.in_itemize = function()  -- itemize environment detection
    return tex_utils.in_env('itemize')
end
tex_utils.in_tikz = function()  -- TikZ picture environment detection
    return tex_utils.in_env('tikzpicture')
end



return {
-- non-auto snippets go here

    s(
    {trig = "boilerplate"}, fmta(
[[
%! TeX root=main.tex
\documentclass{article}

\usepackage{amsmath,inputenc,graphicx}
\usepackage[a4paper,margin=1in,top=2cm,bottom=4cm]{geometry}

\title{<>}
\author{Nakul Sodhi}
\begin{document}
<>
\end{document}
]], 
    {i(1),i(2)}) ),

    s(
    {trig= "figure"}, 
    fmta(
[[
\begin{figure}[H]
    \begin{center}
        \includegraphics[scale=<>]{./<>}
    \end{center}
    \caption{<>}
\end{figure}
<>
]]
, {i(1, "0.5"), i(2, "path"), i(3, "Figure"), i(4)}),
{condition = tex_utils.in_text}),
},

{
-- auto snippets go here. The way the plugins are loaded, the second returned table i.e this one will automatically become autosnippets
-- For more information, check out :help luasnip-loaders-lua

    s(
    {trig = "sec", snippetType="autosnippet"}, 
    fmta("\\section{<>}<>", {i(1), i(2)}),
    {condition = tex_utils.in_text}
    ),

    s(
    {trig = "ssec"}, 
    fmta("\\subsection{<>}<>", {i(1), i(2)}),
    {condition = tex_utils.in_text}
    ),

    s(
    {trig= "sssec"}, 
    fmta("\\subsubsection{<>}<>", {i(1), i(2)}),
    {condition = tex_utils.in_text}
    ),

    s(
    {trig = "beg", snippetType="autosnippet"}, 
    fmta("\\begin{<>}\n<>\n\\end{<>}", {i(1), i(2), rep(1)}),
    {condition = ( tex_utils.in_text )}
    ),

     s(
    {trig = "pycode"}, 
    fmta("\\begin{lstlisting}[language=Python]\n<>\n\\end{lstlisting}<>", {i(1), i(2)}),
    {condition = ( tex_utils.in_text )}
    ),

     s(
    {trig = "matcode"}, 
    fmta("\\begin{lstlisting}[language=Matlab]\n<>\n\\end{lstlisting}<>", {i(1), i(2)}),
    {condition = ( tex_utils.in_text )}
    ),

     s(
    {trig = "cppcode"}, 
    fmta("\\begin{lstlisting}[language=C++]\n<>\n\\end{lstlisting}<>", {i(1), i(2)}),
    {condition = ( tex_utils.in_text )}
    ),

    s(
    "enumerate", 
    fmta("\\begin{enumerate}\n\\item <>\n\\end{enumerate}<>", {i(1), i(2)}),
    {condition = function() return (tex_utils.in_text() and (not tex_utils.in_env('enumerate'))) end }
    ),

s(
    "itemize", 
    fmta("\\begin{itemize}\n\\item <>\n\\end{itemize}<>", {i(1), i(2)}),
    {condition = function() return (tex_utils.in_text() and (not tex_utils.in_env('itemize'))) end }
    ),



    s(
        {trig = "dm", }, 
        fmta("$$\n    <>\n$$", {i(1)}), 
        {condition=tex_utils.in_text} ),



    s({trig="mk", snippetType = "autosnippet"}, 
    fmta("$<>$", {i(1)}), 
    {condition=tex_utils.in_text} ),


    s({trig="(.*)_", snippetType = "autosnippet", regTrig="true"}, 
    fmta("<>\\_<>", { f(function(_, snip) return snip.captures[1] end), i(1)}), 
    {condition=tex_utils.in_text} ),


    -- math stuff
    s({trig="([a-zA-Z])(%d)", regTrig = true, wordTrig = false}, 
    fmta("<>_{<>}<>",
    {f(function(_, snip) return snip.captures[1] end),
     f(function(_, snip) return snip.captures[2] end),
     i(1)}),
    {condition=tex_utils.in_mathzone}),

    --postfix
    s({trig="([a-zA-Z])(bar|hat|vec|dot|ddot|tilde|und)", trigEngine="ecma"}, 
    fmta("\\<>{<>}<>",
    {f(function(_, snip) return snip.captures[2] end),
     f(function(_, snip) return snip.captures[1] end),
     i(1)}),
    {condition=tex_utils.in_mathzone}),








    s({trig="([a-zA-Z\\}0-9]+)po",regTrig = true},
    fmta("<>^{<>}<>", 
    {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
        i(2)
    }),
    {condition=tex_utils.in_mathzone}),

    s({trig="([a-zA-Z\\}0-9]*)_",regTrig = true},
    fmta("<>_{<>}<>", 
    {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
        i(2)
    }),
    {condition=tex_utils.in_mathzone}),

    s({trig="([a-zA-Z\\}0-9]*)^",regTrig = true},
    fmta("<>^{<>}<>",
    {
        f(function(_, snip) return snip.captures[1] end),
        i(1),
        i(2)
    }),
    {condition=tex_utils.in_mathzone}),

--    s({trig="[^\\]text", trigEngine = "pattern"}, 
--    fmta("\\text{<>}<>", {i(1),i(2)}),
--    {condition = tex_utils.in_mathzone}),

-- greek letters
-- negative lookbehind (?<!a-z) asserts that if the following pattern
-- is preceded by a-z, it is not matched
    s({trig=[[(?<!\\)([a-zA-Z}0-9]*)([Aa]lpha|[Bb]eta|chi|[Gg]amma|[Dd]elta|[Tt]heta|[nN]u|[Pp]hi|psi|pi|mu|kappa|[Ll]ambda|rho|[Ee]psilon|varepsilon|eta|[Ss]igma|[Oo]mega)]], 
    trigEngine = "ecma", wordTrig = false }, 
    fmta(" <>\\<> <>", { f(function(_, snip) return snip.captures[1] end),f(function(_, snip) return snip.captures[2] or snip.captures[1] end), i(1)}),
    {condition = tex_utils.in_mathzone}),


    s({trig="@a"}, 
    fmta("\\alpha", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@A"}, 
    fmta("\\Alpha", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@b"}, 
    fmta("\\beta", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@B"}, 
    fmta("\\Beta", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@g"}, 
    fmta("\\gamma", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@G"}, 
    fmta("\\Gamma", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@d"}, 
    fmta("\\delta", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@D"}, 
    fmta("\\Delta", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@c"}, 
    fmta("\\chi", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@C"}, 
    fmta("\\chi", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@e"}, 
    fmta("\\epsilon", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@E"}, 
    fmta("\\epsilon", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig=":e"}, 
    fmta("\\varepsilon", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig=":E"}, 
    fmta("\\varepsilon", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@z"}, 
    fmta("\\zeta", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@Z"}, 
    fmta("\\zeta", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@t"}, 
    fmta("\\theta", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@T"}, 
    fmta("\\Theta", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@k"}, 
    fmta("\\kappa", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@K"}, 
    fmta("\\kappa", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@l"}, 
    fmta("\\lambda", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@L"}, 
    fmta("\\Lambda", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@m"}, 
    fmta("\\mu", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@M"}, 
    fmta("\\mu", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@r"}, 
    fmta("\\rho", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@R"}, 
    fmta("\\rho", {}), 
    {condition=tex_utils.in_mathzone} ),

    s({trig="@s"},
    fmta("\\sigma", {}),
    {condition=tex_utils.in_mathzone} ),

    s({trig="@S"},
    fmta("\\Sigma", {}),
    {condition=tex_utils.in_mathzone} ),

    s({trig="@o"},
    fmta("\\omega", {}),
    {condition=tex_utils.in_mathzone} ),

    s({trig="@O"},
    fmta("\\Omega", {}),
    {condition=tex_utils.in_mathzone} ),

    s({trig="([a-zA-Z}0-9]*)ome", trigEngine="pattern"},
    fmta("<>\\omega<>", {f(function (_, snip) return snip.captures[1] end), i(1)}),
    {condition=tex_utils.in_mathzone} ),


    s({trig="([a-zA-Z}0-9]*)infty", trigEngine="pattern"},
    fmta("<>\\infty <>", {f(function (_, snip) return snip.captures[1] end), i(1)}),
    {condition=tex_utils.in_mathzone} ),


    s({trig="([a-zA-Z}0-9]*)ooo", trigEngine="pattern"},
    fmta("<>\\infty <>", {f(function (_, snip) return snip.captures[1] end), i(1)}),
    {condition=tex_utils.in_mathzone} ),


    s({trig="([a-zA-Z}0-9]?)<=", trigEngine="pattern"},
    fmta("<>\\leq <>", {f(function (_, snip) return snip.captures[1] end), i(1)}),
    {condition=tex_utils.in_mathzone} ),

    s({trig="([a-zA-Z}0-9]?)!=", trigEngine="pattern"},
    fmta("<>\\neq <>", {f(function (_, snip) return snip.captures[1] end), i(1)}),
    {condition=tex_utils.in_mathzone} ),

    s({trig="([a-zA-Z}0-9]?)>=", trigEngine="pattern"},
    fmta("<>\\geq <>", {f(function (_, snip) return snip.captures[1] end), i(1)}),
    {condition=tex_utils.in_mathzone} ),


--    s({trig="([a-zA-Z}0-9]?)+-", trigEngine="pattern"},
--    fmta("<>\\pm <>", {f(function (_, snip) return snip.captures[1] end), i(1)}),
--    {condition=tex_utils.in_mathzone} ),
--
--
--    s({trig="([a-zA-Z}0-9]?)\\-\\+", trigEngine="pattern"},
--    fmta("<>\\mp <>", {f(function (_, snip) return snip.captures[1] end), i(1)}),
--    {condition=tex_utils.in_mathzone} ),
--
-- For some reason this didnt work with trigengine pattern, so using ecma
    s({trig="([a-zA-Z}0-9]?)\\<\\-\\>", trigEngine="ecma"},
    fmta("<>\\leftrightarrow <>", {f(function (_, snip) return snip.captures[1] end), i(1)}),
    {condition=tex_utils.in_mathzone} ),

    s({trig="([a-zA-Z}0-9]?)\\-\\>", trigEngine="ecma"},
    fmta("<>\\to <>", {f(function (_, snip) return snip.captures[1] end), i(1)}),
    {condition=tex_utils.in_mathzone} ),

    s({trig="([a-zA-Z}0-9]?)\\=\\>", trigEngine="ecma"},
    fmta("<>\\implies <>", {f(function (_, snip) return snip.captures[1] end), i(1)}),
    {condition=tex_utils.in_mathzone} ),

    s({trig=[[(?<!\\)(times)]],
    trigEngine = "ecma", wordTrig = false },
    fmta(" \\<> <>", { f(function(_, snip) return snip.captures[1] end), i(1)}),
    {condition = tex_utils.in_mathzone}),


    s({trig=[[(?<!\\)(text)]],
    trigEngine = "ecma", wordTrig = false },
    fmta(" \\<>{<>}", { f(function(_, snip) return snip.captures[1] end), i(1)}),
    {condition = tex_utils.in_mathzone}),

    -- The regex pattern works now. To compile this regex, lua passes this
    -- string to the ECMAscript compiler. the compiler also treats backslash
    -- as an escape character. Therefore, to negative lookbehind one backslash
    -- you would use (?<!\\) in regex101 but here we would need 4(!) backslashes
    -- OR we could just use the non escapeable string literal [[]]  datatype
    -- with two slashes.



    s({trig=[[(?<!\\)([a-zA-Z}0-9]*)(arcsin|arccos|arctan|arccot|arccsc|arcsec|sin|cos|tan|cot|csc|sec)]], 
    trigEngine = "ecma", wordTrig = false }, 
    fmta(" <>\\<> <>", { f(function(_, snip) return snip.captures[1] end),f(function(_, snip) return snip.captures[2] or snip.captures[1] end), i(1)}),
    {condition = tex_utils.in_mathzone}),

    s({trig="mono"},
    fmta("\\texttt{<>}", {i(1)}),
    {condition = tex_utils.in_text}),



    s({trig="([a-zA-Z}0-9]*)sr", trigEngine="pattern"},
    fmta("<>^{2}<>", {f(function (_, snip) return snip.captures[1] end), i(1)}),
    {condition=tex_utils.in_mathzone} ),


    s({trig="([a-zA-Z\\}0-9]*)xx", trigEngine="pattern"},
    fmta("<>\\times<>", {f(function (_, snip) return snip.captures[1] end),i(1)}),
    {condition=tex_utils.in_mathzone} ),

    s({trig="sq"},
    fmta("\\sqrt{ <> }", {i(1)}),
    {condition=tex_utils.in_mathzone} ),






    -- integration
    s({trig="oinf"},
    fmta("\\int_{0}^{\\infty} <> \\,d<>", {i(1), i(2,"t")}),
    {condition=tex_utils.in_mathzone}),

    s({trig="infi"},
    fmta("\\int_{-\\infty}^{\\infty} <> \\,d<>", {i(1), i(2,"t")}),
    {condition=tex_utils.in_mathzone}),

    s({trig="int"},
    fmta("\\int <> \\,d<>", {i(1), i(2,"t")}),
    {condition=tex_utils.in_mathzone}),



    --fractions


    s({trig="//"},
    fmta("\\frac{<>}{<>}<>",{i(1),i(2),i(3)}),
    {condition=tex_utils.in_mathzone}),

    s({trig=[[((\d+)|(\d*)(\\)?([A-Za-z]+)((\^|_)(\{\d+\}|\d))*)\/]], trigEngine="ecma"},
    fmta("\\frac{<>}{<>}<>",{f(function(_, snip) return snip.captures[1] end),
    i(1),i(2)}),
    {condition=tex_utils.in_mathzone}),

    s({trig=[[\(([^)(]*(?:\([^)(]*(?:\([^)(]*(?:\([^)(]*\)[^)(]*)*\)[^)(]*)*\)[^)(]*)*)\)\/]], trigEngine="ecma"},
    fmta("\\frac{<>}{<>}<>",{f(function(_, snip) return snip.captures[1] end),
    i(1),i(2)}),
    {condition=tex_utils.in_mathzone}),

}

