local config = require("fzf-tmux-runner.config")
local util = require("fzf-tmux-runner.util.command")

local FzfTmuxRunner = {}

function FzfTmuxRunner.mise(opts)
    local task = util.run_command("mise tasks | fzf --tmux | awk '{print $1}'")

    if task == nil then
        return vim.notify("no mise target selected", vim.log.levels.INFO)
    end

    util.run_tmux_command(opts.fargs[1], "mise run " .. task)
end

function FzfTmuxRunner.make(opts)
    local makefile = util.run_command(
        "find . -type f -name 'Makefile' -not -path '*/node_modules/*' | fzf --tmux"
    )

    if makefile == nil then
        return vim.notify("no makefile selected", vim.log.levels.INFO)
    end

    local targets = util.run_command("find-makefile-targets " .. vim.fn.shellescape(makefile))

    if targets == nil then
        return vim.notify(
            "no targets found from selected makefile " .. makefile,
            vim.log.levels.INFO
        )
    end

    local selected_target = util.run_command(string.format('echo "%s" | fzf --tmux', targets))

    if selected_target == nil then
        return vim.notify("no target selected", vim.log.levels.INFO)
    end

    util.run_tmux_command(opts.fargs[1], "make " .. selected_target)
end

function FzfTmuxRunner.pkgjson(opts)
    local script =
        util.run_command("cat package.json | jq '.scripts | keys | .[]' | tr -d '\"' | fzf --tmux")

    if script == nil then
        return vim.notify("no item selected", vim.log.levels.INFO)
    end

    util.run_tmux_command(opts.fargs[1], _G.FzfTmuxRunner.config.package_manager .. " " .. script)
end

FzfTmuxRunner.setup = config.setup

_G.FzfTmuxRunner = FzfTmuxRunner

return _G.FzfTmuxRunner
