-- add undo levels for autosnippets. No need to do anything for manual
-- snippets because that does not make sense
local auto_expand = require("luasnip").expand_auto
require("luasnip").expand_auto = function(...)
    vim.o.undolevels = vim.o.undolevels
    auto_expand(...)
end
