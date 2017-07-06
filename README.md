# CtrlHJKL

Context sensitive code / cursor moving

## Implementation plans

Windows (When exist in current tab)
	<c-h>/<c-l>
		nmode: Move focus to target window (cycling) (working)
		vmode: Move code to target window
		* If no target window && have a tab, move to tab
	<c-j>/<c-k>
		nmode: Move focus to target window (cycling) (working)
		vmode: Move code to target window
		* If no target window, move focus to next/prev buffer

Tabs/Buffers (When no windows in current tab)
	<c-h>/<c-l>
		imode/nmode: Move focus to next/prev tab (cycling) (working)
		vmode: Move code to next/prev tab
		* Switch to logical leftmost/rightmost window maintain vertical position
	<c-j>/<c-k>
		imode/nmode: Move focus to next/prev buffer (cycling) (working)
		vmode: Move code to next/prev buffer
	<c-#>
		imode/nmode: If tabs, move focus to tab# (Later feature: Otherwise move to buffer# in mru)
		vmode: If tabs, move code to tab#, (Later feature: Otherwise move to buffer# in mru)

Philosophy
	vmode: Visual line mode support only

### Potential optomizations

* Highlight focused window better
* Make work slick like vim-move plugin without jitter
	* Maybe just <silent> ?
* Turn this into a .vim plugin and share it
	* Ask for feedback when sharing, if bindings make sense or if others might be better
* Warning when can't do anything?

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
```
