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

vim.api.nvim_create_user_command("FzfTmuxMiseOrMake", function(opts)
    if vim.fn.filereadable("mise.toml") == 1 then
        require("fzf-tmux-runner").mise(opts)
    elseif vim.fn.filereadable("Makefile") == 1 then
        require("fzf-tmux-runner").make(opts)
    else
        vim.notify([[No mise.toml or Makefile found]], vim.log.levels.WARN)
    end
end, { nargs = "?", complete = directional_complete })

vim.api.nvim_create_user_command("FzfTmuxMise", function(opts)
    require("fzf-tmux-runner").mise(opts)
end, { nargs = "?", complete = directional_complete })

vim.api.nvim_create_user_command("FzfTmuxMake", function(opts)
    require("fzf-tmux-runner").make(opts)
end, { nargs = "?", complete = directional_complete })

vim.api.nvim_create_user_command("FzfTmuxPackageJson", function(opts)
    require("fzf-tmux-runner").pkgjson(opts)
end, { nargs = "?", complete = directional_complete })
