use <pie.scad>;
use <util/parse_number.scad>;
use <util/has.scad>;
use <util/rand.scad>;
use <util/choose.scad>;
use <experimental/tiles_wfc.scad>;
use <rounded_square.scad>;
use <box_extrude.scad>;

rows = 6;
columns = 6;
tileW = 10;
layerH = 1;

random_town_square(rows, columns, tileW, layerH);

module random_town_square(rows, columns, tileW, layerH) {
    sample = [
        ["F4", "CCRS1", "SS22", "CCRS0", "SS32", "F2", "SS14", "FW3", "SS04", "SS04"],
        ["F4", "SS32", "F2", "SS12", "SS32", "F2", "SS14", "FW3", "SS24", "SS24"],
        ["F4", "CCRS2", "SS02", "CCRS3", "SS32", "F2", "VCRS14", "VCRS04", "SS04", "SS04"],
        ["F4", "F4", "CCRS1", "CCRS0", "CCRS2", "VCRS02", "VCRS24", "VCRS34", "FW2", "FW2"],
        ["F4", "F4", "CCRS2", "CCRS3", "F4", "SS32", "FW1", "SS34", "FW0", "FW0"],
        ["SS22", "SS22", "SS22", "SS22", "SS22", "VCRS32", "FW1", "SS34", "SS24", "SS24"],
        ["SS14", "SS34", "VCRS14", "SS04", "SS04", "VCRS04", "VCRS12", "VCRS02", "F2", "F2"],
        ["SS14", "SS34", "VCRS24", "SS24", "SS24", "VCRS34", "VCRS22", "VCRS32", "F2", "F2"],
        ["SS14", "SS34", "VCRS14", "SS04", "SS04", "VCRS04", "VCRS12", "VCRS02", "F2", "F2"],
        ["SS14", "SS34", "SS14", "F6", "F6", "SS34", "SS12", "SS32", "VCRS14", "VCRS04"],
        ["F2", "F2", "VCRS24", "SS24", "SS24", "VCRS34", "VCRS22", "VCRS32", "VCRS24", "VCRS34"]
    ];


    generated = tiles_wfc(rows, columns, sample);

    color("Gainsboro")
    draw_tiles(generated);

    /*
    tiles = [
        ["F2", "F4"],
        ["CCRS0", "CCRS1", "CCRS2", "CCRS3"],
        ["VCRS02", "VCRS12", "VCRS22", "VCRS32", "VCRS04", "VCRS14", "VCRS24", "VCRS34"],
        ["SS02", "SS12", "SS22", "SS32", "SS04", "SS14", "SS24", "SS34"],
        ["FW0", "FW1", "FW2", "FW3"]
    ];*/

    module draw_tiles(tiles) {
        rows = len(tiles);
        columns = len(tiles[0]);
        for(y = [0:rows - 1]) {
            for(x = [0:len(tiles[y]) - 1]) {
                translate([x, rows - y - 1] * tileW) {
                    draw_tile(tiles[y][x], tileW, layerH);
                    *color("white")
                    linear_extrude(3)
                    text(tiles[y][x], size = 1.5);
                }
            }
        }
    }

    module draw_tile(tile, tileW, layerH) {
        if(has(["F2", "F4", "F6"], tile)) {
            layers = parse_number(tile[len(tile) - 1]);
            floor(tileW, layers * layerH);
        }
        else if(has(["CCRS0", "CCRS1", "CCRS2", "CCRS3"], tile)) {
            type = parse_number(tile[len(tile) - 1]);
            ccr_stairs(tileW, layerH, type);
        }
        else if(has(["VCRS02", "VCRS12", "VCRS22", "VCRS32", "VCRS04", "VCRS14", "VCRS24", "VCRS34"], tile)) {
            type = parse_number(tile[len(tile) - 2]);
            stairs = parse_number(tile[len(tile) - 1]);
            vcr_stairs(tileW, layerH, type, stairs);
        }
        else if(has(["SS02", "SS12", "SS22", "SS32", "SS04", "SS14", "SS24", "SS34"], tile)) {
            type = parse_number(tile[len(tile) - 2]);
            stairs = parse_number(tile[len(tile) - 1]);
            side_stairs(tileW, layerH, type, stairs);
        }
        else if(has(["FW0", "FW1", "FW2", "FW3"], tile)) {
            type = parse_number(tile[len(tile) - 1]);
            floor_wall(tileW, layerH, type);
        }
    }

    module base(tileW, height) {
        linear_extrude(height)
            square(tileW);
    }

    // F
    module floor(tileW, height) {
        base(tileW, height);
        
        halfW = tileW / 2;
        h = height * 2 + height * rand() * 10;
        
        if(choose([true, false, false])) {
            translate([halfW, halfW, 0])
            rotate(choose([0, 90]))
            difference() {
                translate([0, 0, h])
                mirror([0, 0, 1]) 
                if(choose([true, false])) {
                    box_extrude(h, shell_thickness  = tileW / 10)
                        rounded_square(tileW * 0.8, 1, center = true);
                }
                else {
                    linear_extrude(h)
                        circle(tileW * 0.5, $fn = choose([4, 8, 12, 48]));
                }
                
                linear_extrude(h * 0.8)
                    square([tileW * 0.2 + rand() * 0.2, tileW], center = true);
                
                rotate(90)
                linear_extrude(h * 0.8)
                    square([tileW * 0.2 + rand() * 0.2, tileW], center = true);
            }
        }
    }


    // CCRS
    module ccr_stairs(tileW, layerH, type) {
        $fn = choose([4, 8, 12, 48]);
        base(tileW, layerH * 2);
        
        halfW = tileW / 2;
        
        tx = [[0, 0], [tileW, 0], [tileW, tileW], [0, tileW]];
        translate(tx[type])
        rotate(type * 90) 
        for(i = [1:2]) {
            linear_extrude(layerH * (2 + i))
            difference() {
                square(tileW);
                pie(radius = halfW + layerH * (i - 1), angle = [0, 90]);   
            }
        }
    }

    // VCRS
    module vcr_stairs(tileW, layerH, type, stairs) {
        $fn = choose([4, 8, 12, 48]);
        base(tileW, layerH * 2);
        
        halfW = tileW / 2;
        
        tx = [[0, 0], [tileW, 0], [tileW, tileW], [0, tileW]];
        translate(tx[type])
        rotate(type * 90) 
        for(i = [1:stairs]) {   
            linear_extrude(layerH * (2 + i))
                pie(radius = halfW - layerH * (i - 1), angle = [0, 90]);     	
        }
    }

    // SS
    module side_stairs(tileW, layerH, type, stairs) {
        base(tileW, layerH * 2);
        halfW = tileW / 2;
        
        tx = [[0, 0], [tileW, 0], [tileW, tileW], [0, tileW]];
        translate(tx[type])
        rotate(type * 90)
        for(i = [1:stairs]) {
            linear_extrude(layerH * (2 + i))
                square([tileW, halfW - (i - 1) * layerH]);
        }
    }

    // FW
    module floor_wall(tileW, layerH, type) {
        base(tileW, layerH * 2);
        
        halfW = tileW / 2;
        
        tx = [[0, 0], [tileW, 0], [tileW, tileW], [0, tileW]];
        translate(tx[type])
        rotate(type * 90) {
            linear_extrude(layerH * 6)
                square([tileW, halfW]);
                
            for(i = [0:9]) {
            translate([0, tileW * 0.45])
            linear_extrude(layerH * 9)
                square([tileW, layerH]);
            }
        }
    }
}


