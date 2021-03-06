"" Utils
" Check for tabs in vim / windows in tab
function! s:haveTabs()
	return tabpagenr('$') > 1
endfunction
function! s:haveWindows()
	return len(gettabinfo(tabpagenr())[0].windows) > 1
endfunction

" Leftmost & rightmove window in target tab
function! s:tabnext()
	tabnext
	1000wincmd h
endfunction
function! s:tabprev()
	tabprev
	1000wincmd l
endfunction

" Buffer movement
function! s:bnext()
	if !get(g:, 'ctrlhjkl_suppress_buffercycling', 0)
		:bnext
	endif
endfunction
function! s:bprev()
	if !get(g:, 'ctrlhjkl_suppress_buffercycling', 0)
		:bprev
	endif
endfunction

" Cut n paste without overwritting unnamed register
" * Only function in v mode passing
let s:originalValue = ''
function! s:cut(mode)
	if a:mode ==# 'v'
		let s:originalValue = @@
		normal! gv
		if "V" != mode()
			normal! V
		endif
		normal! d
	endif
endfunction
function! s:paste(mode)
	if a:mode ==# 'v'
		normal! P`[V`]
		let @@ = s:originalValue
	endif
endfunction

"" Movement functions
function! s:goJ(mode) range
	call s:cut(a:mode)
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
	call s:paste(a:mode)
endfunction

function! s:goK(mode) range
	call s:cut(a:mode)
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
	call s:paste(a:mode)
endfunction

function! s:goH(mode) range
	call s:cut(a:mode)
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
	call s:paste(a:mode)
endfunction

function! s:goL(mode) range
	call s:cut(a:mode)
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
	call s:paste(a:mode)
endfunction

function! s:close()
	if s:haveWindows() || s:haveTabs()
		:close
	elseif !get(g:, 'ctrlhjkl_suppress_bufferclosing', 0)
		:bdelete!
	endif
endfunction

" Plug templating mappings
nnoremap <silent> <Plug>CtrlHJKLGoJn :call <SID>goJ('n')<cr>
nnoremap <silent> <Plug>CtrlHJKLGoKn :call <SID>goK('n')<cr>
nnoremap <silent> <Plug>CtrlHJKLGoHn :call <SID>goH('n')<cr>
nnoremap <silent> <Plug>CtrlHJKLGoLn :call <SID>goL('n')<cr>

xnoremap <silent> <Plug>CtrlHJKLMoveJ :call <SID>goJ('v')<cr>
xnoremap <silent> <Plug>CtrlHJKLMoveK :call <SID>goK('v')<cr>
xnoremap <silent> <Plug>CtrlHJKLMoveH :call <SID>goH('v')<cr>
xnoremap <silent> <Plug>CtrlHJKLMoveL :call <SID>goL('v')<cr>

nnoremap <silent> <Plug>CtrlHJKLClose :call <SID>close()<cr>

" Actually map unless told not to
if !get(g:, 'ctrlhjkl_suppress_keymaps', 0)
	nmap <c-j> <Plug>CtrlHJKLGoJn
	nmap <c-k> <Plug>CtrlHJKLGoKn
	nmap <c-h> <Plug>CtrlHJKLGoHn
	nmap <c-l> <Plug>CtrlHJKLGoLn
	nmap <c-x> <Plug>CtrlHJKLClose

    " inoremap <c-h> <esc>:call <SID>goH('n')<cr>
    " inoremap <c-j> <esc>:call <SID>goJ('n')<cr>
    " inoremap <c-k> <esc>:call <SID>goK('n')<cr>
    " inoremap <c-l> <esc>:call <SID>goL('n')<cr>
    " inoremap <c-x> <esc>:call <SID>close()<cr>

	if has('nvim')
        :tnoremap <c-h> <c-\><c-n>:call <SID>goH('n')<cr>
        :tnoremap <c-l> <c-\><c-n>:call <SID>goL('n')<cr>
        :tnoremap <c-x> <c-\><c-n>:call <SID>close()<cr>

        " TODO: Find a real solution to fzf conflict documented below
        " <c-j> & <c-k> conflict with fzf.vim (which uses <c-j> & <c-k> in terminal)
        " Copy these 2 lines into your vimrc if you don't use fzf
        " :tnoremap <c-j> <c-\><c-n>:call <SID>goJ('n')<cr>
        " :tnoremap <c-k> <c-\><c-n>:call <SID>goK('n')<cr>
        "
        "
        " Here's a hack workaround Anthony is using for now to work with fzf
        "    " Open inserting terminal from any mode into, +non-fzf mapping fixes
        "    func MapTermStuff()
        "        " CtrlHJKL J/K
        "        :tnoremap <buffer> <c-k> <c-\><c-n>:execute "normal \<Plug>CtrlHJKLGoKn"<cr>
        "        :tnoremap <buffer> <c-j> <c-\><c-n>:execute "normal \<Plug>CtrlHJKLGoKn"<cr>
        "
        "        " <esc> means <esc> (fzf does it's own magic and don't want to rebind)
        "        " * https://neovim.io/doc/user/nvim_terminal_emulator.html
        "        :tnoremap <buffer> <Esc> <C-\><C-n>
        "    endfunc
        "    :nnoremap <c-w><c-t> :term<cr>:call MapTermStuff()<cr>i
        "    :vnoremap <c-w><c-t> <esc>:term<cr>:call MapTermStuff()<cr>i
        "    :inoremap <c-w><c-t> <esc>:term<cr>:call MapTermStuff()<cr>i
	endif

	xmap <c-j> <Plug>CtrlHJKLMoveJ
	xmap <c-k> <Plug>CtrlHJKLMoveK
	xmap <c-h> <Plug>CtrlHJKLMoveH
	xmap <c-l> <Plug>CtrlHJKLMoveL
	xmap <c-x> <Plug>CtrlHJKLClose
endif
