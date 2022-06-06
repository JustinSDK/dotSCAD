use <shape_taiwan.scad>
use <voxel/vx_polyline.scad>
use <voxel/vx_sphere.scad>
use <voxel/vx_cylinder.scad>
use <voxel/vx_polygon.scad>

module blocks(points) {
    for(pt = points) {
        translate(pt)
            cube(1, center = true);
    }
}

// Well, quick and dirty!!
color("MediumSeaGreen") 
translate([3, -5, -27]) 
for(pt = vx_polygon([for(p = shape_taiwan(92, distance = 1)) [round(p[0]), round(p[1])]], filled = true)) {
    translate(pt) 
    linear_extrude(1, scale = 0.5) 
        square(1, center = true);
}

color(c = [0.3, 0.3, 0.3]) {
    blocks(vx_sphere(10));
    translate([7, 0, 9]) blocks(vx_sphere(3));
    translate([-7, 0, 9]) blocks(vx_sphere(3));
    translate([0, 0, -13]) blocks(vx_sphere(12));
    translate([6, 0, -26]) blocks(vx_cylinder([3, 4], 6));
    translate([-6, 0, -26]) blocks(vx_cylinder([3, 4], 6))
    translate([10, 0, -13]) cube([6, 5, 10], center = true);
    translate([-10, 0, -13]) cube([6, 5, 10], center = true);
}
color("white") {
    translate([3, -7, 2]) blocks(vx_sphere(2));
    translate([-3, -7, 2]) blocks(vx_sphere(2));
    translate([0, -7, 0]) blocks(vx_sphere(3));
    translate([0, -9, -4]) blocks(vx_sphere(1));
    blocks(vx_polyline([[0, -12, -10], [5, -9, -7], [8, -6, -6]]));
    blocks(vx_polyline([[0, -12, -10], [5, -9, -8], [8, -6, -7]]));
    blocks(vx_polyline([[0, -12, -10], [5, -9, -9], [8, -6, -8]]));
    blocks(vx_polyline([[0, -12, -10], [5, -9, -9], [8, -6, -8]]));
    blocks(vx_polyline([[0, -12, -10], [-5, -9, -7], [-8, -6, -6]]));
    blocks(vx_polyline([[0, -12, -10], [-5, -9, -8], [-8, -6, -7]]));
    blocks(vx_polyline([[0, -12, -10], [-5, -9, -9], [-8, -6, -8]]));
}