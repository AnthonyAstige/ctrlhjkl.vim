"" CtrlHJKL
" Returns true if we have tabs
function! HaveTabs()
	return tabpagenr('$') > 1
endfunction

" Returns true if current tab has windows
function! HaveWindows()
	return len(gettabinfo(tabpagenr())[0].windows) > 1
endfunction

function! CtrlMoveFocusDown()
	if HaveWindows()
		let winnrBefore = winnr()
		wincmd j
		if winnrBefore == winnr()
			" Go to top window
			1000wincmd k
			" Only one window, cycle the buffer
			if winnrBefore == winnr()
				:BuffergatorMruCyclePrev
			endif
		endif
	else
		:BuffergatorMruCyclePrev
	endif
endfunction
nnoremap <silent> <c-j> :call CtrlMoveFocusDown()<cr>
inoremap <silent> <c-j> <esc>:call CtrlMoveFocusDown()<cr>i

function! CtrlMoveFocusUp()
	if HaveWindows()
		let winnrBefore = winnr()
		wincmd k
		if winnrBefore == winnr()
			" Go to bottom window
			1000wincmd j
			" Only one window, cycle the buffer
			if winnrBefore == winnr()
				:BuffergatorMruCycleNext
			endif
		endif
	else
		:BuffergatorMruCycleNext
	endif
endfunction
nnoremap <silent> <c-k> :call CtrlMoveFocusUp()<cr>
inoremap <silent> <c-k> <esc>:call CtrlMoveFocusUp()<cr>i


function! CtrlMoveFocusLeft()
	if HaveWindows()
		let winnrBefore = winnr()
		wincmd h
		if winnrBefore == winnr()
			if HaveTabs()
				tabprev
			else
				" Cycle to rightmost window
				1000wincmd l
			endif
		endif
	else
		tabprev
	endif
endfunction
nnoremap <silent> <c-h> :call CtrlMoveFocusLeft()<cr>
inoremap <silent> <c-h> <esc>:call CtrlMoveFocusLeft()<cr>i

function! CtrlMoveFocusRight()
	if HaveWindows()
		let winnrBefore = winnr()
		wincmd l
		if winnrBefore == winnr()
			if HaveTabs()
				tabnext
			else
				" Cycle to leftmost window
				1000wincmd h
			endif
		endif
	else
		tabnext
	endif
endfunction
nnoremap <silent> <c-l> :call CtrlMoveFocusRight()<cr>
inoremap <silent> <c-l> <esc>:call CtrlMoveFocusRight()<cr>i

function! CtrlMoveCodeLeft()
	echom "CtrlMoveCodeLeft"
	"vmap J x:BuffergatorMruCyclePrev<cr>P`[V`]
	"vmap K x:BuffergatorMruCycleNext<cr>P`[V`]
endfunction
xnoremap <silent> <c-h> :call CtrlMoveCodeLeft()<cr>
