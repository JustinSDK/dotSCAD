use <_impl/_contours_impl.scad>;

function contours(points, threshold) = 
    is_undef(threshold[1]) ? 
        _marching_squares_isolines(points, threshold) :
        _marching_squares_isobands(points, threshold[0], threshold[1]);