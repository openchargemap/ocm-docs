#!/bin/bash
for status in {operational,private,nonoperational}; do
        for level in {0..4}; do
                echo generating level"$level"_$status icon;
                ./exportlayers.py map_marker_template.svg level"$level"_$status.svg --show level$level --show $status --hide Base 
                inkscape --file=level"$level"_$status.svg --export-png level"$level"_$status.png --export-area-drawing
		rm level"$level"_$status.svg
        done;
done

