use <experimental/convex_intersection.scad>;

function _convex_intersection_for(shapes, pre, leng, i = 2) = 
    i == leng ? pre :
                _convex_intersection_for(shapes, 
                    convex_intersection(pre, shapes[i]), 
                    leng, i + 1
                );