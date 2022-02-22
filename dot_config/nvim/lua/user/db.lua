vim.cmd([[
noremap <silent><leader>dd :DBUIToggle<Cr>
noremap <silent><leader>df :DBUIFindBuffer<Cr>

let g:db_ui_show_help = 0
let g:db_ui_winwidth = 25
let g:db_ui_execute_on_save = 0
let g:db_ui_save_location = '~/development/sql/'
let g:db_ui_show_database_icon = 1
let g:db_ui_use_nerd_fonts = 1
let g:db_ui_force_echo_notifications = 1
let g:db_ui_auto_execute_table_helpers = 1

autocmd FileType dbout setlocal foldlevel=1
autocmd FileType sql map <silent><leader><leader> <Plug>(DBUI_ExecuteQuery)
]])
