if status is-interactive
    # Commands to run in interactive sessions can go here
end

#path variables
set PATH $PATH ~/.local/bin /opt/texlive/2023/bin/x86_64-linux/ /opt/sratoolkit.3.0.5-ubuntu64/bin/

#autostart
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end

starship init fish | source
