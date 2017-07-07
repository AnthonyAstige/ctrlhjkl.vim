"" Utils
" Returns true if we have tabs
function! s:haveTabs()
	return tabpagenr('$') > 1
endfunction

" Returns true if current tab has windows
function! s:haveWindows()
	return len(gettabinfo(tabpagenr())[0].windows) > 1
endfunction

" TODO: Use this? Taken from vim-move
"function! s:ResetCursor()
"	normal! gv=gv^
"endfunction

" Leftmost window in next tab
function! s:tabnext()
	tabnext
	1000wincmd h
endfunction

" Right window in prev tab
function! s:tabprev()
	tabprev
	1000wincmd l
endfunction

" Buffer movement
" * TODO: Add back in MRU support, buffergator MRU was window based and
" problematic
function! s:bnext()
	:bnext
endfunction
function! s:bprev()
	:bprev
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
				call s:bprev()
			endif
		endif
	else
		call s:bprev()
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
				call s:bnext()
			endif
		endif
	else
		call s:bnext()
	endif
endfunction

function! s:goH()
	if s:haveWindows()
		let winnrBefore = winnr()
		wincmd h
		if winnrBefore == winnr()
			if s:haveTabs()
				call s:tabprev()
			else
				" Cycle to rightmost window
				1000wincmd l

				if winnrBefore == winnr()
					call s:bnext()
				endif
			endif
		endif
	else
		if s:haveTabs()
			call s:tabprev()
		else
			call s:bnext()
		endif
	endif
endfunction

function! s:goL()
	if s:haveWindows()
		let winnrBefore = winnr()
		wincmd l
		if winnrBefore == winnr()
			if s:haveTabs()
				call s:tabnext()
			else
				" Cycle to leftmost window
				1000wincmd h

				if winnrBefore == winnr()
					call s:bprev()
				endif
			endif
		endif
	else
		if s:haveTabs()
			call s:tabnext()
		else
			call s:bprev()
		endif
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

" Plug templating mappings
nnoremap <silent> <silent> <Plug>CtrlHJKLGoJn :call <SID>goJ()<cr>
nnoremap <unique> <silent> <Plug>CtrlHJKLGoKn :call <SID>goK()<cr>
nnoremap <unique> <silent> <Plug>CtrlHJKLGoHn :call <SID>goH()<cr>
nnoremap <unique> <silent> <Plug>CtrlHJKLGoLn :call <SID>goL()<cr>

inoremap <unique> <silent> <Plug>CtrlHJKLGoJi <esc>:call <SID>goJ()<cr>i
inoremap <unique> <silent> <Plug>CtrlHJKLGoKi <esc>:call <SID>goK()<cr>i
inoremap <unique> <silent> <Plug>CtrlHJKLGoHi <esc>:call <SID>goH()<cr>i
inoremap <unique> <silent> <Plug>CtrlHJKLGoLi <esc>:call <SID>goL()<cr>i

xnoremap <unique> <silent> <Plug>CtrlHJKLMoveJ x:call <SID>moveJ()<cr>
xnoremap <unique> <silent> <Plug>CtrlHJKLMoveK x:call <SID>moveK()<cr>
xnoremap <unique> <silent> <Plug>CtrlHJKLMoveH x:call <SID>moveH()<cr>
xnoremap <unique> <silent> <Plug>CtrlHJKLMoveL x:call <SID>moveL()<cr>

" Actually map unless told not to
if !get(g:, 'ctrlhjkl_suppress_keymaps', 0)
	nmap <c-j> <Plug>CtrlHJKLGoJn
	nmap <c-k> <Plug>CtrlHJKLGoKn
	nmap <c-h> <Plug>CtrlHJKLGoHn
	nmap <c-l> <Plug>CtrlHJKLGoLn

	imap <c-j> <Plug>CtrlHJKLGoJi
	imap <c-k> <Plug>CtrlHJKLGoKi
	imap <c-h> <Plug>CtrlHJKLGoHi
	imap <c-l> <Plug>CtrlHJKLGoLi

	xmap <c-j> <Plug>CtrlHJKLMoveJ
	xmap <c-k> <Plug>CtrlHJKLMoveK
	xmap <c-h> <Plug>CtrlHJKLMoveH
	xmap <c-l> <Plug>CtrlHJKLMoveL
endif
