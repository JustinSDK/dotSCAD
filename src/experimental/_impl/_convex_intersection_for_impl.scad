use <experimental/convex_intersection.scad>;

function _convex_intersection_for(shapes, pre, leng, i = 2) = 
    i == leng ? pre :
    let(r = convex_intersection(pre, shapes[i]))
    r == [] ? [] 
            : _convex_intersection_for(shapes, 
                  r, 
                  leng, i + 1
              );