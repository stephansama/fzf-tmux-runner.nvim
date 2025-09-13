<p align="center">
  <h1 align="center">fzf-tmux-runner.nvim</h2>
</p>

<p align="center">
    > A catch phrase that describes your plugin.
</p>

<div align="center">
    > Drag your video (<10MB) here to host it for free on GitHub.
</div>

<div align="center">

> Videos don't work on GitHub mobile, so a GIF alternative can help users.

_[GIF version of the showcase video for mobile users](SHOWCASE_GIF_LINK)_

</div>

## Prerequisites

- [`@stephansama/find-makefile-runner`](https://www.npmjs.com/package/@stephansama/find-makefile-targets)
- [`fzf`](https://github.com/junegunn/fzf)
- [`jq`](https://github.com/jqlang/jq)

## ⚡️ Features

> Write short sentences describing your plugin features

- FEATURE 1
- FEATURE ..
- FEATURE N

## 📋 Installation

<div align="center">
<table>
<thead>
<tr>
<th>Package manager</th>
<th>Snippet</th>
</tr>
</thead>
<tbody>
<tr>
<td>

[wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)

</td>
<td>

```lua
-- stable version
use {"fzf-tmux-runner.nvim", tag = "*" }
-- dev version
use {"fzf-tmux-runner.nvim"}
```

</td>
</tr>
<tr>
<td>

[junegunn/vim-plug](https://github.com/junegunn/vim-plug)

</td>
<td>

```lua
-- stable version
Plug "fzf-tmux-runner.nvim", { "tag": "*" }
-- dev version
Plug "fzf-tmux-runner.nvim"
```

</td>
</tr>
<tr>
<td>

[folke/lazy.nvim](https://github.com/folke/lazy.nvim)

</td>
<td>

```lua
-- stable version
require("lazy").setup({{"fzf-tmux-runner.nvim", version = "*"}})
-- dev version
require("lazy").setup({"fzf-tmux-runner.nvim"})
```

</td>
</tr>
</tbody>
</table>
</div>

## ☄ Getting started

> Describe how to use the plugin the simplest way

## ⚙ Configuration

> The configuration list sometimes become cumbersome, making it folded by default reduce the noise of the README file.

<details>
<summary>Click to unfold the full list of options with their default values</summary>

> **Note**: The options are also available in Neovim by calling `:h fzf-tmux-runner.options`

```lua
require("fzf-tmux-runner").setup({
    -- you can copy the full list from lua/fzf-tmux-runner/config.lua
})
```

</details>

## 🧰 Commands

|   Command   |         Description        |
|-------------|----------------------------|
|  `:Toggle`  |     Enables the plugin.    |

## ⌨ Contributing

PRs and issues are always welcome. Make sure to provide as much context as possible when opening one.

## 🗞 Wiki

You can find guides and showcase of the plugin on [the Wiki](https://github.com/stephanrandle/fzf-tmux-runner.nvim/wiki)

## 🎭 Motivations

> If alternatives of your plugin exist, you can provide some pros/cons of using yours over the others.
