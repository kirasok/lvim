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
  s("veryaccurate", t("exact")),
  s("veryafraid", c(1, {
    t("fearful"),
    t("terrified")
  })
  ),
  s("veryangry", t("furious")),
  s("veryannoying", t("exasperating")),
  s("verybad", c(1, {
    t("atrocious"),
    t("awful")
  })
  ),
  s("verybeautiful", c(1, {
    t("exquisite"),
    t("gorgeous")
  })
  ),
  s("verybig", c(1, {
    t("immense"),
    t("massive")
  })
  ),
  s("veryboring", t("dull")),
  s("verybright", c(1, {
    t("dazzling"),
    t("luminous")
  })
  ),
  s("verybusy", t("swamped")),
  s("verycalm", t("serene")),
  s("verycapable", t("accomplished")),
  s("verycareful", t("cautious")),
  s("verycheap", t("stingy")),
  s("veryclean", t("spotless")),
  s("veryclear", t("obvious")),
  s("veryclever", t("brilliant")),
  s("verycold", t("freezing")),
  s("verycolorful", t("vibrant")),
  s("verycolourful", t("vibrant")),
  s("verycompetitive", t("cutthroat")),
  s("verycomplete", t("comprehensive")),
  s("veryconfused", t("perplexed")),
  s("veryconventional", t("conservative")),
  s("verycreative", t("innovative")),
  s("verycrowded", t("bustling")),
  s("verycute", t("adorable")),
  s("verydangerous", t("perilous")),
  s("verydear", t("cherished")),
  s("verydeep", t("profound")),
  s("verydepressed", t("despondent")),
  s("verydetailed", t("meticulous")),
  s("verydifferent", t("disparate")),
  s("verydifficult", t("arduous")),
  s("verydirty", c(1, {
    t("filthy"),
    t("squalid")
  })
  ),
  s("verydry", c(1, {
    t("arid"),
    t("parched")
  })
  ),
  s("verydull", t("tedious")),
  s("veryeager", t("keen")),
  s("veryeasy", t("effortless")),
  s("veryempty", t("desolate")),
  s("veryevil", t("wicked")),
  s("veryexcited", t("thrilled")),
  s("veryexciting", t("exhilarating")),
  s("veryexpensive", t("costly")),
  s("veryfancy", t("lavish")),
  s("veryfast", t("quick")),
  s("veryfat", t("obese")),
  s("veryfierce", t("ferocious")),
  s("veryfriendly", t("amiable")),
  s("veryfrightened", c(1, {
    t("alarmed"),
    t("terrified")
  })
  ),
  s("veryfrightening", c(1, {
    t("alarming"),
    t("terrifying")
  })
  ),
  s("veryfunny", t("hilarious")),
  s("veryglad", t("overjoyed")),
  s("verygood", c(1, {
    t("excellent"),
    t("superb")
  })
  ),
  s("verygreat", t("terrific")),
  s("veryhappy", c(1, {
    t("ecstatic"),
    t("jubilant")
  })
  ),
  s("veryhard", t("difficult")),
  s("veryhard-to-find", t("rare")),
  s("veryheavy", t("leaden")),
  s("veryhigh", t("soaring")),
  s("veryhot", c(1, {
    t("scalding"),
    t("sweltering")
  })
  ),
  s("veryhuge", t("colossal")),
  s("veryhungry", c(1, {
    t("ravenous"),
    t("starving")
  })
  ),
  s("veryhurt", t("battered")),
  s("veryimportant", t("crucial")),
  s("veryintelligent", t("brilliant")),
  s("veryinteresting", t("captivating")),
  s("verykind", t("compassionate")),
  s("verylarge", c(1, {
    t("colossal"),
    t("huge")
  })
  ),
  s("verylazy", t("indolent")),
  s("verylight", t("luminous")),
  s("verylittle", t("tiny")),
  s("verylively", t("vivacious")),
  s("verylong", t("extensive")),
  s("verylong-term", t("enduring")),
  s("veryloose", t("slack")),
  s("veryloud", t("deafening")),
  s("veryloved", t("adored")),
  s("verylovely", t("adorable")),
  s("verymean", t("cruel")),
  s("verymessy", t("slovenly")),
  s("veryneat", t("immaculate")),
  s("verynecessary", t("essential")),
  s("verynervous", t("apprehensive")),
  s("verynice", t("kind")),
  s("verynoisy", t("deafening")),
  s("veryoften", t("frequently")),
  s("veryold", t("ancient")),
  s("veryold-fashioned", t("archaic")),
  s("veryopen", c(1, {
    t("transparent")
  })
  ),
  s("verypainful", t("excruciating")),
  s("verypale", t("ashen")),
  s("veryperfect", t("flawless")),
  s("verypoor", t("destitute")),
  s("verypowerful", t("compelling")),
  s("verypretty", t("beautiful")),
  s("veryquick", t("rapid")),
  s("veryquiet", c(1, {
    t("hushed"),
    t("silent")
  })
  ),
  s("veryrainy", t("pouring")),
  s("veryrich", t("wealthy")),
  s("veryrisky", t("perilous")),
  s("veryroomy", t("spacious")),
  s("veryrude", t("vulgar")),
  s("verysad", c(1, {
    t("morose"),
    t("sorrowful")
  })
  ),
  s("veryscared", t("petrified")),
  s("veryscary", t("chilling")),
  s("veryserious", c(1, {
    t("grave"),
    t("solemn")
  })
  ),
  s("verysharp", t("keen")),
  s("veryshiny", t("gleaming")),
  s("veryshort", t("brief")),
  s("veryshy", t("timid")),
  s("verysimple", t("basic")),
  s("veryskinny", t("skeletal")),
  s("verysleepy", t("lethargic")),
  s("veryslow", t("sluggish")),
  s("verysmall", c(1, {
    t("petite"),
    t("tiny")
  })
  ),
  s("verysmart", t("intelligent")),
  s("verysmelly", t("pungent")),
  s("verysmooth", t("sleek")),
  s("verysoft", t("downy")),
  s("verysorry", t("apologetic")),
  s("veryspecial", t("exceptional")),
  s("verystrong", c(1, {
    t("forceful"),
    t("unyielding")
  })
  ),
  s("verystupid", t("idiotic")),
  s("verysure", t("certain")),
  s("verysweet", t("thoughtful")),
  s("verytalented", t("gifted")),
  s("verytall", t("towering")),
  s("verytasty", t("delicious")),
  s("verythin", t("gaunt")),
  s("verythirsty", t("parched")),
  s("verytight", t("constricting")),
  s("verytiny", t("minuscule")),
  s("verytired", c(1, {
    t("exhausting"),
    t("exhausted")
  })
  ),
  s("veryugly", t("hideous")),
  s("veryunhappy", t("miserable")),
  s("veryupset", t("distraught")),
  s("veryvaluable", t("precious")),
  s("verywarm", t("hot")),
  s("veryweak", c(1, {
    t("frail"),
    t("feeble")
  })
  ),
  s("verywell-to-do", t("wealthy")),
  s("verywet", t("soaked")),
  s("verywicked", t("villainous")),
  s("verywide", t("expansive")),
  s("verywilling", t("eager")),
  s("verywindy", t("blustery")),
  s("verywise", c(1, {
    t("sage"),
    t("sagacious")
  })
  ),
  s("veryworried", c(1, {
    t("anxious"),
    t("distressed")
  })
  )
}
