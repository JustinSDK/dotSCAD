use <helix.scad>
use <helix_extrude.scad>

tx = "3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679821480865132823066470938446095505822317253594081284811174502841027019385211055596446229489549303819644288109756659334461284756482337867831652712019091456485669234603486104543266482133936072602491412737245870066063155881748815209209628292540917153643678925903600113305305488204665213841469519415116094330572703657595919530921861173819326117931051185480744623799627495673518857527248912279381830119491298336733624406566430860213949463952247371907021798609437027705392171762931767523846748184676694051320005681271452635608277857713427577896091736371787214684409012249534301465495853710507922796892589235420199561121290219608640344181598136297747713099605187072113499999983729780499510597317328160963185950244594553469083026425223082533446850352619311881710100031378387528865875332083814206171776691473035982534904287554687311595628638823537875937519577818577805321712268066130019278766111959092164201989";
font_name = "Liberation Sans:style=Bold Italic";
radius = 60;
height = 150;
thickness = 2;

module text_tower(tx, font_name, radius, height, thickness) {

    font_size = 2 * PI * radius / $fn;
    angle_step = 360 / $fn;
    half_angle_step = angle_step / 2;
    half_thickness = thickness / 2;

    module body() {
        points = helix(
            radius = radius, 
            levels = height / font_size, 
            level_dist = font_size, 
            vt_dir = "SPI_DOWN"
        );
        for(i = [0:len(points) - 1]) {
            translate(points[i])
            rotate([90, 0, 90 + angle_step * i]) 
            linear_extrude(thickness, center = true) 
                text(
                    tx[i], 
                    font = font_name, 
                    size = font_size, 
                    halign = "center"
                );
        }

        rotate(-half_angle_step) 
            helix_extrude(
                [
                    [thickness, half_thickness],
                    [-thickness, half_thickness], 
                    [-thickness, -half_thickness],
                    [thickness, -half_thickness]
                ], 
                radius = radius, 
                levels = height / font_size + 1, 
                level_dist = font_size,
                vt_dir = "SPI_DOWN"
            );
    }

    translate([0, 0, -font_size - half_thickness]) 
        body();

    rotate(-half_angle_step) 
    translate([0, 0, -font_size - thickness]) 
        cylinder(h = font_size, r = radius + thickness);
}

text_tower(tx, font_name, radius, height, thickness, $fn = 24);