# Standarized $0 handling, see:
# http://zdharma.org/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html#zero-handling

0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

[[ -z ${manpath[(re)$ZPFX/man]} ]] && manpath=( "$ZPFX/man" "${manpath[@]}" )
[[ ! -d $ZPFX/man/man1 ]] && command mkdir -p $ZPFX/man/man1

# Handler's are using the ":" symbol as the namespacer
autoload -Uz :za-zman-atclone-handler :za-zman-atdelete-handler

# An empty stub to fill the help handler fields
:za-zman-help-null-handler() { :; }

@zinit-register-annex "z-a-zman" hook:atclone-50 \
        :za-zman-atclone-handler :za-zman-help-null-handler \
        "zman" # register a new ice-mod: man

@zinit-register-annex "z-a-zman" hook:%atpull-50 \
        :za-zman-atclone-handler :za-zman-help-null-handler

@zinit-register-annex "z-a-zman" hook:atdelete-50 \
        :za-zman-atdelete-handler :za-zman-help-null-handler
