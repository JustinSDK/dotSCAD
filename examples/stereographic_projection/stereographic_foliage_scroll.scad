use <experimental/foliage_scroll.scad>
use <polyline_join.scad>
use <stereographic_extrude.scad>

$fn = 48;

model = "BOTH"; // [BOTH, SPHERE, SHADOW]
width = 400;
height = 400;
shadow_thickness = 2;
max_spirals = 25; 
angle_step = 360 / $fn; 
min_radius = 15; 
init_radius = rands(min_radius * 2, min_radius * 3, 1)[0];

stereographic_foliage_scroll();

module stereographic_foliage_scroll() {
    module draw(spirals) {    
        for(i = [0:1]) {
            r = spirals[i][0];
            path = spirals[i][1];
            polyline_join(path)
                circle(r / 6);
        }

        for(i = [2:len(spirals) - 1]) {
            r = spirals[i][0];
            path = spirals[i][1];
            polyline_join([for(i = [1:len(path) - 1]) path[i]])
                circle(r / 6);
        }
    }

    spirals = foliage_scroll([width, height], max_spirals, init_radius, min_radius);

    if(model != "SHADOW") {
        stereographic_extrude(shadow_side_leng = width, convexity = 10, $fn = $fn * 2)
            draw(spirals);
    }

    if(model != "SPHERE") {
        color("black")
        linear_extrude(shadow_thickness)
            draw(spirals);
    }
}