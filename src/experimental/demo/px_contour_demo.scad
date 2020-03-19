use <pixel/px_circle.scad>;
use <pixel/px_polyline.scad>;
use <shape_pentagram.scad>;
use <hull_polyline2d.scad>;
use <experimental/px_contour.scad>;

pts = px_circle(10, true);
for(p = pts) {
    translate(p)
        square(1, center = true);
}
#hull_polyline2d(px_contour(pts), width = .1);


pentagram = [
    for(pt = shape_pentagram(15)) 
        [round(pt[0]), round(pt[1])]
];
pts2 = px_polyline(concat(pentagram, [pentagram[0]]));
translate([30, 0]) {
    for(pt = pts2) {
        translate(pt) 
            linear_extrude(1, scale = 0.5) 
                square(1, center = true);
    }
    #hull_polyline2d(px_contour(pts2), width = .1);
}