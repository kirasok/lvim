local ls = require "luasnip"
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
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l
local postfix = require("luasnip.extras.postfix").postfix

return {
  s("example", {
    -- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
    i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
  }),
  -- TODO: move to autosnippet
  s({
    trig = "beg",
    desc = "begin{} / end{}"
  }, {
    t("\\begin{"), i(1), t("}"),
    t("\t"), i(0),
    t("\\end{"), i(1), t("}")
  })
},
    {
      s("auto", {
        t("begin our journey to automatic super duper snippets")
      })
    }
