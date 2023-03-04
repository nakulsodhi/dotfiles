if status is-interactive
    # Commands to run in interactive sessions can go here
end

#path variables
set PATH $PATH ~/.local/bin

#autostart
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end

