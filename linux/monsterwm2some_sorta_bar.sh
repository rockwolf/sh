#!/usr/bin/env bash

# create a fifo to send output
ff="/tmp/monsterwm.fifo"
[[ -p $ff ]] || mkfifo -m 600 "$ff"

# desktop names
ds=("um" "dois" "três" "quatro")

# layout names
ls=("t" "[]" "b" "+" "f")

while read -t 60 -r wmout || true; do
    if [[ $wmout =~ ^(([[:digit:]]+:)+[[:digit:]]+ ?)+$ ]]; then
        read -ra desktops <<< "$wmout" && unset r
        for desktop in "${desktops[@]}"; do

            # set values for
            # d - the desktop id
            # w - number of windows in that desktop
            # m - tiling layout/mode for that desktop
            # c - whether that desktop is the current (1) or not (0)
            # u - whether a window in that desktop has an urgent hint set (1) or not (0)
            IFS=':' read -r d w m c u <<< "$desktop"

            # if this is the current desktop, color should be '&4'
            # if this is the current desktop, also set the layout name
            # else the color should be '&3'
            ((c)) && fg="&4" i="${ls[$m]}" || fg="&3"

            # if the desktop has an urgent hint, add an 
            # exclamation mark '!' with '&5' color
            ((u)) && w+='&5!'
            r+="$fg${ds[$d]} $w &3:: "
        done
        r="${r%::*}"
    fi

    # read from fifo and output to some_sorta_bar
    printf "&L%s&R%s\n" "$r&5[&3$i&5]" "$(date +"%F %r")"
done < "$ff" | some_sorta_bar &

# pass output to fifo
monsterwm > "$ff"
