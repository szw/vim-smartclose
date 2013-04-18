" vim-smartclose - Close Vim windows in a smart way!
" Maintainer:   Szymon Wrozynski
" Version:      0.0.1
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

command! -bang -nargs=0 -range SmartClose :call s:smart_close(<bang>0)

if g:smartclose_set_default_mapping
    let command = ':SmartClose'

    if g:smartclose_set_mapping_with_bang
        let command .= '!'
    endif

    silent! exe 'nnoremap <silent>' . g:smartclose_default_mapping_key . ' ' . command . '<CR>'
    silent! exe 'vnoremap <silent>' . g:smartclose_default_mapping_key . ' ' . command . '<CR>'
    silent! exe 'inoremap <silent>' . g:smartclose_default_mapping_key . ' <C-[>' . command . '<CR>'
endif

fun! s:quit_buffer(bufnr)
    for i in range(1, winnr('$'))
        if winbufnr(i) == a:bufnr
            if winnr() == i
                silent! exe 'q'
            else
                let current_buffer = bufnr('%')
                silent! exe i . 'wincmd w'
                silent! exe 'q'

                for j in range(1, winnr('$'))
                    if winbufnr(j) == current_buffer
                        silent! exe j . 'wincmd w'
                        return
                    endif
                endfor
            endif
            return
        endif
    endfor
endfun

fun! s:smart_close(bang)
    if !empty(&buftype)
        call s:quit_buffer(bufnr('%'))
        return
    endif

    let candidates = []

    for b in tabpagebuflist()
        if !getbufvar(b, '&modifiable') || !getbufvar(b, '&buflisted') || (getbufvar(b, '&buftype') != '')
            call add(candidates, b)
        endif
    endfor

    if empty(candidates) || a:bang
        call s:quit_buffer(bufnr('%'))
    else
        call s:quit_buffer(max(candidates))
    endif
endfun
