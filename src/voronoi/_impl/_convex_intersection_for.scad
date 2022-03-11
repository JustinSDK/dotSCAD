use <_convex_intersection.scad>;

function _convex_intersection_for_impl(shapes, pre, leng, i = 2) = 
    i == leng ? pre :
    let(r = _convex_intersection(pre, shapes[i]))
    r == [] ? r 
            : _convex_intersection_for_impl(shapes, 
                  r, 
                  leng, i + 1
              );
                
function _convex_intersection_for(shapes) = 
    let(leng = len(shapes))
    _convex_intersection_for_impl(
        shapes, 
        _convex_intersection(shapes[0], shapes[1]), 
        leng
    );