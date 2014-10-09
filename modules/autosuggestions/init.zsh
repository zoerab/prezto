#
# Integrates zsh-autosuggestions into Prezto.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Load dependencies.
pmodload 'editor'

# Source module files.
source "${0:h}/external/autosuggestions.zsh" || return 1

#
# Highlighting
#

# Set highlight color, default is 'fg=8'.
zstyle -s ':prezto:module:autosuggestions:color' found \
  'AUTOSUGGESTION_HIGHLIGHT_COLOR' || AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=8'

# AUTOSUGGESTION_HIGHLIGHT_CURSOR: highlight word after cursor or not. Must be integer value 1 or 0, default is 1.
if ! zstyle -t ':prezto:module:autosuggestions:color' cursor; then
  AUTOSUGGESTION_HIGHLIGHT_CURSOR=1
fi

if ! zstyle -t ':prezto:module:autosuggestions' color; then
  AUTOSUGGESTION_HIGHLIGHT_COLOR=''
  AUTOSUGGESTION_HIGHLIGHT_CURSOR=0
fi

eval "function zle-line-init { zle autosuggest-start; $functions[zle-line-init] }"

#
# Key Bindings
#

if [[ -n "$key_info" ]]; then

  # Vi

  # Accept suggestions without leaving insert mode
  # bindkey -M viins '^f' vi-forward-word
  # or
  # bindkey -M viins '^f' vi-forward-blank-word

  # Emacs and Vi
  for keymap in 'emacs' 'viins'; do
    bindkey -M "$keymap" "$key_info[Control]T" autosuggest-toggle
  done
fi

