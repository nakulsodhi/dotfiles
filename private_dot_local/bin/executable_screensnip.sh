#!/usr/bin/env bash
name=$(date +%F-%Hh%Mm%Ss_grim)
grimblast --notify --freeze save area - | swappy -f - -o - | tee ~/screenshots/$name.png | wl-copy -t image/png
# delay added to remove the borders
