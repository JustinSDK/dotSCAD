use <voronoi3d.scad>;
use <bezier_curve.scad>;
use <hollow_out.scad>;
use <polysections.scad>;

r = 13;
h = 60;
thickness = 2;
num_of_pts = 16;
fn = 6;
profile_step = 0.1;

module voronoi_vase(r, h, thickness, num_of_pts, fn, profile_step) {

    profile = bezier_curve(profile_step, [
        [r, 0, 0],
        [r, 0, h / 6],
        [r + 10, 0, h / 4],
        [r + 18, 0, h * 0.4],
        [r + 10, 0, h / 2],
        [r, 0, h * 2 / 3],
        [r + 2, 0, h]
    ]);


    a_step = 360 / fn;
    sections = [
        for(pt = profile) [
            for(i = [0:fn - 1])
            let(r = pt[0], z = pt[2], a = a_step * i)        
             [r * cos(a), r * sin(a), z]
        ] 
    ];

    pts =  [for(sect = sections) each sect];
    indices = rands(0, len(pts) - 1, num_of_pts - 4);

    last_section_i = len(sections) - 1;
    half_fn = fn * 0.5;
    

        
        sxy = (r * 0.95 - thickness * 0.5) / r;
        
        difference() {
            scale([0.95, 0.95, 1]) 
                polysections(sections);
            scale([0.85, 0.85, 1]) 
                polysections(sections);
            intersection() {
                polysections(sections);
                render() 
                    voronoi3d(concat([for(i = indices) pts[i]],  [sections[0][0], sections[0][half_fn], sections[last_section_i][0], sections[last_section_i][half_fn]]));  
            }
        }

        linear_extrude(thickness) 
            polygon([for(pt = sections[0]) [pt[0], pt[1]]]); 
            
        translate([0, 0, h]) 
        linear_extrude(thickness) 
        hollow_out(thickness) 
            polygon([for(pt = sections[last_section_i]) [pt[0], pt[1]]]); 
}
voronoi_vase(r, h, thickness, num_of_pts, fn, profile_step);
   