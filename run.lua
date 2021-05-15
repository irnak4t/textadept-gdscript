local M = {}

M.command = 'godot'
M.command_options = {'--upwards', '--always-on-top'}

function M.build_run_command() return M.command .. ' ' .. table.concat(M.command_options, ' ') end

return M