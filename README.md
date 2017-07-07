# CtrlHJKL v0.1.2

Context sensitive workspace navigation

## Guiding principals

* `<c-h>` / `<c-j>` / `<c-k>` / `<c-l>` moves cursor around in windows/tabs/buffers
	* Workspace context sensitive: Fall through: Windows > Tabs > Buffers
	* Mode context sensitive
		* Normal mode moves cursor
		* Visual mode moves selected (line of) text
* `<c-x>` in normal mode closes where cursor is: Window > Tab > Buffer

## Configuration

### Mapping your own keys

```
let g:ctrlhjkl_suppress_keymaps = 1

nmap <s-j> <Plug>CtrlHJKLGoJn
nmap <s-k> <Plug>CtrlHJKLGoKn
nmap <s-h> <Plug>CtrlHJKLGoHn
nmap <s-l> <Plug>CtrlHJKLGoLn

nmap <s-l> <Plug>CtrlHJKLClose

xmap <s-j> <Plug>CtrlHJKLMoveJ
xmap <s-k> <Plug>CtrlHJKLMoveK
xmap <s-h> <Plug>CtrlHJKLMoveH
xmap <s-l> <Plug>CtrlHJKLMoveL
```
### Disable buffer cycling

```
let g:ctrlhjkl_suppress_buffercycling = 1
```

[Why cycle when you can fly?](https://i.stack.imgur.com/9CCOq.png)

### Disable buffer closing

```
let g:ctrlhjkl_suppress_bufferclosing = 1
```

### Issues & potential optomizations

* Think about making <c-x> kill buffers in window/tab context?
	* Window: Close window & kill buffer if this is only place it's open
	* Tab: Close tab & kill buffer if this is only place it's open
* Rename from CtrlHJKL?
	* We now have CtrlX also for closing
* Create a /doc/ctrlp.txt
	* And update ctags?
* Create real screencast .gif and place in README
* Promote this plugin looking for beta testers
	* Reddit again?
	* http://www.vim.org/scripts/?
* Release to places as needed
	* vimawesome?
	* http://www.vim.org/scripts/?
	* ...?

## Related .vimrc plugins & settings (Optional)

```
" 'qpkorr/vim-bufkill'
let g:BufKillCreateMappings = 0 " My own keymappings
:nnoremap <C-x> :BD<cr>

" matze/vim-move to work as <s-j> and <s-k>
" Works with shift '>'
let g:move_key_modifier = 'S'
```
## Inspirations

* [Vim Tab Madness. Buffers vs Tabs](http://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/)
* [Ctrl-P](https://github.com/kien/ctrlp.vim)
* [Vim-Move](https://github.com/matze/vim-move)
* [Why do Vim experts prefer buffers over tabs? - Stack Overflow](https://stackoverflow.com/questions/26708822/why-do-vim-experts-prefer-buffers-over-tabs)
