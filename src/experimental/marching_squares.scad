use <experimental/_impl/_marching_squares_impl.scad>;

function marching_squares(points, sigma) = 
    let(labeled_pts = pn_label(points, sigma))
    [
        for(y = [0:len(labeled_pts) - 2])
            [
                 for(x = [0:len(labeled_pts[0]) - 2])
                 let(
                    p0 = labeled_pts[y][x],
                    p1 = labeled_pts[y + 1][x],
                    p2 = labeled_pts[y + 1][x + 1],
                    p3 = labeled_pts[y][x + 1],
                    cell_pts = [p0, p1, p2, p3],
                    contours_lt = contours_of(cell_pts, sigma)
                 )
                 if(contours_lt != [])
                 each contours_lt
           ]
    ];