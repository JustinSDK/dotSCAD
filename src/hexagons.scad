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

    function hexagons_pts(hex_datum) =
        let(
            tx = hex_datum[0][0],
            ty = hex_datum[0][1],
            n = hex_datum[1],
            offset_xs = [for(i = [0:n - 1]) i * offset_step + center_offset] 
        )
        [
            for(x = offset_xs) [x + tx, ty, 0]
        ];

    module line_hexagons(hex_datum) {
        tx = hex_datum[0][0];
        ty = hex_datum[0][1];
        n = hex_datum[1]; 

        offset_xs = [for(i = [0:n - 1]) i * offset_step + center_offset];
        for(x = offset_xs) {
            p = [x + tx, ty, 0];
            translate(p) 
                hexagon();
        }
    }
    
    upper_hex_data = levels > 1 ? [
        for(i = [1:beginning_n - levels])
            let(
                x = offset_x * i,
                y = offset_y * i,
                n = beginning_n - i
            ) [[x, y], n]
    ] : [];

    lower_hex_data = levels > 1 ? [
        for(hex_datum = upper_hex_data)
        [[hex_datum[0][0], -hex_datum[0][1]], hex_datum[1]]
    ] : [];

    total_hex_data = concat(
        [
            [[0, 0], beginning_n] // first line
        ], 
        upper_hex_data, 
        lower_hex_data
    );

    for(hex_datum = total_hex_data) {
        pts = hexagons_pts(hex_datum); 
        for(pt = pts) {
            translate(pt) 
                hexagon();
        }

        
    }
}
 
// override it to test
module test_each_hexagon(hex_r, pts) {

}