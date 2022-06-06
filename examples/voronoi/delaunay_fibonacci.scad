use <golden_spiral.scad>
use <ptf/ptf_rotate.scad>
use <triangle/tri_delaunay.scad>
use <triangle/tri_incenter.scad>
use <util/dedup.scad>

spirals = 2; 
tri_thickness = 2;
tri_top_scale = 0.8;

from = 3;
to = 10;
point_distance = 10;

delaunay_fibonacci();

module delaunay_fibonacci() {
    points_angles = golden_spiral(
        from = from, 
        to = to, 
        point_distance = point_distance
    );
    spiral = [for(pa = points_angles) pa[0]];
    
    a_step = 360 / spirals;

    pts = dedup([
        for(a = [0:a_step:360 - a_step])
        each [for(p = spiral) ptf_rotate(p, a)]
    ]);
        
    lst_r = norm(spiral[len(spiral) - 1]) * 1.25;
    half_tri_thickness = tri_thickness * 0.5;
	
    cells = tri_delaunay(pts, ret = "TRI_SHAPES");    
    for(i = [0:len(cells) - 1]) {
        cell = cells[i];
		p = tri_incenter(cell);

		color(rands(0, 1, 3))
		translate(p)    
		linear_extrude(tri_thickness, scale = tri_top_scale)
		translate(-p)    
		intersection() {
			polygon(cell);
			circle(lst_r);
		}      

        linear_extrude(half_tri_thickness)
		intersection() {
			polygon(cell);
			circle(lst_r);
		}    		
    }
}