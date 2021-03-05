/**
* vx_bezier.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-vx_bezier.html
*
**/ 

use <__comm__/__to2d.scad>;
use <__comm__/__to3d.scad>;
use <_impl/_vx_bezier_impl.scad>;
use <collection/hashset.scad>;
use <collection/hashset_list.scad>;

function vx_bezier(p1, p2, p3, p4) = 
    let(
        is2d = len(p1) == 2,
        pts = is2d ? _vx_bezier2(__to3d(p1), __to3d(p2), __to3d(p3), __to3d(p4), []) :
                     _vx_bezier3(p1, p2, p3, p4, []),
        deduped = hashset_list(hashset(pts))
    )
    is2d ? [for(p = deduped) __to2d(p)] : deduped;