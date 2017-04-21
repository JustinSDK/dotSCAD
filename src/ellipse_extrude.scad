/**
* ellipse_extrude.scad
*
* Extrudes a 2D object along the path of an ellipse from 0 to 180 degrees.
* The semi-major axis is not necessary because it's eliminated while calculating.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-ellipse_extrude.html
*
**/

module ellipse_extrude(semi_minor_axis, height, center = false, convexity = 10, twist = 0, slices = 20) {
    h = height == undef ? semi_minor_axis : (
        // `semi_minor_axis` is always equal to or greater than than `height`.
        height > semi_minor_axis ? semi_minor_axis : height
    );
    angle = asin(h / semi_minor_axis) / slices; 

    module extrude(pre_z = 0, i = 1) {
        if(i <= slices) {
            f = cos(angle * i) / cos(angle * (i - 1));
            z = semi_minor_axis * sin(angle * i);

            translate([0, 0, pre_z]) 
                rotate(-twist / slices * (i - 1)) 
                    linear_extrude(
                        z - pre_z, 
                        convexity = convexity,
                        twist = twist / slices, 
                        slices = 1,
                        scale = f
                    ) children();

            extrude(z, i + 1) 
                scale(f) 
                    children();
        }
    }
    
    translate([0, 0, center == true ? -h / 2 : 0]) 
        extrude() 
            children();
}