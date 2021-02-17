# Standarized $0 handling, see:
# http://zdharma.org/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html#zero-handling

0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

[[ -d $ZPFX/man/man1 ]] || command mkdir -p $ZPFX/man/man1
[[ -z ${manpath[(re)$ZPFX/man]} ]] && manpath=( "$ZPFX/man" "${manpath[@]}" )

# Handler's are using the ":" symbol as the namespacer
autoload -Uz :za-linkman-atclone-handler :za-linkman-atdelete-handler

# An empty stub to fill the help handler fields
:za-linkman-help-null-handler() { :; }

@zinit-register-annex "z-a-linkman" hook:atclone-50 \
        :za-linkman-atclone-handler :za-linkman-help-null-handler \
        "lman" # register a new ice-mod: lman

@zinit-register-annex "z-a-linkman" hook:atpull-50 \
        :za-linkman-atclone-handler :za-linkman-help-null-handler

@zinit-register-annex "z-a-linkman" hook:atdelete-50 \
        :za-linkman-atdelete-handler :za-linkman-help-null-handler
