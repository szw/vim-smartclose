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

SmartClose is a wise closing utility. What does it mean? SmartClose plugin distinguishes two kinds
of windows (the main windows you use to work) and the auxiliary windows (a preview window,
a NERDTree panel, a quickfix window, etc). Basically, the plugin provides you the closing ability
just with single keystroke (`<F10>`). But if there are any auxiliary windows visible, it closes them
first (in the LIFO order). It means, you don't have to leave the current (regualar) window to close an
auxiliary one. Just hit `<F10>` and you'll get it closed. If there are no auxiliary windows visible,
`<F10>` will close the current window (and a tab if it would be the last window in the tab, or the editor
itself, if it would be the last tab).

If you hit `<F10>` in the auxiliary windows it gets closed immediately. Also, by default, you can
close the regular window in the same way, but only within the first second after entering the window.
In other words, the smart auxiliary windows closing feature is delayed about 1 sec. This way you
can move into a regular window you want to close, hit immediately `<F10>`, and close it even if
there are open auxilary windows on the screen. The delay can be adjusted or even disabled.

Usage
-----

SmartClose has only one command:

    :SmartClose

Also the plugin can define some default mappings if the user wants to. By default it maps to
`<F10>` in normal, insert, and visual modes. See [Configuration](#configuration) to get some
examples.

The banged version forces closing of the current window:

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


* `smartclose_delay`

    Sets the delay of smart closing auxiliary windows. After entering a new window `<F10>` will
    start closing auxiliary windows first after that period. By default is's 1000ms (1 second).
    You can turn off delaying completely by setting this variable to 0.

        let g:smartclose_delay = 1000


Author and License
------------------

SmartClose was written by Szymon Wrozynski and
[Contributors](https://github.com/szw/vim-smartclose/commits/master). It is licensed under the same
terms as Vim itself.

Copyright &copy; 2013 Szymon Wrozynski. See `:help license`
