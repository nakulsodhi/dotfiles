if status is-interactive
    # Commands to run in interactive sessions can go here
end

#path variables
<<<<<<< HEAD
<<<<<<< HEAD
set PATH $PATH ~/.local/bin
=======
set PATH $PATH ~/.local/bin  /opt/texlive/2022/bin/x86_64-linux/
>>>>>>> 8e91809 (First Commit)
=======
set PATH $PATH ~/.local/bin  /opt/texlive/2023/bin/x86_64-linux/ ~/.cargo/bin
>>>>>>> b3f07e6 (Improved the nvim autocomplete config by: 1) Fixing overlapping keybinds 2) Adding the buffer and path as possible autocomplete sources)

#autostart
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
<<<<<<< HEAD
<<<<<<< HEAD
        exec startx -- -keeptty
    end
end

=======
        exec startx 
=======
         exec startx 
>>>>>>> b3f07e6 (Improved the nvim autocomplete config by: 1) Fixing overlapping keybinds 2) Adding the buffer and path as possible autocomplete sources)
    end
end


starship init fish | source


>>>>>>> 8e91809 (First Commit)
