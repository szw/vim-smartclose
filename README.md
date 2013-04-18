vim-smartclose
============

Close Vim windows in a smart way!


Installation
------------

Place in *~/.vim/plugin/smartclose.vim* or in case of Pathogen:

    cd ~/.vim/bundle
    git clone https://github.com/szw/vim-smartclose.git

Please, don't forget to star the repository if you like (and use) the plugin. This will let me know
how many users it has and then how to proceed with further development :).


About
-----

SmartClose is a wise closing utility. Basically, it closes windows from the current tab with
a single keystroke (`<F10>` by default). And if you choose the banged version it just closes the
current window. But some real nice things happen if you let the plugin to decide which window should
be closed.

The plugin can estimate that, regarding your current active window, its buffer type, and the whole
list of visible buffers. It prefers to close not listed ones first (but including quickfix windows).
Then it closes the current normal window. If it is the last window in the tab, it closes the tab. If
it is the last tab, it closes Vim.


Usage
-----

SmartClose has only one command:

    :SmartClose

Also the plugin can define some default mappings if the user wants to.  By default it maps to
`<F10>` in normal, insert, and visual modes.  See [Configuration](#configuration) to get some
examples.

The banged version force to close the current window:

    :SmartClose!


<div id="configuration"></div>
Configuration
-------------

SmartClose is extremely handy with command mappings. By default it uses `<F10>` like here:

    nnoremap <silent><F10> :SmartClose<CR>
    vnoremap <silent><F10> :SmartClose<CR>
    inoremap <silent><F10> <C-[>:SmartClose<CR>

With these mappings you can hit `<F10>` any time, not only in normal mode.

Here are some plugin options:

* `smartclose_set_default_mapping`

    Whether SmartClose should set default mappings or not:

        let g:smartclose_set_default_mapping = 1


* `smartclose_set_mapping_with_bang`

    Whether SmartClose should set default mappings with banged version or not:

        let g:smartclose_set_mapping_with_bang = 0


* `smartclose_default_mapping_key`

    The default mappings key:

        let g:smartclose_default_mapping_key = '<F10>'


Author and License
------------------

SmartClose was written by Szymon Wrozynski and
[Contributors](https://github.com/szw/vim-smartclose/commits/master). It is licensed under the same
terms as Vim itself.

Copyright &copy; 2013 Szymon Wrozynski. See `:help license`
