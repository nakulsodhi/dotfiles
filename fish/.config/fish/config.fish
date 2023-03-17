if status is-interactive
    # Commands to run in interactive sessions can go here
end

#path variables
<<<<<<< HEAD
set PATH $PATH ~/.local/bin
=======
set PATH $PATH ~/.local/bin  /opt/texlive/2022/bin/x86_64-linux/
>>>>>>> 8e91809 (First Commit)

#autostart
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
<<<<<<< HEAD
        exec startx -- -keeptty
    end
end

=======
        exec startx 
    end
end


starship init fish | source


>>>>>>> 8e91809 (First Commit)
