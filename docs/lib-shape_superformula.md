# shape_superformula

Returns shape points and triangle indexes of a [Superformula](https://en.wikipedia.org/wiki/Superformula) shape. They can be used with xxx_extrude modules of dotSCAD. The shape points can be also used with the built-in polygon module. 

## Parameters

- `phi_step` : The radius of the circle.
- `m1`, `m2`, `n1`, `n2`, `n3`, `a`, `b` : The parameters of [Superformula](https://en.wikipedia.org/wiki/Superformula). The default value of `n2`, `n3`, `a`, and `b` is 1.

## Examples

    include <shape_superformula.scad>;   
        
    phi_step = 0.05;

    polygon(shape_superformula(phi_step, 3, 3, 4.5, 10, 10)[0]);
    translate([3, 0]) 
        polygon(shape_superformula(phi_step, 4, 4, 12, 15, 15)[0]);
    translate([6, 0]) 
        polygon(shape_superformula(phi_step, 7, 7, 10, 6, 6)[0]);
    translate([9, 0]) 
        polygon(shape_superformula(phi_step, 5, 5, 4, 4, 4)[0]);
        
    translate([0, -4]) 
        scale(0.8) polygon(shape_superformula(phi_step, 5, 5, 2, 7, 7)[0]);
    translate([3, -4]) 
        scale(0.25) polygon(shape_superformula(phi_step, 5, 5, 2, 13, 13)[0]);
    translate([6, -4]) 
        polygon(shape_superformula(phi_step, 4, 4, 1, 1, 1)[0]);
    translate([9, -4]) 
        scale(0.3) polygon(shape_superformula(phi_step, 4, 4, 1, 7, 8)[0]);

![shape_superformula](images/lib-shape_superformula-1.JPG)

    include <shape_superformula.scad>; 
    include <circle_path.scad>;
    include <rotate_p.scad>;
    include <golden_spiral.scad>;
    include <cross_sections.scad>;
    include <polysections.scad>;
    include <golden_spiral_extrude.scad>;  
        
    phi_step = 0.05;

    m = 16;
    n = 0.5;
    n3 = 16;

    shape_pts_tris = shape_superformula(phi_step, m, m, n, n, n3);

    golden_spiral_extrude(
        shape_pts_tris[0], 
        from = 5, 
        to = 10, 
        point_distance = 2,
        scale = 10,
        triangles = shape_pts_tris[1]
    );  

![shape_superformula](images/lib-shape_superformula-2.JPG)
