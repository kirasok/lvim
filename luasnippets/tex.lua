---@diagnostic disable: undefined-global
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
