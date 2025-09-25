#!/bin/sh

# show_thumbnails=1
fzf_preview_side=right
print_link_shortcut=ctrl-o
enable_hist=0
enable_search_hist=0
# log_level=1
log_level=2

video_player() {
  #this function should not be set as the url_handler as it is part of multimedia_player
  command_exists "mpv" || die 3 "mpv is not installed\n"
  DRI_PRIME=1 mpv "$@"
}
