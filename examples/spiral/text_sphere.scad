use <sphere_spiral.scad>
use <sphere_spiral_extrude.scad>

tx = "3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679821480865132823066470938446095505822317253594081284811174502841027019385211055596446229489549303819644288109756659334461284756482337867831652712019091456485669234603486104543266482133936072602491412737245870066063155881748815209209628292540917153643678925903600113305305488204665213841469519415116094330572703657595919530921861173819326117931051185480744623799627495673518857527248912279381830119491298336733624406566430860213949463952247371907021798609437027705392171762931767523846748184676694051320005681271452635608277857713427577896091736371787214684409012249534301465495853710507922796892589235420199561121290219608640344181598136297747713099605187072113499999983729780499510597317328160963185950244594553469083026425223082533446850352619311881710100031378387528865875332083814206171776691473035982534904287554687311595628638823537875937519577818577805321712268066130019278766111959092164201989";
font_name = "Liberation Sans:style=Bold Italic";
thickness = 2;

module text_sphere(tx, font_name, thickness) {
    $fn = 24;
    radius = 40;
    za_step = 360 / $fn; 
    z_circles = 48;
    begin_angle = 720;
    end_angle = 630;

    half_thickness = thickness / 2;
    
    points_angles = sphere_spiral(
        radius = radius, 
        za_step = za_step, 
        z_circles = z_circles, 
        begin_angle = begin_angle,
        end_angle = end_angle
    );

    rotate(-180 / $fn) 
    sphere_spiral_extrude(
        [
            [thickness, half_thickness],
            [-half_thickness, half_thickness], 
            [-half_thickness, -half_thickness],
            [thickness, -half_thickness]
        ],
        radius = radius, 
        za_step = za_step, 
        z_circles = z_circles, 
        begin_angle = begin_angle,
        end_angle = end_angle
    );


    for(i = [0:len(points_angles) - 1]) {
        pa = points_angles[i];
        translate(pa[0]) 
        rotate(pa[1] + [0, 8, 0])
        rotate([90, 0, 90]) 
        linear_extrude(half_thickness) 
        translate([0, -10, 0]) 
            text(tx[i], font = font_name, halign = "center");
    }
    
    translate([0, 0, -radius]) 
    linear_extrude(thickness * 2.5) 
        circle(radius / 2);
}

 text_sphere(tx, font_name, thickness);