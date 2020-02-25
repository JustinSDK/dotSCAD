/**
   copy from triangulate.scad, would move into triangle category
**/

use <experimental/_impl/_tri_ear_clipping_impl.scad>;
    
function tri_ear_clipping(shape_pts,  epsilon = 0.0001) = _tri_ear_clipping_impl(shape_pts,  epsilon);