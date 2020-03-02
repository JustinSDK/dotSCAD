use <hull_polyline2d.scad>;
use <experimental/voronoi_lines.scad>;

pt_nums = 50;
width = 1;
points = [for(i = [0:pt_nums - 1]) rands(-50, 50, 2)];   
    
for(line = voronoi_lines(points)) {
    hull_polyline2d(
        line, 
        width = width,
        $fn = 4
    );
}