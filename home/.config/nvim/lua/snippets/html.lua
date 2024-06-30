local luasnip = require("luasnip")
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node

local function html_snip(element)
    return s(element, {
        t("<" .. element .. ">"), i(1), t("</" .. element .. ">")
    })
end

local M = {
    -- s("div", {
    --     t({ "<div>", "    " }),
    --     i(1),
    --     t({"", "</div>" })
    -- }),
    s("doctype", {
        t("<!DOCTYPE>")
    }),
    s("a", {
        t("<a href=\"\">"), i(1), t("</a>")
    }),
    s("abbr", {
        t("<abbr title=\"\">"), i(1), t("</abbr>")
    }),
    html_snip("b"),
    html_snip("body"),
    s("br", {
        t("<br>"),
    }),
    s("button", {
        t("<button type=\"button\">"), i(1), t("</button>")
    }),
    html_snip("dialog"),
    html_snip("div"),
    html_snip("footer"),
    s("form", {
        t("<form action=\"\" method=\"get\">"), i(1), t("</form>")
    }),
    html_snip("h1"),
    html_snip("h2"),
    html_snip("h3"),
    html_snip("h4"),
    html_snip("h5"),
    html_snip("h6"),
    html_snip("head"),
    html_snip("header"),
    s("hr", {
        t("<hr>"),
    }),
    s("html", {
        t("<html lang=\"en\">"), i(1), t("</html>")
    }),
    html_snip("i"),
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
    html_snip("main"),
    html_snip("mark"),
    html_snip("menu"),
    s("meta", {
        t("<meta "), i(1), t(">")
    }),
    html_snip("nav"),
    html_snip("noscript"),
    html_snip("ol"),
    s("optgroup", {
        t("<optgroup label=\"\">"), i(1), t("</optgroup>")
    }),
    s("option", {
        t("<option value=\"\">"), i(1), t("</option>")
    }),
    html_snip("p"),
    html_snip("script"),
    html_snip("search"),
    html_snip("section"),
    s("select", {
        t("<select name=\"\" id=\"\">"), i(1), t("</select>")
    }),
    html_snip("small"),
    html_snip("strong"),
    html_snip("sumary"),
    html_snip("table"),
    html_snip("tr"),
    html_snip("th"),
    html_snip("thead"),
    html_snip("tbody"),
    html_snip("tfoot"),
    html_snip("td"),
    html_snip("template"),
    s("textarea", {
        t("<textarea id=\"\" name=\"\" rows=\"\" cols=\"\">"), i(1), t("</textarea>")
    }),
    html_snip("title"),
    html_snip("u"),
    html_snip("ul"),
    html_snip("li"),
}

return M
