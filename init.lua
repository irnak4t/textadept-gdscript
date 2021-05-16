local M = {}

local modules = {'run'}
for _, name in ipairs(modules) do M[name] = require('gdscript.' .. name) end

textadept.file_types.extensions.gd = 'gdscript'
textadept.editing.comment_string.gdscript = '#'

events.connect(events.LEXER_LOADED, function(name)
  if name == 'gdscript' then
    textadept.run.run_commands.gdscript = M.run.build_run_command()
  end
end)

return M