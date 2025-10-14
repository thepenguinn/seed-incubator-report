#!/bin/bash

declare -a pics

directory="label_pics"
parameter_file="$directory/parameters.tex"

mkdir "$directory" > /dev/null 2>&1

pics+=( "elec_bay_right_crop" \
    "ext_both_right_crop" \
    "hume_res_left_crop" \
    "inc_area_left_crop" \
    "side_hatch_right_crop" \
    "top_hatch_left_crop" \
    "water_res_right_crop"
)

direction+=("0" \
    "1" \
    "0" \
    "0" \
    "1" \
    "1" \
    "1"
)

label+=("ELECTRONICS BAY" \
    "EXHAUST SYSTEM" \
    "HUMIDIFIER RESERVOIR" \
    "INCUBATOR AREA" \
    "SIDE HATCH" \
    "TOP HATCH" \
    "WATER AND FERTILIZER \\\\ RESERVOIR"
)

point+=("450pt, -1242pt" \
    "1611pt, -304pt" \
    "483pt, -972pt" \
    "734pt, -1187pt" \
    "1711pt, -987pt" \
    "1491pt, -523pt" \
    "1820pt, -488pt"
)

cwd=$(pwd)

for i in $(seq 0 $((${#pics[@]}-1)))
do

    cp ${pics[$i]}.png $directory

    printf "" > "$parameter_file"
    echo "\\def\\direction{${direction[$i]}}" >> "$parameter_file"
    echo "\\def\\picFile{${pics[$i]}.png}" >> "$parameter_file"
    echo "\\def\\partLabel{${label[$i]}}" >> "$parameter_file"
    echo "\\def\\partPoint{${point[$i]}}" >> "$parameter_file"

    cd $directory && make

    cp label.pdf ../${pics[$i]}_label.pdf

    cd $cwd

done
