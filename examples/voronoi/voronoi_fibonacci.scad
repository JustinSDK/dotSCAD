use <hull_polyline2d.scad>;
use <golden_spiral.scad>;
use <rotate_p.scad>;
use <shape_square.scad>;
use <hollow_out.scad>;
use <experimental/voronoi2d_cells.scad>;

spirals = 2;     // [2:]
line_thickness = .5;
cell_thickness = 2;
cell_top_scale = 0.8;
style = "BLOCK"; // [BLOCK, LINE]

from = 5;
to = 8;
point_distance = 10;

voronoi_fibonacci();

module voronoi_fibonacci() {
    points_angles = golden_spiral(
        from = from, 
        to = to, 
        point_distance = point_distance
    );
    points = [for(pa = points_angles) pa[0]];
    
    a_step = 360 / spirals;

    pts = [
        for(a = [0:a_step:360 - a_step])
        each [for(p = points) rotate_p(p, a)]
    ];

    function default_region_size(points) = 
        let(
            xs = [for(p = points) p[0]],
            ys = [for(p = points) abs(p[1])]
        )
        max([(max(xs) -  min(xs) / 2), (max(ys) -  min(ys)) / 2]);
        

    size = default_region_size(pts);  
    region_shape = shape_square(size);

    cells = voronoi2d_cells(pts, region_shape);
    half_line_thicness = line_thickness / 2;
    lst_r = norm(points[len(points) - 1]) + half_line_thicness;
    for(i = [0:len(pts) - 1]) {
        pt = pts[i];
        cell = cells[i];
        
        if(style == "BLOCK") {
            linear_extrude(line_thickness)
            circle(lst_r);

            color(rands(0, 1, 3))
            translate(pt)    
            linear_extrude(cell_thickness, scale = cell_top_scale)
            translate(-pt)    
            intersection() {
                polygon(cell);
                circle(lst_r);
            }        
        }        
        else {
            linear_extrude(line_thickness) 
            union() {
                intersection() {
                    hollow_out(half_line_thicness) polygon(cell);
                    circle(lst_r);
                }        
                hollow_out(line_thickness) circle(lst_r);
            }
        }
    }
}