/**
* hexagons.scad
*
* A hexagonal structure is useful in many situations. 
* This module creates hexagons in a hexagon.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-hexagons.html
*
**/ 

module hexagons(radius, spacing, levels) {
    beginning_n = 2 * levels - 1; 
    offset_x = radius * cos(30);
    offset_y = radius + radius * sin(30);
    r_hexagon = radius - spacing / 2;
    offset_step = 2 * offset_x;
    center_offset = 2 * (offset_x - offset_x * levels);

    module hexagon() {
        rotate(30) 
            circle(r_hexagon, $fn = 6);     
    }

    function offset_xs(n) =
        [for(i = [0:n - 1]) i * offset_step + center_offset];
    
    module line_hexagons(n) {
        for(x = offset_xs(n)) {
            translate([x, 0, 0]) 
                hexagon();
        }
    }
    
    line_hexagons(beginning_n);
    
    if(levels > 1) {
        for(i = [1:beginning_n - levels]) {
            x = offset_x * i;
            y = offset_y * i;
            n = beginning_n - i;

            translate([x, y, 0]) 
                line_hexagons(n);  

            translate([x, -y, 0]) 
                line_hexagons(n);  
        }
    }
}
