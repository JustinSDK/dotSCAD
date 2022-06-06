use <rounded_square.scad>
use <select.scad>
use <shear.scad>
use <shape_trapezium.scad>
use <arc.scad>
use <util/rand.scad>

module city_tile(i, tile_width) {
    select(i) {
        tile00();
        tile01();
        tile02();
        tile03();
        tile04();
        tile05();
        tile06();
        tile07();
        tile08();
        tile09();
        tile10();
        tile11();
        tile12();
        tile13();
        tile14();
        tile15();
    }

    // tiles, quick and dirty code
    module base() {
        tileW = 30;
        h = 3;
        linear_extrude(h)
            square(tileW, center = true);

        linear_extrude(h + .2)
            rounded_square(tileW - 4, corner_r = 1, center = true, $fn = 24);
    }

    module pillar() {
        tileW = 30;
        roadW = 25 / 3;
        halfRW = roadW / 2;
        halfTW = tileW / 2;
        
        translate([0, halfTW / 1.6, 2.25])
        linear_extrude(10)
            rounded_square(halfRW / 1.25, corner_r = .8, center = true, $fn = 6);
                
        translate([0, halfTW / 1.6, 11.56])
        rotate([90, 0, 0])
        linear_extrude(halfRW / 1.225, center = true)
            polygon(
                shape_trapezium([halfRW / 1.25, roadW * 0.9], 
                h = halfRW / 3,
                corner_r = 0)
            );
    }

    module long_buildings(h) {
        module side_building0() {
            linear_extrude(rand(10, h))
                rounded_square([6, 23], corner_r = 1, center = true, $fn = rand(4, 12));
        }

        module side_building1() {
            linear_extrude(rand(10, h))
                rounded_square([6, 15], corner_r = 1, center = true, $fn = rand(4, 12));
        }

        module side_building2() {
            translate([0, 5])
            linear_extrude(rand(10, h))
                rounded_square([6, 12], corner_r = 1, center = true, $fn = rand(4, 12));

            translate([0, -7])
            linear_extrude(rand(10, h))
                rounded_square([6, 10], corner_r = 1, center = true, $fn = rand(4, 12));
        }

        module side_building3() {
            translate([0, -6])
            linear_extrude(rand(10, h))
                rounded_square([6, 12], corner_r = 1, center = true, $fn = rand(4, 12));

            translate([0, 6.5])
            linear_extrude(rand(10, h))
                rounded_square([6, 10], corner_r = 1, center = true, $fn = rand(4, 12));
        }
        
        b = round(rand(0, 3));
        if(b == 0) {
            side_building0();
        }
        else if(b == 1) {
            side_building1();
        }
        else if(b == 2) {
            side_building2();
        }
        else if(b == 3) {
            side_building3();
        }
    }

    module short_buildings(h) {
        linear_extrude(rand(4, h))
            rounded_square(rand(3, 8), corner_r = .5, center = true, $fn = rand(4, 12));

        linear_extrude(rand(5, h))
            rounded_square(rand(3, 8), corner_r = .5, center = true, $fn = rand(4, 12));

        linear_extrude(rand(5, h))
            rounded_square(rand(3, 8), corner_r = .5, center = true, $fn = rand(4, 12)); 
    }

    module tile00() {
        base();

        f1 = rand(12.5, 25);
        linear_extrude(f1)
            rounded_square(rand(20, 22), corner_r = rand(0.1, 2), center = true);

        f2 = rand(f1, 40);
        linear_extrude(f2)
            rounded_square(rand(17, 19), corner_r = rand(0.1, 2), center = true);
            
        f3 = rand(f2, 50);
        linear_extrude(f3)
            rounded_square(rand(10, 14), corner_r = rand(0.1, 2), center = true);
            
        linear_extrude(f3 + 2, scale = rand(0.1, 0.5))
            square(20, center = true);
    }

    module tile01() {
        tileW = 30;
        roadW = 25 / 3;
        roadL = tileW * 0.75;
        halfRW = roadW / 2;
        halfTW = tileW / 2;
        
        module road() {
            translate([0, -halfTW / 2, 1])
            shear(sz = [0, .5]){
                translate([-halfRW, 0])
                linear_extrude(2)
                    square([roadW, roadL]);
                
                linear_extrude(3)
                difference() {
                    translate([-halfRW, 0])	
                        square([roadW, roadL]);
                        
                    translate([-(roadW - 2) / 2, 0])	
                        square([roadW - 2, roadL]);
                }
            }
            

            translate([0, 0, -1.2])
            scale([1, 1, 0.9])
                pillar();			
        }
        
        module station() {
            translate([0, -halfRW]) 
            difference() {
                linear_extrude(15, scale = rand(0.8, 1))
                    rounded_square(roadW * 1.75, corner_r = rand(0.1, 2), center = true, $fn = round(rand(4, 24)));
                
                translate([0, halfRW])
                linear_extrude(12.5)
                    square([roadW * 1.1, roadW * 2], center = true);
            }
            
            // top
            topL = roadW * 1.75 * 0.8 ;
            translate([0, -halfRW, 15])
            linear_extrude(rand(1, 4), scale = rand(0.1, 1))
                rounded_square(topL, corner_r = rand(0.1, topL / 2), center = true, $fn = round(rand(4, 6)));
        }
        
        base();
        color("LightYellow")
		road();
        station();
        
        translate([8.5, 0]) {
            long_buildings(15);
            short_buildings(20);
        }
            
        translate([-8.5, 0]) {
            long_buildings(15);
            short_buildings(20);
        }
    }

    module tile02() {
        rotate(-90)
        tile01();
    }

    module tile04() {
        rotate(-180)
        tile01();
    }

    module tile08() {
        rotate(90)
        tile01();
    }

    module tile03() {
        tileW = 30;
        roadW = 25 / 3;
        roadL = tileW * 0.75;
        halfRW = roadW / 2;
        halfTW = tileW / 2;
        
        module road() {
            translate([halfTW, halfTW, halfTW * 0.5 + 4.75]) {
                linear_extrude(2)
                    arc(radius = halfTW, angle = [180, 270], width = roadW, $fn = 64);
                    
                linear_extrude(3)
                    difference() {
                        arc(radius = halfTW, angle = [180, 270], width = roadW, $fn = 64);
                        arc(radius = halfTW, angle = [180, 270], width = roadW - 2, $fn = 64);
                    }
            }			
        }
        
        base();
		color("LightYellow")
        road();	
        translate([1, 0, 0])
            pillar();	
        translate([0, 1, 0])
        rotate(-90)
            pillar();
            
        translate([-8.5, 0]) 
            long_buildings(21);

        rotate(90)
        translate([-8.5, 0]) 
            long_buildings(21);
        
        translate([8.5, 8.5]) 
            short_buildings(12);
    }

    module tile06() {
        rotate(-90)
        tile03();
    }

    module tile09() {
        rotate(90)
        tile03();
    }

    module tile12() {
        rotate(-180)
        tile03();
    }

    module tile05() {
        tileW = 30;
        roadW = 25 / 3;
        roadL = tileW;
        halfRW = roadW / 2;
        halfTW = tileW / 2;
        
        module road() {
            translate([0, 0, halfTW * 0.5 + 4.75]) {
                linear_extrude(2)
                    square([roadW, roadL], center = true);
                
                linear_extrude(3)
                difference() {
                    square([roadW, roadL], center = true);
                    square([roadW - 2, roadL], center = true);
                }
            }
        }
        
        base();
		color("LightYellow")
        road();
        pillar();
        rotate(180)
            pillar();
        translate([0, -halfTW / 1.6, 0])
            pillar();

        translate([8.5, 0]) {
            long_buildings(21);
            short_buildings(21);
        }
        
        translate([-8.5, 0]) {
            long_buildings(21);
            short_buildings(21);
        }
    }

    module tile10() {
        rotate(90)
        tile05();
    }

    module tile15() {
        module tile() {
            tileW = 30;
            roadW = 25 / 3;
            roadL = tileW * 0.75;
            halfRW = roadW / 2;
            halfTW = tileW / 2;
            
            module road() {
                translate([halfTW, halfTW, halfTW * 0.5 + 4.75]) {
                    linear_extrude(2)
                        arc(radius = halfTW, angle = [180, 270], width = roadW, $fn = 64);
                        
                    linear_extrude(3)
                        difference() {
                            arc(radius = halfTW, angle = [180, 270], width = roadW, $fn = 64);
                            arc(radius = halfTW, angle = [180, 270], width = roadW - 2, $fn = 64);
                        }
                }				
            }
            
            base();
			color("LightYellow")
            road();	
            translate([1, 0, 0])
                pillar();	
            translate([0, 1, 0])
            rotate(-90)
                pillar();
                
            translate([8.5, 8.5]) 
                short_buildings(12);
                
            translate([8.5, -8.5]) 
                short_buildings(12);
        }

        rotate([0, 90][round(rand(0, 1))]) {
            tile();
            rotate(180)
                tile();
        }
    }

    module tile07() {
        tileW = 30;
        roadW = 25 / 3;
        roadL = tileW * 0.75;
        halfRW = roadW / 2;
        halfTW = tileW / 2;
        
        module road() {
            module road_shape() {
                translate([halfTW, halfTW]) 
                    arc(radius = halfTW, angle = [135, 295], width = roadW, $fn = 64);
                mirror([0, 1, 0])
                translate([halfTW, halfTW]) 
                    arc(radius = halfTW, angle = [135, 295], width = roadW, $fn = 64);
            }
            
            translate([0, 0, halfTW * 0.5 + 4.75]) {
                linear_extrude(2)
                intersection() {
                    square(tileW, center = true);
                    road_shape();
                }
                
                linear_extrude(3)
                intersection() {
                    square(tileW, center = true);
                    difference() {
                        road_shape();
                        offset(-1) 
                            road_shape();
                    }
                }
            }
        }
        
        base();
		color("LightYellow")
        road();	

        translate([1, 0, 0])
            pillar();	
        translate([0, 1, 0])
        rotate(-90)
            pillar();
        mirror([0, 1, 0])
        translate([0, 1, 0])
            pillar();
            
        translate([-8.5, 0]) {
            long_buildings(21);
            short_buildings(21);
        }
        
        translate([8.5, 8.5]) 
            short_buildings(12);

        translate([8.5, -8.5]) 
            short_buildings(12);
    }

    module tile11() {
        rotate(90)
            tile07();
    }

    module tile13() {
        rotate(180)
            tile07();
    }

    module tile14() {
        rotate(-90)
            tile07();
    }
}