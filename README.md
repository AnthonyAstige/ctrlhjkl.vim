# CtrlHJKL v0.0.0

Context sensitive workspace navigation

## Guiding principals

* `<c-h>` / `<c-j>` / `<c-k>` / `<c-l>` moves cursor around in windows/tabs/buffers
* Workspace context sensitive: Fall through: Windows > Tabs > Buffers
* Mode context sensitive
	* Normal mode moves cursor
	* Insert mode moves cursor remaining in insert mode
	* Visual mode moves selected text remaining in visual mode
* Visual mode is line based only

### Issues & potential optomizations

* Make work without BufferGator plugin (Fallback to :bnext / :bprev)
* Stay in insert (or visual) modes when moving around
	* Hacked right now exit mode and re-enter
	* Loses cursor horizontal position when going back to insert mode
	* Causes jitter
* When working in visual mode (not visual line mode) make select entire line
	* Currently gives odd behavior
* Smart detection so don't need to bind `<esc>...i` when in insert mode
	* Will reduce command namespace too?
* Warn when can't do anything
* Abstract Move functions as just wrapper of Go functions, functional programming in vimscript?
* Make work with prefix counts like `10<c-j>` moves 10 windows/buffers down
* Highlight focused window better (Another plugin?)

## Related .vimrc plugins & settings

```
" jeetsukumaran/vim-buffergator
let g:buffergator_suppress_keymaps = 1 " My own keymappings
let g:buffergator_sort_regime = 'mru' "Sort by Most Recently Used
let g:buffergator_mru_cycle_loop = 1 " Loop MRU
let g:buffergator_autoupdate = 1 " Update as we change buffers (for use with MoveHJKL)
nmap <silent> <c-g> :BuffergatorOpen<cr>

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
