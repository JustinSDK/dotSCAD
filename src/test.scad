include <hull_polyline3d.scad>;
include <bezier_curve.scad>;
include <bezier_surface.scad>; 
include <function_grapher.scad>;

t_step = 0.05;
thickness = 0.5;

ctrl_pts = [
    [[0, 0, 20], [60, 0, -35], [90, 0, 60], [200, 0, 5]],
    [[0, 50, 30], [100, 60, -25], [120, 50, 120], [200, 50, 5]],
    [[0, 100, 0], [60, 120, 35], [90, 100, 60], [200, 100, 45]],
    [[0, 150, 0], [60, 150, -35], [90, 180, 60], [200, 150, 45]]
];

g = bezier_surface(t_step, ctrl_pts);
function_grapher(g, thickness);

demo = "YES";
// demo
if(demo == "YES") {
    width = 2;
    r = 3;

    pts = [
        for(i = [0:len(ctrl_pts) - 1]) 
            bezier_curve(t_step, ctrl_pts[i])
    ]; 

    // first bezier curve
    for(i = [0:len(ctrl_pts) - 1]) {
        color("green") union() {
            for(j = [0:len(ctrl_pts[i]) - 1]) {
                translate(ctrl_pts[i][j])
                    sphere(r = r);
            }

            for(j = [0:len(ctrl_pts[i]) - 1]) {
                hull_polyline3d( 
                    ctrl_pts[i]
                , width);
            }            
        }
        
        color("red") 
            hull_polyline3d(
                bezier_curve(t_step, ctrl_pts[i]), width
            ); 
    }

    step = len(g[0]);
    echo(step); 

    // second bezier curve
    ctrl_pts2 = [for(i = [0:len(pts) - 1]) pts[i][$t * step]];
    color("blue") union() {
        for(pt = ctrl_pts2) {
            translate(pt) 
                sphere(r = r);
        }    
        hull_polyline3d(ctrl_pts2, width);
    }

    color("black") 
        hull_polyline3d(g[$t * step], width);    
}
