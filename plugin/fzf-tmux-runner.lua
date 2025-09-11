-- You can use this loaded variable to enable conditional parts of your plugin.
if _G.FzfTmuxRunnerLoaded then
    return
end

_G.FzfTmuxRunnerLoaded = true

vim.api.nvim_create_user_command("FzfTmuxPackageJson", function()
    require("fzf-tmux-runner").pkgjson()
end, {})
