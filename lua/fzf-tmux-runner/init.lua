local main = require("fzf-tmux-runner.main")
local config = require("fzf-tmux-runner.config")

local FzfTmuxRunner = {}

function FzfTmuxRunner.make()
    local makefile_output = vim.system({
        "sh",
        "-c",
        "find . -type f -name 'Makefile' -not -path '*/node_modules/*' | fzf --tmux",
    }):wait()

    local makefile_stdout = makefile_output.stdout

    if makefile_stdout == "" then
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
        'echo "' .. target_stdout .. '" | fzf --tmux',
    }):wait()

    local selected_target_stdout = selected_target_output.stdout

    if selected_target_stdout == "" then
        return vim.print("no target selected")
    end

    vim.system({
        "sh",
        "-c",
        string.format("tmux split-window -v '%s'", "make " .. selected_target_stdout),
    })
end

function FzfTmuxRunner.pkgjson()
    local output = vim.system({
        "sh",
        "-c",
        "cat package.json | jq '.scripts' | jq 'keys' | jq '.[]' | tr -d '\"' | fzf --tmux",
    }):wait()

    local stdout = output.stdout

    if stdout == "" then
        return vim.print("no item selected")
    end

    vim.system({
        "sh",
        "-c",
        string.format("tmux split-window -v '%s'", "pnpm run " .. stdout),
    })
end

--- Toggle the plugin by calling the `enable`/`disable` methods respectively.
function FzfTmuxRunner.toggle()
    if _G.FzfTmuxRunner.config == nil then
        _G.FzfTmuxRunner.config = config.options
    end

    main.toggle("public_api_toggle")
end

--- Initializes the plugin, sets event listeners and internal state.
function FzfTmuxRunner.enable(scope)
    if _G.FzfTmuxRunner.config == nil then
        _G.FzfTmuxRunner.config = config.options
    end

    main.toggle(scope or "public_api_enable")
end

--- Disables the plugin, clear highlight groups and autocmds, closes side buffers and resets the internal state.
function FzfTmuxRunner.disable()
    main.toggle("public_api_disable")
end

-- setup FzfTmuxRunner options and merge them with user provided ones.
function FzfTmuxRunner.setup(opts)
    _G.FzfTmuxRunner.config = config.setup(opts)
end

_G.FzfTmuxRunner = FzfTmuxRunner

return _G.FzfTmuxRunner
