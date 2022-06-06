use <unittest.scad>
include <hexagons.scad>

module test_each_hexagon(hex_r, pts_all_lines) {
    // ==== test_hexagons_lv2 ====
    assertEqualNum(19, hex_r);
    
    expects = [
            [[-34.641, 0], [0, 0], [34.641, 0]],
            [[-17.3205, 30], [17.3205, 30]],
            [[-17.3205, -30], [17.3205, -30]]
    ];
    
    for(i = [0:len(pts_all_lines) - 1]) {
        assertEqualPoints(
            expects[i], 
            pts_all_lines[i]
        );
    }
} 

module test_hexagons_lv2() {
    echo("==== test_hexagons_lv2 ===="); 

    radius = 20;
    spacing = 2;
    levels = 2;
            
    hexagons(radius, spacing, levels);
}

test_hexagons_lv2();