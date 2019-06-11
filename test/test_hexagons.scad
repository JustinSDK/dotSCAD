include <unittest.scad>;

module test_hexagons_lv2() {
    echo("==== test_hexagons_lv2 ===="); 

    radius = 20;
    spacing = 2;
    levels = 2;
            
    include <hexagons.scad>;
    
    module test_each_hexagon(hex_r, pts_all_lines) {
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
    
    hexagons(radius, spacing, levels);
}

module test_hexagons_lv3() {
    echo("==== test_hexagons_lv3 ===="); 

    radius = 20;
    spacing = 2;
    levels = 3;
            
    include <hexagons.scad>;
    
    module test_each_hexagon(hex_r, pts_all_lines) {
        assertEqualNum(19, hex_r);
        
        expects = [
              [[-69.282, 0], [-34.641, 0], [0, 0], [34.641, 0], [69.282, 0]],
             [[-51.9615, 30], [-17.3205, 30], [17.3205, 30], [51.9615, 30]],
             [[-34.641, 60], [0, 60], [34.641, 60]],
             [[-51.9615, -30], [-17.3205, -30], [17.3205, -30], [51.9615, -30]],
             [[-34.641, -60], [0, -60], [34.641, -60]]
        ];
        
        for(i = [0:len(pts_all_lines) - 1]) {
            assertEqualPoints(
                expects[i], 
                pts_all_lines[i]
            );
        }
        
    } 
    
    hexagons(radius, spacing, levels);
}

test_hexagons_lv2();
test_hexagons_lv3();
