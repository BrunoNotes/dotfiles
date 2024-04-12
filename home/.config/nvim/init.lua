-- nvim initial config
require("sets")
require("utils")

-- nvim default keybindings changes
require("keybindings").load()

-- plugins
require("lazy_nvim")
require("netrw")

-- themes
require("themes")

-- autocommands
require("autocommands")
