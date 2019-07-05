include <in_shape.scad>;
include <shape_taiwan.scad>;
include <pixel/px_line.scad>;
include <pixel/px_polyline.scad>;
include <pixel/px_sphere.scad>;
include <pixel/px_cylinder.scad>;
include <pixel/px_polygon.scad>;

// Well, quick and dirty!!
color("MediumSeaGreen") 
    translate([3, -5, -27]) 
        for(pt = px_polygon([for(p = shape_taiwan(92, distance = 1)) [round(p[0]), round(p[1])]], filled = true)) {
            translate(pt) 
                linear_extrude(1, scale = 0.5) 
                    square(1, center = true);
        }


color(c = [0.3, 0.3, 0.3]) {
    for(pt = px_sphere(10)) {
        translate(pt)
            cube(1, center = true);
    }
    translate([7, 0, 9]) for(pt = px_sphere(3)) {
        translate(pt)
            cube(1, center = true);
    }
    translate([-7, 0, 9]) for(pt = px_sphere(3)) {
        translate(pt)
            cube(1, center = true);
    }
    
    translate([0, 0, -13]) for(pt = px_sphere(12)) {
        translate(pt)
            cube(1, center = true);
    }  
    
    translate([6, 0, -26]) for(pt = px_cylinder([3, 4], 6)) {
        translate(pt)
            cube(1, center = true);
    }
    
    translate([-6, 0, -26]) for(pt = px_cylinder([3, 4], 6)) {
        translate(pt)
            cube(1, center = true);
    }

    translate([10, 0, -13]) cube([6, 5, 10], center = true);
    translate([-10, 0, -13]) cube([6, 5, 10], center = true);
}
color("white") {
    translate([3, -7, 2]) for(pt = px_sphere(2)) {
        translate(pt)
            cube(1, center = true);
    }
    translate([-3, -7, 2]) for(pt = px_sphere(2)) {
        translate(pt)
            cube(1, center = true);
    }
    translate([0, -7, 0]) for(pt = px_sphere(3)) {
        translate(pt)
            cube(1, center = true);
    }
    translate([0, -9, -4]) for(pt = px_sphere(1)) {
        translate(pt)
            cube(1, center = true);
    }    
    for(pt = px_polyline([[0, -12, -10], [5, -9, -7], [8, -6, -6]])) {
        translate(pt)
            cube(1, center = true);
    }
    for(pt = px_polyline([[0, -12, -10], [5, -9, -8], [8, -6, -7]])) {
        translate(pt)
            cube(1, center = true);
    }
    for(pt = px_polyline([[0, -12, -10], [5, -9, -9], [8, -6, -8]])) {
        translate(pt)
            cube(1, center = true);
    }    
    
    for(pt = px_polyline([[0, -12, -10], [-5, -9, -7], [-8, -6, -6]])) {
        translate(pt)
            cube(1, center = true);
    }
    for(pt = px_polyline([[0, -12, -10], [-5, -9, -8], [-8, -6, -7]])) {
        translate(pt)
            cube(1, center = true);
    }
    for(pt = px_polyline([[0, -12, -10], [-5, -9, -9], [-8, -6, -8]])) {
        translate(pt)
            cube(1, center = true);
    }    
}