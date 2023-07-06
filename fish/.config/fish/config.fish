if status is-interactive
    # Commands to run in interactive sessions can go here
end

#path variables
set PATH $PATH ~/.local/bin /opt/texlive/2023/bin/x86_64-linux/  ~/.cargo/bin

#autostart
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end

starship init fish | source
alias ls="exa"
alias cat="bat"
alias cf="cd ~/.config/"
alias nvconf="cd ~/.config/nvim"
alias work="cd ~/work_docs/Nakul/"
alias wmconf="cd ~/.config/awesome/"
