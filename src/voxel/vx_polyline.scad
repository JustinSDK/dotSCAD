/**
* vx_polyline.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_polyline.html
*
**/ 

use <../__comm__/__to3d.scad>
use <../__comm__/__to2d.scad>
use <../__comm__/__lines_from.scad>
use <../util/dedup.scad>
use <vx_line.scad>

include <../__comm__/_pt2_hash.scad>
include <../__comm__/_pt3_hash.scad>

function vx_polyline(points) =
    let(
        is_2d = len(points[0]) == 2,
        pts = is_2d ? [for(pt = points) __to3d(pt)] : points,
        polyline = [for(line =  __lines_from(pts)) each vx_line(line[0], line[1])]
    )
    dedup(
        is_2d ? [for(pt = polyline) __to2d(pt)] : polyline, 
        hash = is_2d ? _pt2_hash : _pt3_hash
    );