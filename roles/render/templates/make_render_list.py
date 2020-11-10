#!/bin/python3

import mercantile
import requests
from shapely.geometry import (shape, box)

url = "{{ geojson_url }}"
zooms = range(0, 18+1) # we make +1 to include zoom 18

# get the geojson
r = requests.get(url)

# get the shape
geom = shape(r.json())
bounds = geom.bounds
north = bounds[3]
south = bounds[1]
west  = bounds[0]
east  = bounds[2]
# print(f"north: { north }, south: { south }, east: { east }, west: { west }")
# print(zooms)

# cache the processed
processed = set()

# loop over all tiles
x = 0
for t in mercantile.tiles(west, south, east, north, zooms):

    tile_bbox = mercantile.bounds(t)
    bbox = box(tile_bbox.west, tile_bbox.south, tile_bbox.east, tile_bbox.north)

    if geom.intersects(bbox):
        x_ul = t.x - t.x % 8
        y_ul = t.y - t.y % 8
        if (x_ul, y_ul, t.z) not in processed:
            print(f"{x_ul} {y_ul} {t.z}")
            processed.add((x_ul, y_ul, t.z))
#    for l in f.readlines():
#        x_str, y_str, z_str = l.split(' ')
#        # convert to in
#        x_int = int(x_str)
#        y_int = int(y_str)
#        z_int = int(z_str)
#        x_ul  = x_int - x_int % 8
#        y_ul  = y_int - y_int % 8
#
#        if (x_ul, y_ul, z_int) not in processed:
#            print(f"{x_ul} {y_ul} {z_int}")
#            processed.add((x_ul, y_ul, z_int))
