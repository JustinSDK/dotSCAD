include <__private__/__angy_angz.scad>;

// slow but workable

module voronoi3d(points, spacing = 1, space_type = "cube") {
    xs = [for(p = points) p[0]];
    ys = [for(p = points) abs(p[1])];
    zs = [for(p = points) abs(p[2])];

    space_size = max([(max(xs) -  min(xs) / 2), (max(ys) -  min(ys)) / 2, (max(zs) -  min(zs)) / 2]);    
    half_space_size = 0.5 * space_size; 
    offset_leng = spacing * 0.5 + half_space_size;

    function normalize(v) = v / norm(v);
    
    module space(pt) {
        intersection_for(p = points) {
            if(pt != p) {
                v = p - pt;
                ryz = __angy_angz(p, pt);

                translate((pt + p) / 2 - normalize(v) * offset_leng)
                    rotate([0, -ryz[0], ryz[1]]) 
                    if(space_type == "cube") {
                        cube(space_size, center = true); 
                    }
                    else if(space_type == "sphere") {
                        cube(half_space_size); 
                    }
            }
        }
    }    
    
    for(p = points) {	
        space(p);
    }
}