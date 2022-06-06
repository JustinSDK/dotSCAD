use <bauer_spiral.scad>

txt = "3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679821480865132823066470938446095505822317253594081284811174502841027019385211055596446229489549303819644288109756659334461284756482337867831652712019091456485669234603486104543266482133936072602491412737245870066063155881748815209209628292540917153643678925903600113305305488204665213841469519415116094330572703657595919530921861173819326117931051185480744623799627495673518857527248912279381830119491298336733624406566430860213949463952247371907021798609437027705392171762931767523846748184676694051";

radius = 20;
font_name = "Liberation Sans:style=Bold";
font_size = 2.5;
txt_extrude = radius * 0.125;
txt_scale = 1.15;
ball = true;
$fn = 48;

bauer_text_sphere(radius, font_name, font_size, txt_extrude, txt_scale, ball);

module bauer_text_sphere(radius, font_name, font_size, txt_extrude, txt_scale, ball) {
    n = len(txt);
    pts = bauer_spiral(n, radius);

    if(ball) {
        sphere(radius * 0.9);
    }
    /* 
        Based on Bauer's spiral:
          Bauer R. Distribution of points on a sphere with application to star catalogs. Journal of Guidance, Control, and Dynamics. 2000;23(1):130–137
    */
    for(i = [0:n - 1]) {
        x = pts[i].x;
        y = pts[i].y;
        z = pts[i].z;
        ya = atan2(z, norm([x, y]));
        za = atan2(y, x);

        render() 
        translate(pts[i])
        rotate([0, -ya, za])
        rotate([90, 0, -90])
        linear_extrude(txt_extrude, scale = txt_scale)
        mirror([-1, 0, 0])
            text(txt[i], size = font_size, font = font_name, valign = "center", halign = "center");
    }
}

