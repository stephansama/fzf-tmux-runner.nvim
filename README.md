<p align="center">
  <h1 align="center">fzf-tmux-runner.nvim</h1>
</p>

<p align="center">
  A Neovim plugin that allows you to run Makefile and package.json targets in a tmux split using fzf.
</p>

<div align="center">

![screenshot](https://raw.githubusercontent.com/stephansama/static/refs/heads/main/nvim-plugins/fzf-tmux-runner.gif)

</div>

## Prerequisites

- [`@stephansama/find-makefile-targets`](https://www.npmjs.com/package/@stephansama/find-makefile-targets)
- [`fzf`](https://github.com/junegunn/fzf)
- [`node`](https://nodejs.org/en)
- [`jq`](https://github.com/jqlang/jq)
- [`tmux`](https://github.com/tmux/tmux)
- [`make`](https://www.gnu.org/software/make/) [optional]
- [`mise`](https://mise.jdx.dev/getting-started.html) [optional]

## ⚡️ Features

- Run Makefile targets in a tmux split.
- Run Mise targets in a tmux split.
- Run package.json scripts in a tmux split.
- Customizable split direction (horizontal or vertical).

## 📋 Installation

```lua
require("lazy").setup({
    {
        "stephansama/fzf-tmux-runner.nvim",
        cmd = { "FzfTmuxPackageJson", "FzfTmuxMake" },
        keys = {
            { "<leader>fm", "<cmd>FzfTmuxMake<CR>", { desc = "launch makefile target" } },
            { "<leader>fj", "<cmd>FzfTmuxPackageJson<CR>", { desc = "launch package json script" } },
        },
        config = true,
        ---@module "fzf-tmux-runner"
        ---@type FzfTmuxRunnerOpts
        opts = {
            package_manager = "nr",
            direction = "vertical",
        },
    },
})
```

## ☄ Getting started

1. Install the plugin using your favorite package manager.
2. Make sure you have the prerequisites installed.
3. Run `:FzfTmuxMake` to select a Makefile and a target to run.
4. Run `:FzfTmuxPackageJson` to select a package.json script to run.

## ⚙ Configuration

You can configure the plugin by calling the `setup` function.

<details>
<summary>Click to unfold the full list of options with their default values</summary>

> **Note**: The options are also available in Neovim by calling `:h fzf-tmux-runner.options`

```lua
require("fzf-tmux-runner").setup({
    -- Prints useful logs about what event are triggered, and reasons actions are executed.
    debug = false,
    -- The direction of the tmux split.
    direction = "horizontal",
    -- The package manager to use for running package.json scripts.
    package_manager = "pnpm run",
})
```

</details>

## 🧰 Commands

|   Command   |         Description        |
|-------------|----------------------------|
|  `:FzfTmuxMake`  |     Run a Makefile target in a tmux split.    |
|  `:FzfTmuxPackageJson`  |     Run a package.json script in a tmux split.    |

## ⌨ Contributing

PRs and issues are always welcome. Make sure to provide as much context as possible when opening one.

## 🗞 Wiki

You can find guides and showcase of the plugin on [the Wiki](https://github.com/stephanrandle/fzf-tmux-runner.nvim/wiki)

## 🎭 Motivations

I wanted a simple way to run Makefile and package.json targets from Neovim without having to leave the editor. I also wanted to use fzf to fuzzy find the targets and tmux to run them in a split.
