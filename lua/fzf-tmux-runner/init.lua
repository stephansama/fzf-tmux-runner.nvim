local config = require("fzf-tmux-runner.config")

local FzfTmuxRunner = {}

---@param input_direction string
local function get_direction(input_direction)
    return (input_direction or _G.FzfTmuxRunner.config.direction) == "horizontal" and "-h" or "-v"
end

---@param command string
local function create_interactive_command(command)
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
local function run_tmux_command(input_direction, command)
    local direction = get_direction(input_direction)

    local cmd = create_interactive_command(command)

    local full_command = string.format('tmux split-window %s "%s"', direction, cmd)

    if _G.FzfTmuxRunner.config.debug then
        vim.notify(string.format("Running:", full_command), vim.log.levels.INFO)
    end

    vim.system({ "sh", "-c", full_command })
end

---@param command string
local function run_command(command)
    local output = vim.system({ "sh", "-c", command }):wait()

    vim.print(vim.inspect(output))

    if output.code == 0 and output.stdout ~= "" and output.stdout ~= nil then
        return output.stdout
    end
end

function FzfTmuxRunner.mise(opts)
    local task = run_command("mise tasks | fzf --tmux | awk '{print $1}'")

    if task == nil then
        return vim.notify("no mise target selected", vim.log.levels.INFO)
    end

    run_tmux_command(opts.fargs[1], "mise run " .. string.gsub(task, "%s+$", ""))
end

function FzfTmuxRunner.make(opts)
    local makefile =
        run_command("find . -type f -name 'Makefile' -not -path '*/node_modules/*' | fzf --tmux")

    if makefile == nil then
        return vim.print("no makefile selected")
    end

    local targets = run_command("find-makefile-targets " .. makefile)

    if targets == nil then
        return vim.notify(
            "no targets found from selected makefile " .. makefile,
            vim.log.levels.INFO
        )
    end

    local selected_target = run_command(string.format('echo "%s" | fzf --tmux', targets))

    if selected_target == nil then
        return vim.notify("no target selected", vim.log.levels.INFO)
    end

    run_tmux_command(opts.fargs[1], "make " .. selected_target)
end

function FzfTmuxRunner.pkgjson(opts)
    local script =
        run_command("cat package.json | jq '.scripts | keys | .[]' | tr -d '\"' | fzf --tmux")

    if script == nil then
        return vim.notify("no item selected", vim.log.levels.INFO)
    end

    run_tmux_command(opts.fargs[1], _G.FzfTmuxRunner.config.package_manager .. " " .. script)
end

FzfTmuxRunner.setup = config.setup

_G.FzfTmuxRunner = FzfTmuxRunner

return _G.FzfTmuxRunner
