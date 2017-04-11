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

radius = 20;
levels = 3;
spacing = 2;

thickness = 20;

module hexagons(radius, spacing, levels) {
    beginning_n = 2 * levels - 1; 
    offset_x = radius * cos(30);
    offset_y = radius + radius * sin(30);

    module hexagon() {
        rotate(30) 
            offset(r = -spacing / 2) 
                circle(radius, $fn = 6);     
    }
    
    module line_hexagons(n) {
        offset = 2 * offset_x;
        for(i = [0:n - 1]) {
            offset_p = [i * offset, 0, 0];
            translate(offset_p) 
                hexagon();
        }        
    }
    
    translate([2 * (offset_x - offset_x * levels) , 0, 0]) 
        union() {
            line_hexagons(beginning_n);
          
            if(levels > 1) {
                for(i = [1:beginning_n - (levels)]) {
                    translate([offset_x * i, offset_y * i, 0]) 
                        line_hexagons(beginning_n - i);  
                    mirror([0, 1, 0]) 
                        translate([offset_x * i, offset_y * i, 0]) 
                            line_hexagons(beginning_n - i);  
                }
            }
        }
}

linear_extrude(thickness) 
    hexagons(radius, spacing, levels);
