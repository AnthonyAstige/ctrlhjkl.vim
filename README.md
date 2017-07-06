# CtrlHJKL

Context sensitive code / cursor moving

## Guiding principals

* `<c-h>` / `<c-j>` / `<c-k>` / `<c-l>` moves around in windows/tabs/buffers
* Workspace context sensitive: Fall through: Windows > Tabs > Buffers
* Mode context sensitive
		* nmode moves cursor
	* imode moves cursor remaining in insert mode
	* vmode moves selected text remaining in insert mode
* vmode: Visual line mode support only

## Implementation plans

Windows (When exist in current tab)

* `<c-h>` / `<c-l>`
	* nmode: Move focus to target window (cycling) (working)
	* vmode: Move code to target window (working)
	* If no target window && have a tab, move to tab
* `<c-j>` / `<c-k>`
	* nmode: Move focus to target window (cycling) (working)
	* vmode: Move code to target window (working)
	* If no target window, move focus to next/prev buffer

Tabs/Buffers (When no windows in current tab)

* `<c-h>` / `<c-l>`
	* imode/nmode: Move focus to next/prev tab (cycling) (working)
	* vmode: Move code to next/prev tab (working)
	*  Switch to logical leftmost/rightmost window maintain vertical position
	* If no window/tab to left or right, cycle buffers
* `<c-j>` / `<c-k>`
	* imode/nmode: Move focus to next/prev buffer (cycling) (working)
	* vmode: Move code to next/prev buffer (working)

### Issues & potential optomizations

* Stay in insert (or visual) modes when moving around
	* Hacked right now exit mode and re-enter
	* Loses cursor horizontal position when going back to insert mode
	* Causes jitter
* Smart detection so don't need to bind <esc>...i when in insert mode
	* Will reduce command namespace too?
* Warn when can't do anything
* Abstract Move functions as just wrapper of Go functions, functional programming in vimscript?
* Make work with prefix counts like 10<c-j> moves 10 windows/buffers down
* Highlight focused window better (Another plugin?)

## Related plans / plugins

### Plans

Local (working)
	h/j/k/l
Move focus
	<s-j>/<s-j>
	nmode: Move line (vim-move)
	vmode: Move line (vim-move)

```
<c-g> BufferGator
	Not open: Open BufferGator (working)
	Already open: Close BufferGator
<c-x> (Fallthrough)
	* Window: Close window & kill buffer if this is only place it's open
	* Tab: Close tab & kill buffer if this is only place it's open
	* Buffer: Kill buffer (working but always doing this)
```

### .vimrc settings

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
