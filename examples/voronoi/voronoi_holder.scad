use <bend_extrude.scad>
use <arc.scad>
use <voronoi/vrn2_cells_space.scad>

size = [200, 72];
grid_w = 8;        // grid_w must divide size equally.
thickness = 2;
spacing = 1.5;
frags = 24;

module voronoi_holder() {
    half_spacing = spacing / 2;
    cells = vrn2_cells_space(
        size = size,
        grid_w = grid_w
    );

    r = size[0] / (2 * PI) - thickness * 1.5;
          
    difference() {
        bend_extrude(size = size, thickness = thickness * 3, angle = 360, frags = frags) 
        difference() {
            square(size);
            for(cell = cells) {
                offset(-half_spacing)
                    polygon(cell[1]);
            }
        }
        linear_extrude(size[1] - thickness)
           arc(radius = r, angle = 360, width = thickness, $fn = frags);
    }

    linear_extrude(thickness)
        circle(r + thickness * 1.75, $fn = frags);

    linear_extrude(thickness * 2)
        circle(r - 0.25 * thickness, $fn = frags);        
}

voronoi_holder();