" vim-smartclose - Close Vim windows in a smart way!
" Maintainer:   Szymon Wrozynski
" Version:      0.0.2
"
" Installation:
" Place in ~/.vim/plugin/smartclose.vim or in case of Pathogen:
"
"     cd ~/.vim/bundle
"     git clone https://github.com/szw/vim-smartclose.git
"
" License:
" Copyright (c) 2013 Szymon Wrozynski and Contributors.
" Distributed under the same terms as Vim itself.
" See :help license
"
" Usage:
" help :SmartClose
" https://github.com/szw/vim-smartclose/blob/master/README.md

if exists("g:loaded_smartclose") || &cp || v:version < 700
    finish
endif

let g:loaded_smartclose = 1

if !exists('g:smartclose_set_default_mapping')
    let g:smartclose_set_default_mapping = 1
endif

if !exists('g:smartclose_set_mapping_with_bang')
    let g:smartclose_set_mapping_with_bang = 0
endif

if !exists('g:smartclose_default_mapping_key')
    let g:smartclose_default_mapping_key = '<F10>'
endif

if !exists('g:smartclose_delay')
    let g:smartclose_delay = 1000
endif

command! -bang -nargs=0 -range SmartClose :call s:smart_close(<bang>0)

let s:default_updatetime = &updatetime
let s:delayed_closing = 0

if g:smartclose_set_default_mapping
    let command = ':SmartClose'

    if g:smartclose_set_mapping_with_bang
        let command .= '!'
    endif

    silent! exe 'nnoremap <silent>' . g:smartclose_default_mapping_key . ' ' . command . '<CR>'
    silent! exe 'vnoremap <silent>' . g:smartclose_default_mapping_key . ' ' . command . '<CR>'
    silent! exe 'inoremap <silent>' . g:smartclose_default_mapping_key . ' <C-[>' . command . '<CR>'
endif

if g:smartclose_delay
    augroup SmartCloseDelay
        au!
        au WinEnter * let s:delayed_closing = 1 | exe 'setl ut=' . g:smartclose_delay | call s:grab_cursor_hold_once()
    augroup END
endif

fun! s:grab_cursor_hold_once()
    augroup SmartCloseCursorHold
        au!
        au CursorHold * let s:delayed_closing = 0 | exe 'setl ut=' . s:default_updatetime | au! SmartCloseCursorHold CursorHold
    augroup END
endfun

fun! s:is_auxiliary(buffer)
    return !getbufvar(a:buffer, '&modifiable') || !getbufvar(a:buffer, '&buflisted') || (getbufvar(a:buffer, '&buftype') != '')
endfun

fun! s:smart_close(bang)
    let current_buffer = bufnr('%')

    if s:is_auxiliary(current_buffer) || s:delayed_closing || a:bang
        silent! exe 'noautocmd q'
    else
        let auxiliary_buffer = 0

        for b in tabpagebuflist()
            if s:is_auxiliary(b) && (b > auxiliary_buffer)
                let auxiliary_buffer = b
            endif
        endfor

        if auxiliary_buffer
            silent! exe 'noautocmd ' . bufwinnr(auxiliary_buffer) . 'wincmd w'
            silent! exe 'noautocmd q'
            silent! exe 'noautocmd ' . bufwinnr(current_buffer) . 'wincmd w'
        else
            silent! exe 'noautocmd q'
        endif
    endif
endfun
