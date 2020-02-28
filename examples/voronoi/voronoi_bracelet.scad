use <hollow_out.scad>;
use <voronoi2d.scad>;
use <bend_extrude.scad>;

r = 35;
height = 35;
thickness = 2.5;
n = 25;
frags = 24;
offset_r = 0.5;
region_type = "square"; // [square, circle]

module voronoi_bracelet(r, height, thickness, n, frags, offset_r, region_type) {
    $fn = 12;
    
    x = 2 * PI * r - thickness;
    y = height;

    xs = rands(0, x, n);
    ys = rands(0, y, n);

    points = [for(i = [0: len(xs) - 1]) [xs[i], ys[i]]];
        
    bend_extrude(
        size = [x, y], 
        thickness = thickness, 
        angle = 360 * (1 - thickness / (2 * PI * r)), 
        frags = frags
    )
    {
        difference() {
            square([x, y]);
            voronoi2d(points, spacing = thickness, r = offset_r, region_type = region_type);
        }
        hollow_out(thickness * 1.5)
            square([x, y]);
    }
}

voronoi_bracelet(r, height, thickness, n, frags, offset_r, region_type);
