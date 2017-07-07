# CtrlHJKL v0.1.1

Context sensitive workspace navigation

## Guiding principals

* `<c-h>` / `<c-j>` / `<c-k>` / `<c-l>` moves cursor around in windows/tabs/buffers
* Workspace context sensitive: Fall through: Windows > Tabs > Buffers
* Mode context sensitive
	* Normal mode moves cursor
	* Visual mode moves selected (line of) text

## Mapping your own keys

```
let g:ctrlhjkl_suppress_keymaps
nmap <s-j> <Plug>CtrlHJKLGoJn
nmap <s-k> <Plug>CtrlHJKLGoKn
nmap <s-h> <Plug>CtrlHJKLGoHn
nmap <s-l> <Plug>CtrlHJKLGoLn

xmap <s-j> <Plug>CtrlHJKLMoveJ
xmap <s-k> <Plug>CtrlHJKLMoveK
xmap <s-h> <Plug>CtrlHJKLMoveH
xmap <s-l> <Plug>CtrlHJKLMoveL
```


### Issues & potential optomizations

* Create a /doc/ctrlp.txt
	* And update ctags?
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
