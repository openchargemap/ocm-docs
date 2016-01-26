#!/usr/bin/env python

"""
Create PNG marker files from SVG template.
https://github.com/openchargemap/ocm-docs/blob/master/Branding/batch-scripts/generate_markers.py
"""

from xml.dom import minidom
import os
import subprocess
import codecs

# some constants to help with OS portability. There's probably a better way.
INKSCAPE_PATH = "inkscape"
INPUT_PATH = "../map-markers/map_marker_template.svg" # assuming starting in ocm-docs/Branding/batch-scripts
OUTPUT_FOLDER = "../map-markers/" # assuming starting in ocm-docs/Branding/batch-scripts. Should this be build-output?

def export_layers(src, dest, show):
    """
    Export selected layers of SVG in the file `src` to the file `dest`.
    Mark to show (display:inline) the ones we want, the rest mark to hide (display:none)
    """
    svg = minidom.parse(open(src))
    g_hide = []
    g_show = []
    for g in svg.getElementsByTagName("g"):
        if g.attributes.has_key("inkscape:label"):
            label = g.attributes["inkscape:label"].value
            if label in show:
                g.attributes['style'] = 'display:inline'
                g_show.append(label)
            else:
                g.attributes['style'] = 'display:none'
                g_hide.append(label)
    export = svg.toxml()
    codecs.open(dest, "w", encoding="utf8").write(export)
    print "Hide {0} node(s);  Show {1} node(s): ({2}).".format(len(g_hide), len(g_show), ", ".join(g_show))


def main():
    # Generate POI map markers. Export a marker for each level and status
    for status in ['operational','private','nonoperational']:
        for level in range(0,5):
            outfile = "level%d_%s_icon" % (level,status)
            print "generating " + outfile + ".svg"
            export_layers(INPUT_PATH, outfile+".svg", ["Level","Status","level%d"%level,status,"Marker-upper","Marker-lower"])
            subprocess.call([INKSCAPE_PATH, "--file", outfile + ".svg", "--export-png",  OUTPUT_FOLDER + outfile + ".png", "--export-area-drawing"])
            os.remove(outfile + ".svg")

if __name__ == '__main__':
    main()
