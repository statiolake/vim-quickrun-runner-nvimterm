# vim-quickrun-nvimterm

Non-official runner for [vim-quickrun](https://github.com/thinca/vim-quickrun) using Neovim's terminal.

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

- `runner/terminal/opener` (default: `new`)  
    An Ex command to open a terminal window.  For example, specify `vnew` to vertically split the editor.
- `runner/terminal/into` (default: `0`)  
    Moves cursor to the terminal window if this isn't 0.

