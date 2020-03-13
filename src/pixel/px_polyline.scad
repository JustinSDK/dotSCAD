/**
* px_polyline.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-px_polyline.html
*
**/ 

use <__comm__/__to3d.scad>;
use <__comm__/__to2d.scad>;
use <__comm__/__lines_from.scad>;
use <pixel/px_line.scad>;
use <util/sort.scad>;
use <util/dedup.scad>;

function px_polyline(points) =
    let(
        is_2d = len(points[0]) == 2,
        pts = is_2d ? [for(pt = points) __to3d(pt)] : points,
        polyline = [for(line =  __lines_from(pts)) each px_line(line[0], line[1])]
    )
    dedup(is_2d ? 
        sort([for(pt = polyline) __to2d(pt)], by = "vt")
         : 
        sort(polyline, by = "vt")
    , sorted = true);