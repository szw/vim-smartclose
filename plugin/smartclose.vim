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

augroup SmartClose
    au!
    au BufWinEnter quickfix if !exists('t:smartclose_qbuffers') | let t:smartclose_qbuffers = [bufnr('%')] | else | call add(t:smartclose_qbuffers, bufnr('%')) | endif
augroup END

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

    let buffers_to_close = []

    if exists('t:smartclose_qbuffers')
        let old_qbuffers_indexes = []

        for i in range(0, len(t:smartclose_qbuffers) - 1)
            if buflisted(t:smartclose_qbuffers[i])
                call add(buffers_to_close, t:smartclose_qbuffers[i])
            else
                call add(old_qbuffers_indexes, i)
            endif
        endfor

        for oi in old_qbuffers_indexes
            unlet t:smartclose_qbuffers[oi]
        endfor
    endif

    for b in tabpagebuflist()
        if !buflisted(b)
            call add(buffers_to_close, b)
        endif
    endfor

    if empty(buffers_to_close) || a:bang
        call s:quit_buffer(bufnr('%'))
    else
        call s:quit_buffer(max(buffers_to_close))
    endif
endfun
