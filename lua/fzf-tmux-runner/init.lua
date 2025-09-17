local config = require("fzf-tmux-runner.config")

local FzfTmuxRunner = {}

local function get_direction(input_direction)
    return (input_direction or _G.FzfTmuxRunner.config.direction) == "horizontal" and "-h" or "-v"
end

local function run_split_command(input_direction, command)
    local direction = get_direction(input_direction)

    local shell = os.getenv("SHELL") or "sh"

    local formatted_command = not _G.FzfTmuxRunner.config.interactive and command
        or string.format("%s -ic ' %s; printf \\\"Press any key...\\\"; read _ '", shell, command)

    local full_command = string.format('tmux split-window %s "%s"', direction, formatted_command)

    if _G.FzfTmuxRunner.config.debug then
        vim.print("Running:", full_command)
    end

    vim.system({ "sh", "-c", full_command })
end

function FzfTmuxRunner.mise(opts)
    local mise_output = vim.system({
        "sh",
        "-c",
        "mise tasks | fzf --tmux | awk '{print $1}'",
    }):wait()

    local mise_stdout = mise_output.stdout

    if mise_stdout == "" or mise_stdout == nil then
        return vim.print("no mise target selected")
    end

    local task = "mise run " .. string.gsub(mise_stdout, "%s+$", "")

    run_split_command(opts.fargs[1], task)
end

function FzfTmuxRunner.make(opts)
    local makefile_output = vim.system({
        "sh",
        "-c",
        "find . -type f -name 'Makefile' -not -path '*/node_modules/*' | fzf --tmux",
    }):wait()

    local makefile_stdout = makefile_output.stdout

    if makefile_stdout == "" or makefile_stdout == nil then
        return vim.print("no makefile selected")
    end

    local target_output = vim.system({
        "sh",
        "-c",
        "find-makefile-targets " .. makefile_stdout,
    }):wait()

    local target_stdout = target_output.stdout

    if target_stdout == "" then
        return vim.print("no targets found from selected makefile " .. makefile_stdout)
    end

    local selected_target_output = vim.system({
        "sh",
        "-c",
        string.format('echo "%s" | fzf --tmux', target_stdout),
    }):wait()

    local selected_target_stdout = selected_target_output.stdout

    if selected_target_stdout == "" or selected_target_stdout == nil then
        return vim.print("no target selected")
    end

    run_split_command(opts.fargs[1], "make " .. selected_target_stdout)
end

function FzfTmuxRunner.pkgjson(opts)
    local output = vim.system({
        "sh",
        "-c",
        "cat package.json | jq '.scripts' | jq 'keys' | jq '.[]' | tr -d '\"' | fzf --tmux",
    }):wait()

    local stdout = output.stdout

    if stdout == "" then
        return vim.print("no item selected")
    end

    run_split_command(opts.fargs[1], _G.FzfTmuxRunner.config.package_manager .. " " .. stdout)
end

-- setup FzfTmuxRunner options and merge them with user provided ones.
function FzfTmuxRunner.setup(opts)
    _G.FzfTmuxRunner.config = config.setup(opts)
end

_G.FzfTmuxRunner = FzfTmuxRunner

return _G.FzfTmuxRunner
