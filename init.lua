local M = {}

local modules = {'run'}
for _, name in ipairs(modules) do M[name] = require('gdscript.' .. name) end

textadept.file_types.extensions.gd = 'gdscript'
textadept.editing.comment_string = '#'
textadept.run.run_commands.gdscript = M.run.build_run_command()

return M