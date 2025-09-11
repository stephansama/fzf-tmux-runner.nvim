local main = require("fzf-tmux-runner.main")
local config = require("fzf-tmux-runner.config")

local FzfTmuxRunner = {}

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
