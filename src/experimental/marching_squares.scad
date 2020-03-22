use <experimental/_impl/_marching_squares_impl.scad>;

function marching_squares(points, threshold) = 
    is_undef(threshold[1]) ? 
        _marching_squares_isolines(points, threshold) :
        _marching_squares_isobands(points, threshold[0], threshold[1]);