local g = vim.g

local Path = require("plenary.path")

local path = Path:new(g.ultisnips_lua)

g.ultisnips_dir = path:parent():parent():joinpath('autoload')['filename']

g.UltiSnipsSnippetDirectories = {g.ultisnips_dir}
