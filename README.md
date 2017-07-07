# CtrlHJKL v0.1.0

Context sensitive workspace navigation

## Guiding principals

* `<c-h>` / `<c-j>` / `<c-k>` / `<c-l>` moves cursor around in windows/tabs/buffers
* Workspace context sensitive: Fall through: Windows > Tabs > Buffers
* Mode context sensitive
	* Normal mode moves cursor
	* Visual mode moves selected text remaining in visual mode
* Visual mode is line based only

### Issues & potential optomizations

* Document how users can make use of <Plug> settings, hopefully just 4 maps
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

" ctrlpvim/ctrlp.vim
" Use ctrlp in insert mode
" * TODO: Make this put back in insert mode
inoremap <silent> <c-p> <esc>:CtrlP<cr>
```
# Inspirations

* [Vim Tab Madness. Buffers vs Tabs](http://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/)
* [Ctrl-P](https://github.com/kien/ctrlp.vim)
* [Vim-Move](https://github.com/matze/vim-move)
* [Why do Vim experts prefer buffers over tabs? - Stack Overflow](https://stackoverflow.com/questions/26708822/why-do-vim-experts-prefer-buffers-over-tabs)
