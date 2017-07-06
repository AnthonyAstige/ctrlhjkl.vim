"" Utils
" Returns true if we have tabs
function! s:haveTabs()
	return tabpagenr('$') > 1
endfunction

" Returns true if current tab has windows
function! s:haveWindows()
	return len(gettabinfo(tabpagenr())[0].windows) > 1
endfunction

function! s:ResetCursor()
	normal! gv=gv^
endfunction

"" Movement functions
function! s:goJ()
	if s:haveWindows()
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

function! s:goK()
	if s:haveWindows()
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

function! s:goH()
	if s:haveWindows()
		let winnrBefore = winnr()
		wincmd h
		if winnrBefore == winnr()
			if s:haveTabs()
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

function! s:goL()
	if s:haveWindows()
		let winnrBefore = winnr()
		wincmd l
		if winnrBefore == winnr()
			if s:haveTabs()
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

" Code movers
function! s:moveJ()
	call s:goJ()
	normal! P`[V`]
endfunction

function! s:moveK()
	call s:goK()
	normal! P`[V`]
endfunction

function! s:moveH()
	call s:goH()
	normal! P`[V`]
endfunction

function! s:moveL()
	call s:goL()
	normal! P`[V`]
endfunction

" Commands
command CtrlHJKLGoJ :call s:goJ()
command CtrlHJKLGoK :call s:goK()
command CtrlHJKLGoH :call s:goH()
command CtrlHJKLGoL :call s:goL()

command CtrlHJKLMoveJ :call s:moveJ()
command CtrlHJKLMoveK :call s:moveK()
command CtrlHJKLMoveH :call s:moveH()
command CtrlHJKLMoveL :call s:moveL()

" Mappings
nnoremap <silent> <c-j> :CtrlHJKLGoJ<cr>
nnoremap <silent> <c-k> :CtrlHJKLGoK<cr>
nnoremap <silent> <c-h> :CtrlHJKLGoH<cr>
nnoremap <silent> <c-l> :CtrlHJKLGoL<cr>

inoremap <silent> <c-j> <esc>:CtrlHJKLGoJ<cr>i
inoremap <silent> <c-k> <esc>:CtrlHJKLGoK<cr>i
inoremap <silent> <c-h> <esc>:CtrlHJKLGoH<cr>i
inoremap <silent> <c-l> <esc>:CtrlHJKLGoL<cr>i

vnoremap <silent> <c-j> x:CtrlHJKLMoveJ<cr>
vnoremap <silent> <c-k> x:CtrlHJKLMoveK<cr>
vnoremap <silent> <c-h> x:CtrlHJKLMoveH<cr>
vnoremap <silent> <c-l> x:CtrlHJKLMoveL<cr>
