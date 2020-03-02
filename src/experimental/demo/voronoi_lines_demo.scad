use <hull_polyline2d.scad>;
use <experimental/voronoi_lines.scad>;
use <experimental/convex_hull.scad>;

pt_nums = 50;
width = 1;
points = [for(i = [0:pt_nums - 1]) rands(-50, 50, 2)];   
  
intersection() {  
    for(line = voronoi_lines(points)) {
        hull_polyline2d(
            line, 
            width = width,
            $fn = 4
        );
    }
    hull()
    #for(p = points) {
        translate(p)
            circle(.5);
    }
}

hull_pts = convex_hull(points);
hull_polyline2d(
    concat(hull_pts, [hull_pts[0]]), 
    width = width, $fn = 4
);