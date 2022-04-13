vim.cmd([[
let g:vimtex_imaps_enabled = 0
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_view_method = 'zathura'

noremap M <Plug>(vimtex-%)
noremap \]\] <Plug>(vimtex-\]\])
noremap \[\[ <Plug>(vimtex-\[\[)

onoremap am <Plug>(vimtex-a$)
xnoremap am <Plug>(vimtex-a$)
onoremap im <Plug>(vimtex-i$)
xnoremap im <Plug>(vimtex-i$)
noremap tsm <Plug>(vimtex-env-toggle-math)

onoremap ai <Plug>(vimtex-am)
xnoremap ai <Plug>(vimtex-am)
onoremap ii <Plug>(vimtex-im)
xnoremap ii <Plug>(vimtex-im)

let g:vimtex_delim_toggle_mod_list = [
  \ ['\left', '\right'],
  \ ['\big', '\big'],
  \]

noremap <silent><leader>v <Plug>(vimtex-view)
nnoremap <silent><leader><space> <Plug>(vimtex-compile)
]])
