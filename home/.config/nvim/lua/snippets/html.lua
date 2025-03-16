local luasnip = require("luasnip")
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node

local function htmlSnip(element)
    return s(element, {
        t("<" .. element .. ">"), i(1), t("</" .. element .. ">")
    })
end

local html_tags = {
    "b",
    "body",
    "dialog",
    "canvas",
    "div",
    "footer",
    "h1",
    "h2",
    "h3",
    "h4",
    "h5",
    "h6",
    "head",
    "header",
    "i",
    "main",
    "mark",
    "menu",
    "nav",
    "noscript",
    "ol",
    "p",
    "script",
    "search",
    "section",
    "small",
    "strong",
    "sumary",
    "table",
    "tr",
    "th",
    "thead",
    "tbody",
    "tfoot",
    "td",
    "template",
    "title",
    "u",
    "ul",
    "li",
}


local M = {
    s("doctype", {
        t("<!DOCTYPE>")
    }),
    s("a", {
        t("<a href=\"\">"), i(1), t("</a>")
    }),
    s("abbr", {
        t("<abbr title=\"\">"), i(1), t("</abbr>")
    }),
    s("br", {
        t("<br>"),
    }),
    s("button", {
        t("<button type=\"button\">"), i(1), t("</button>")
    }),
    s("form", {
        t("<form action=\"\" method=\"get\">"), i(1), t("</form>")
    }),
    s("hr", {
        t("<hr>"),
    }),
    s("html", {
        t("<html lang=\"en\">"), i(1), t("</html>")
    }),
    s("iframe", {
        t("<iframe src=\"\" title=\"\">"), i(1), t("</iframe>")
    }),
    s("img", {
        t("<img src=\"\" alt=\"\">"), i(1), t("</img>")
    }),
    s("input", {
        t("<input type=\"text\" value=\"\">"), i(1), t("</input>")
    }),
    s("label", {
        t("<label for=\"\">"), i(1), t("</label>")
    }),
    s("link", {
        t("<link rel=\"\" href=\"\">"), i(1), t("</link>")
    }),
    s("meta", {
        t("<meta "), i(1), t(">")
    }),
    s("optgroup", {
        t("<optgroup label=\"\">"), i(1), t("</optgroup>")
    }),
    s("option", {
        t("<option value=\"\">"), i(1), t("</option>")
    }),
    s("select", {
        t("<select name=\"\" id=\"\">"), i(1), t("</select>")
    }),
    s("textarea", {
        t("<textarea id=\"\" name=\"\" rows=\"\" cols=\"\">"), i(1), t("</textarea>")
    }),
}

for _, value in ipairs(html_tags) do
    table.insert(M, htmlSnip(value))
end

return M
