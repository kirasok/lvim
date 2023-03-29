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
local ms = ls.multi_snippet

return {
  s("template", {
    t({
      "\\documentclass[a4paper]{IEEEtran}",
      "",
      "\\usepackage[utf8]{inputenc}",
      "\\usepackage[T2A]{fontenc}",
      "\\usepackage{textcomp}",
      "\\usepackage{amsmath, amssymb, amsfonts, amsthm}",
      "\\usepackage{import}",
      "\\usepackage{pdfpages}",
      "\\usepackage{transparent}",
      "\\usepackage{xcolor}",
      "",
      "\\newcommand{\\incfig}[2][1]{%",
      "\t\t\\def\\svgwidth{#1\\columnwidth}",
      "\t\t\\import{./figures/}{#2.pdf_tex}",
      "}",
      "",
      "\\newtheorem{theorem}{Theorem}[section]",
      "\\newtheorem{lemma}[theorem]{Lemma}",
      "",
      "\\pdfsuppresswarningpagegroup=1",
      "",
      "\\hyphenation{op-tical net-works semi-conduc-tor IEEE-Xplore}",
      "",
      "\\title{",
    }),
    i(1),
    t({
      "}",
      "\\author{",
    }),
    i(2),
    t({
      "}",
      "",
      "\\begin{document}",
      "\\maketitle",
      "\\markboth{",
    }),
    i(3, "Lectures|Seminars|Labs"),
    t({
      ", \\today}",
      "{Shell \\MakeLowercase{\\textit{et al.}}: A Sample Article Using IEEEtran.cls for IEEE Journals}",
      "",
      "\\begin{abstract}",
      "\t\t",
    }),
    i(4),
    t({
      "",
      "\\end{abstract}",
      "",
      "\\tableofcontents",
      "\\newpage",
      "",
      "",
    }),
    i(0),
    t({
      "",
      "",
      "\\end{document}"
    })
  })
}
