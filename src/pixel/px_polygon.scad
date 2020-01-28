/**
* px_polygon.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-px_polygon.html
*
**/ 

use <in_shape.scad>;
use <pixel/px_polyline.scad>;

function px_polygon(points, filled = false) =
    filled ?
    let(
        xs = [for(pt = points) pt[0]],
        ys = [for(pt = points) pt[1]],
        max_x = max(xs),
        min_x = min(xs),
        max_y = max(ys),
        min_y = min(ys)
    )
    [
        for(y = min_y; y <= max_y; y = y + 1)
            for(x = min_x; x <= max_x; x = x + 1)
                let(pt = [x, y])
                if(in_shape(points, pt, true)) pt
    ]
    : 
    px_polyline(
        concat(points, [points[len(points) - 1], points[0]])
    );
    