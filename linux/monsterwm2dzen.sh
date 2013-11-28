#!/usr/bin/env bash

: "${wm:=monsterwm}"
: "${ff:="/tmp/$RANDOM.monsterwm.fifo"}"

tags=('1' '2' '3' '4')

layouts=('[]=' '[ ]' 'TTT' '[#]') 

font="-*-inconsolata-medium-*-*-*-18-*-*-*-*-*-*-*"

conky | dzen2 -h 16 -x 320 -ta r -e -p -fn $font&

# Check if it's a pipe, otherwise create it
[[ -p $ff ]] || mkfifo -m 600 "$ff"

while read -t 60 -r wmout || true; do
    desktops=( $(cut -d"|" -f1 <<< "$wmout") )
    title="$(cut -d"|" -f2- <<< "$wmout")"

    if [[ "${desktops[@]}" =~ ^(([[:digit:]]+:)+[[:digit:]]+ ?)+$ ]]; then
        unset tmp

        for desktop in "${desktops[@]}"; do
            IFS=':' read -r d w m c u <<< "$desktop"

            # Tags labels
            label="${tags[$d]}"

            # Is this the current desktop ? save the layout
            ((c)) && fg="#5f8700" bg="#ffffd7" && layout="${layouts[$m]}" \
                  || fg="#626262" bg=""

            # Has windows ?
            ((w)) && fg="#af8700"

            # Urgent windows ?
            ((u)) && fg="#dc322f"

            tmp+="^fg($fg)^bg($bg) $label ^bg()^fg()"
        done
    fi

    # Merge the clients indications, the tile and the info
    echo "$tmp $layout $title"
done < "$ff" | dzen2 -w 320 -h 16 -ta l -e -p -fn $font&

while :; do "$wm" || break; done | tee -a "$ff"
#$wm > "$ff"
