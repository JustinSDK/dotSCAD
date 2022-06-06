use <polyline_join.scad>

length = 100;
diff_scale = 0.125;
diameter = 2;
n = 30;
$fn = 6;

module square_pursuit_3d(length, diff_scale, diameter, n) {
    function inter_p(p1, p2, leng, d) = 
        let(
            vp = p2 - p1,
            u = vp / leng
        )
        p1 + u * d;

    module _square_pursuit_3d(pts, diff_scale, diameter, n) {
        if(n != 0) {
            vp = pts[1] - pts[0];
            leng = norm(vp);
            d = leng * diff_scale;
            
            npts = [for(i = [0:3]) inter_p(pts[i], pts[(i + 1) % 4], leng, d)];
            
            polyline_join([each npts, npts[3], npts[0]])
			    sphere(d = diameter);
            
            _square_pursuit_3d(npts, diff_scale, diameter, n - 1);
        }
    }

    half_length = length / 2;
    pts = [
        [0, 0, 0],
        [length, 0, 0],
        [half_length, half_length, sqrt(2) * half_length],
        [0, length, 0]
    ];    
    
    polyline_join([each pts, pts[3], pts[0]])
	    sphere(d = diameter);
    
    _square_pursuit_3d(pts, diff_scale, diameter, n - 1);
}

square_pursuit_3d(length, diff_scale, diameter, n);