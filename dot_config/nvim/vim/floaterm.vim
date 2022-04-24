let g:floaterm_borderchars = "─│─│╭╮╯╰"
let s:width = "1.0"
let s:height = "1.0"
let s:autoclose = "1"
let s:command = 'lazygit'

let g:floaterm_keymap_toggle = '<C-\>'

function! s:open_lazygit_popup() 
  execute "FloatermNew --height=" . s:height . " --width=" . s:width . " --autoclose=" . s:autoclose . " " . s:command
endfunction

nnoremap <silent> <leader>lz :call <SID>open_lazygit_popup()<CR>
