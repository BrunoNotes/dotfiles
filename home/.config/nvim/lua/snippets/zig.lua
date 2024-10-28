local luasnip = require("luasnip")
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node


local M = {
    s("print", {
        t("std.debug.print(\""), i(1), t("\", .{});")
    }),
    s("loginfo", {
        t("std.log.info(\""), i(1), t("\", .{});")
    }),
    s("logerr", {
        t("std.log.err(\""), i(1), t("\", .{});")
    }),
    s("logwarn", {
        t("std.log.warn(\""), i(1), t("\", .{});")
    }),
    s("logdebug", {
        t("std.log.debug(\""), i(1), t("\", .{});")
    }),
}

return M
