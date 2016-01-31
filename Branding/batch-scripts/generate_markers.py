#!/usr/bin/env python

"""
Create PNG map marker files from SVG template.
https://github.com/openchargemap/ocm-docs/blob/master/Branding/batch-scripts/generate_markers.py
"""

import os
import sys
import subprocess
import re
try:
    from lxml import etree
except:
    sys.exit('lxml wrapper for libxml2 is required. Please download and install the latest version from https://pypi.python.org/pypi/lxml/, or install it through your package manager')

# Set paths
INKSCAPE_CMD = "inkscape"
INPUT_FILE  = os.path.join(os.pardir, 'map-markers', 'map_marker_template.svg')
OUTPUT_FOLDER = os.path.join(os.pardir, 'map-markers', '') # Should this be build-output?

def export_layers(src, dest, show):
    """
    Export selected layers of SVG in the file `src` to the file `dest`.
    Mark to show (display:inline) the ones we want, the rest mark to hide (display:none)
    """
    svg = etree.parse(open(src))
    layer_hide = []
    layer_show = []
    for layer in svg.iter('{http://www.w3.org/2000/svg}g'):
        if '{http://www.inkscape.org/namespaces/inkscape}label' in layer.attrib:
            label = layer.attrib['{http://www.inkscape.org/namespaces/inkscape}label']
            if label in show:
                layer.attrib['style'] = 'display:inline'
                layer_show.append(label)
            else:
                layer.attrib['style'] = 'display:none'
                layer_hide.append(label)
    svg.write(dest, encoding="utf8", pretty_print=True)
    print ("Hide {} layer(s);  Show {} layer(s): ({})".format(len(layer_hide), len(layer_show), ", ".join(layer_show)))

def set_colours(src, dest, clrmap):
    """
    Modify colours of selected objects of SVG in the file `src` to the file `dest`.
    clrmap is a list of swatch numbers for clr0, clr1, etc
    """
    svg = etree.parse(open(src))
    clrobjs = []
    swatch = {}
    # obtain required style properties from colour swatches
    # and find all objects which should be set. So everything with id=clr*
    ns = {'svg': 'http://www.w3.org/2000/svg'}
    for obj in svg.xpath("//*[starts-with(@id,'clr')]", namespaces=ns):
        id = obj.attrib['id']
        style = obj.attrib['style']
        if re.search('clr\d+\-\d+',id):
            # colour swatch (id=clr<x>-<y>)
            fill = re.search('fill:#[^;]*', style).group(0)
            opacity = re.search('fill-opacity:[^;]*', style).group(0)
            swatch[id] = [fill, opacity]
        else:
            # object that needs colour changed (id=clr<x>obj<n>)
            clrobjs.append(obj)
    # apply style to matching objects
    colour_set = []
    for obj in clrobjs:
        id = obj.attrib['id']
        style = obj.attrib['style']
        clrset = int(re.search('clr(\d+)',id).group(1))
        if clrset < len(clrmap): # else no colour provided for this object's clrset
            colour_set.append(id)
            newclr = swatch['clr{}-{}'.format(clrset,clrmap[clrset])]
            style = re.sub('fill:#[^;]*', newclr[0], style)
            style = re.sub('fill-opacity:[^;]*', newclr[1], style)
            obj.attrib['style'] = style
    svg.write(dest, encoding='utf8', pretty_print=True)
    print ("Set colour for {} object(s): ({})".format(len(colour_set), ", ".join(colour_set)))


def main():
    # Generate POI map markers. Export a marker for each level and status
    for status in ['operational','private','nonoperational']:
        for level in range(0,5):
            outfile = OUTPUT_FOLDER + "level%d_%s_icon" % (level,status)
            print ("\nGenerating " + outfile + ".svg")
            set_colours(INPUT_FILE, outfile+".svg", [level])
            export_layers(outfile+".svg", outfile+".svg", ["Status",status,"Marker"])
            subprocess.call([INKSCAPE_CMD, "--file", outfile + ".svg", "--export-png",  outfile + ".png", "--export-area-drawing"])
            print ("Deleting " + outfile + ".svg")
            os.remove(outfile + ".svg")

if __name__ == '__main__':
    main()