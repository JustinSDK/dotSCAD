use <triangle/tri_delaunay.scad>
use <shape_taiwan.scad>
use <in_shape.scad>

voronoi_taiwan();

module voronoi_taiwan() {
    taiwan = shape_taiwan(120, distance = 1); 

    n = 40;
    xs = rands(-15, 15, n);
    ys = rands(-30, 40, n);
    pts = [
        for(i = [0:n - 1]) 
            let(p = [xs[i], ys[i]]) 
            if(in_shape(taiwan, p, true))
            p
        ]; 
        
    all = concat(taiwan, pts);
        
    cells = tri_delaunay(all, ret = "VORONOI_CELLS");
    for(i = [0:len(cells) - 1]) {
        color(rands(0, 1, 3))
        translate(all[i])    
        linear_extrude(2, scale = 0.8)
        translate(-all[i])
        intersection() {
            polygon(taiwan);
            polygon(cells[i]);  
        }
    }

    color("black")
    linear_extrude(.75)
    offset(1) 
        polygon(taiwan);

}