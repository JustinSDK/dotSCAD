module voronoi(points, spacing = 1, r = 0, delta = 0, chamfer = false, region_type = "square") {
    xs = [for(p = points) p[0]];
    ys = [for(p = points) abs(p[1])];

    region_size = max([(max(xs) -  min(xs) / 2), (max(ys) -  min(ys)) / 2]);    
    half_region_size = 0.5 * region_size; 
    offset_leng = spacing * 0.5 + half_region_size;

    function normalize(v) = v / norm(v);
    
    module region(pt) {
        intersection_for(p = points) {
            if(pt != p) {
                v = p - pt;
                translate((pt + p) / 2 - normalize(v) * offset_leng)
                    rotate(90 + atan2(v[1], v[0])) 
                    if(region_type == "square") {
                        square(region_size, center = true);
                    }
                    else if(region_type == "circle") {
                        circle(region_size / 2);
                    }
                    
            }
        }
    }    
    
    for(p = points) {	
        if(r != 0) {        
            offset(r) region(p);
        }
        else {
            offset(delta = delta, chamfer = chamfer) region(p);
        }
    }
}