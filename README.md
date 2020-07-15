# vim-quickrun-nvimterm

Non-official runner for [vim-quickrun](https://github.com/thinca/vim-quickrun) using Neovim's terminal.

## Features

- Reuse terminal window when the window was already created by previous run of the quickrun.
- Auto-detect window columns to determine splitting direction (horizontal / vertical).

## Usage

```vim
let g:quickrun_config = {}
let g:quickrun_config._ = {}
if has('nvim')
    let g:quickrun_config._['runner'] = 'nvimterm'
endif
```

## Options

Since this is mostly created by copy-and-paste the bundled runner for vim's terminal, you can use this in the same way with that.

- `runner/nvimterm/opener` (default: `auto`)  
    An Ex command to open a terminal window.  For example, specify `vnew` to vertically split the editor. If you want to automatically select the command according to the window width, set `auto` to this option.
- `runner/nvimterm/vsplit_width` (default: `80`)  
    The width to use vertical split. If `opener` is set to `auto` and the column width is more than `vsplit_width`, `vnew` command will be used. Otherwise, `new` command is used.
- `runner/nvimterm/into` (default: `0`)  
    Moves cursor to the terminal window if this isn't 0.

