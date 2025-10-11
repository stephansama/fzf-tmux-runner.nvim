local M = {}

---@param input_direction string
M.get_direction = function(input_direction)
    return (input_direction or _G.FzfTmuxRunner.config.direction) == "horizontal" and "-h" or "-v"
end

---@param command string
M.create_interactive_command = function(command)
    if not _G.FzfTmuxRunner.config.interactive then
        return command
    end

    return string.format(
        "%s -ic ' %s; printf \\\"%s\\\"; read _ '",
        os.getenv("SHELL") or "sh",
        command,
        "Press any key to exit..."
    )
end

---@param input_direction string
---@param command string
M.run_tmux_command = function(input_direction, command)
    local direction = M.get_direction(input_direction)

    local cmd = M.create_interactive_command(command)

    local full_command = string.format('tmux split-window %s "%s"', direction, cmd)

    if _G.FzfTmuxRunner.config.debug then
        vim.notify(string.format("Running: %s", full_command), vim.log.levels.INFO)
    end

    vim.system({ "sh", "-c", full_command })
end

---@param command string
M.run_command = function(command)
    local output = vim.system({ "sh", "-c", command }):wait()

    if output.code == 0 and output.stdout ~= "" and output.stdout ~= nil then
        return string.gsub(output.stdout, "%s+$", "")
    end
end

return M
