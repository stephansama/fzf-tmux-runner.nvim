-- You can use this loaded variable to enable conditional parts of your plugin.
if _G.FzfTmuxRunnerLoaded then
    return
end

_G.FzfTmuxRunnerLoaded = true

local function directional_complete()
    return {
        "vertical",
        "horizontal",
    }
end

vim.api.nvim_create_user_command("FzfTmuxMise", function(opts)
    require("fzf-tmux-runner").mise(opts)
end, { nargs = "?", complete = directional_complete })

vim.api.nvim_create_user_command("FzfTmuxMake", function(opts)
    require("fzf-tmux-runner").make(opts)
end, { nargs = "?", complete = directional_complete })

vim.api.nvim_create_user_command("FzfTmuxPackageJson", function(opts)
    require("fzf-tmux-runner").pkgjson(opts)
end, { nargs = "?", complete = directional_complete })
