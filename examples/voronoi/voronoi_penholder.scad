use <hull_polyline2d.scad>;
use <shape_square.scad>;
use <hollow_out.scad>;
use <bend_extrude.scad>;
use <experimental/voronoi2d_cells.scad>;

xy = [100, 40];
pt_nums = 20;
thickness = 2;

voronoi_penholder(xy, pt_nums, thickness);

module voronoi_penholder(xy, pt_nums, thickness) {
    xs1 = rands(0, xy[0], pt_nums);
    ys1 = rands(0, xy[1], pt_nums);
    points = [for(i = [0:len(xs1) - 1]) [xs1[i], ys1[i]]];

    cpts = concat(
        [for(p = points) if(p[0] > xy[0] - 10) p + [-xy[0], 0]],
        points,
        [for(p = points) if(p[0] < 10) p + [xy[0], 0]]
    );

    function default_region_size(points) = 
        let(
            xs = [for(p = points) p[0]],
            ys = [for(p = points) abs(p[1])]
        )
        max([(max(xs) -  min(xs) / 2), (max(ys) -  min(ys)) / 2]);

    size = default_region_size(cpts);  
    region_shape = shape_square(size, corner_r = size / 5);

    cells = voronoi2d_cells(cpts, region_shape);
    bend_extrude(size = [xy[0], xy[1]], thickness = thickness, angle = 360, $fn = 48) 
    {
        for(i = [0:len(cpts) - 1]) {
            cell = cells[i];
            hull_polyline2d(concat(cell, [cell[0]]), width = thickness);
            
        }
    }

    r = 0.5 * xy[0] / PI;

    linear_extrude(thickness)
        circle(r, $fn = 48);

    translate([0, 0, xy[1]])    
    linear_extrude(thickness)
    hollow_out(shell_thickness = thickness)
        circle(r, $fn = 48);
}