use <_convex_intersection.scad>

function _convex_intersection_for_impl(shapes, pre, leng, i = 2) = 
    pre == [] || i == leng ? pre :
                            _convex_intersection_for_impl(
                                shapes, 
                                _convex_intersection(pre, shapes[i]), 
                                leng, 
                                i + 1
                            );
                
function _convex_intersection_for(shapes) = 
    _convex_intersection_for_impl(
        shapes, 
        _convex_intersection(shapes[0], shapes[1]), 
        len(shapes)
    );