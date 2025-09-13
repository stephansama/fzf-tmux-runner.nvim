local log = require("fzf-tmux-runner.util.log")

local FzfTmuxRunner = {}

--- FzfTmuxRunner configuration with its default values.
---
---@class FzfTmuxRunnerOptsFull
---@field debug boolean
---@field direction "horizontal" | "vertical"
---@field package_manager "pnpm run" | "npm run" | "yarn" | "bun" | "deno" | string

---@class (partial) FzfTmuxRunnerOpts : FzfTmuxRunnerOptsFull

---@type FzfTmuxRunnerOptsFull
FzfTmuxRunner.options = {
    -- Prints useful logs about what event are triggered, and reasons actions are executed.
    debug = false,
    direction = "horizontal",
    package_manager = "pnpm run",
}

---@private
local defaults = vim.deepcopy(FzfTmuxRunner.options)

--- Defaults FzfTmuxRunner options by merging user provided options with the default plugin values.
---
---@param options table Module config table. See |FzfTmuxRunner.options|.
---
---@private
function FzfTmuxRunner.defaults(options)
    FzfTmuxRunner.options = vim.deepcopy(vim.tbl_deep_extend("keep", options or {}, defaults or {}))

    -- let your user know that they provided a wrong value, this is reported when your plugin is executed.
    assert(
        type(FzfTmuxRunner.options.debug) == "boolean",
        "`debug` must be a boolean (`true` or `false`)."
    )

    return FzfTmuxRunner.options
end

--- Define your fzf-tmux-runner setup.
---
---@param options table Module config table. See |FzfTmuxRunner.options|.
---
---@usage `require("fzf-tmux-runner").setup()` (add `{}` with your |FzfTmuxRunner.options| table)
function FzfTmuxRunner.setup(options)
    FzfTmuxRunner.options = FzfTmuxRunner.defaults(options or {})

    log.warn_deprecation(FzfTmuxRunner.options)

    return FzfTmuxRunner.options
end

return FzfTmuxRunner
