let g:vimtex_imaps_enabled = 0
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_view_method = 'zathura'

autocmd Filetype tex noremap M <Plug>(vimtex-%)
autocmd Filetype tex noremap ]] <Plug>(vimtex-]])
autocmd Filetype tex noremap [[ <Plug>(vimtex-[[)

autocmd Filetype tex onoremap am <Plug>(vimtex-a$)
autocmd Filetype tex xnoremap am <Plug>(vimtex-a$)
autocmd Filetype tex onoremap im <Plug>(vimtex-i$)
autocmd Filetype tex xnoremap im <Plug>(vimtex-i$)
autocmd Filetype tex noremap tsm <Plug>(vimtex-env-toggle-math)

autocmd Filetype tex onoremap ai <Plug>(vimtex-am)
autocmd Filetype tex xnoremap ai <Plug>(vimtex-am)
autocmd Filetype tex onoremap ii <Plug>(vimtex-im)
autocmd Filetype tex xnoremap ii <Plug>(vimtex-im)

let g:vimtex_delim_toggle_mod_list = [
  \ ['\left', '\right'],
  \ ['\big', '\big'],
  \]

autocmd Filetype tex noremap <silent><leader>v <Plug>(vimtex-view)
autocmd Filetype tex nnoremap <silent><leader><space> <Plug>(vimtex-compile)
