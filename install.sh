#!/usr/bin/env sh

function info() {
	printf "\033[00;34mINFO\033[0m %s$1\n"
}

function warn() {
	printf "\033[0;33mWARNING\033[0m %s$1\n"
}

function okay() {
  printf "\033[0;32m✔ OK\033[0m %s$1\n"
}

function confirmed() {
	read -r -p "[❓] $1 [Y/n] >> " answer
	answer=${answer,,} # tolower
	if [[ $answer =~ ^(y| ) ]] || [[ -z $answer ]]; then
		return 0
	else
		return 1
	fi
}

get_selected_icon() {
  local icon_list=$(find "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/mix-icons" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | tr '\n' ' ')
  PS3="Select an icon: "
  select icon in $icon_list; do
    case $icon in
      *) echo "$icon"; break;;
    esac
  done
}

__install__() {
  if confirmed "Link \"Plasma Mix Icons\" ?"; then
    local icon="$(get_selected_icon)"
    local source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/mix-icons"
    local target_dir="$HOME/.local/share/icons"
    if [ -L "$target_dir/Hahaha" ]; then
      rm -f "$target_dir/Hahaha";
      warn "Removing '$target_dir/Hahaha'";
    fi
    if [ -L "$target_dir/Hahaha-Light" ]; then
      rm -f "$target_dir/Hahaha-Light";
      warn "Removing '$target_dir/Hahaha-Light'";
    fi
    if [ -L "$target_dir/Hahaha-Dark" ]; then
      rm -f "$target_dir/Hahaha-Dark";
      warn "Removing '$target_dir/Hahaha-Dark'";
    fi
    case "$icon" in
      "Hahaha")
        ln -sf "$source_dir/Hahaha" "$target_dir/Hahaha";
        info "Linking Hahaha to '$target_dir/Hahaha'";
        ln -sf "$source_dir/Hahaha-Light" "$target_dir/Hahaha-Light";
        info "Linking Hahaha-Light to '$target_dir/Hahaha-Light'";
        ln -sf "$source_dir/Hahaha-Dark" "$target_dir/Hahaha-Dark";
        info "Linking Hahaha-Dark to '$target_dir/Hahaha-Dark'";
        ;;
      *)
        ln -sf "$source_dir/$icon" "$target_dir/$icon"
        ;;
    esac
    okay "All DONE"
  fi
}

__install__
