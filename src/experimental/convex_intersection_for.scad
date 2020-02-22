use <experimental/convex_intersection.scad>;
use <experimental/_impl/_convex_intersection_for_impl.scad>;
                
function convex_intersection_for(shapes) = 
    let(leng = len(shapes))
    _convex_intersection_for(
        shapes, 
        convex_intersection(shapes[0], shapes[1]), 
        leng
    );