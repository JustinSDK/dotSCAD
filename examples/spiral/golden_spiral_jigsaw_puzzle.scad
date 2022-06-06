use <polyline_join.scad>
use <util/radians.scad>
use <util/lerp.scad>
use <ptf/ptf_rotate.scad>

spirals = 7;
start_n = 1;   // spiral start from 360 / spirals * start_n
degrees = 150;
thickness = 2.5;
offset_r = 0.4;
$fn = 24;

model = "ALL"; // [ALL, PLATE, SPIRAL]

golden_spiral_jigsaw_puzzle();

module golden_spiral_jigsaw_puzzle() {
    offset_rr = offset_r / 40;
    a_step = 360 / spirals;
    start = 360 / spirals * start_n;
    
    phi = (1 + sqrt(5)) / 2;
    
    function piece_polygons(start, step, to) = 
        let(
            points = [
                for(d = [start:step / 4:to])
                let(
                    theta = radians(d),
                    r = pow(phi, theta * 2 / PI)
                )
                r * [cos(d), sin(d)]
            ]
        )
        [
            for(i = 0; !is_undef(points[5 + i]); i = i + 1)
            [ 
                points[i], 
                ptf_rotate(points[4 + i], -step), 
                ptf_rotate(points[5 + i], -step),
                points[1 + i]
            ]    
        ];
        
    module interlocking_part1(poly, offset_r) {
        v = poly[1] - poly[0];
        r = norm(v) / 7;
        translate(lerp(poly[0], poly[1], 0.25))
        rotate(atan2(v.y, v.x)) 
        offset(offset_r) {
            square(sqrt(2) * [r / 2, 2 * r], center = true);
            translate([0, -r - 0.04])
                circle(r);
        }
    }

    module interlocking_part2(poly, offset_r) {
        v = poly[3] - poly[0];
        r = norm(v) / 7;
        
        translate(lerp(poly[0], poly[3], 0.25)) 
        rotate(atan2(v.y, v.x)) 
        offset(offset_r) {
            square(sqrt(2) * [r / 2, 2 * r], center = true);
            translate([0, r + 0.04])
                circle(r);
        }
    }

    linear_extrude(thickness)
    scale(40) 
    {
       
        polygons = piece_polygons(start, a_step, degrees * 2);
        
        if(model != "PLATE") {
            for(i = [0:model == "SPIRAL" ? 0 : spirals - 1]) {
                rotate(a_step * i)
                for(j = [0:len(polygons) - 5]) {
                    poly = polygons[j];
                    u_poly = polygons[j + 1];
                    r_poly = [
                        for(p = polygons[j + 4]) 
                            ptf_rotate(p, a_step * (spirals - 1))
                    ];
                    
                    // a piece with blanks
                    difference() {
                        offset(-offset_rr / 2)
                            polygon(poly);
                            
                        interlocking_part1(u_poly, offset_rr);
                        interlocking_part2(r_poly, offset_rr);                
                    }
                    
                    // tabs
                    interlocking_part1(poly, 0);
                    interlocking_part2(poly, 0);
                }
            }
        }

        if(model != "SPIRAL") {
            // plate 
            polygons2 = piece_polygons(-a_step, a_step, start + a_step * 4);
            points = [
                    for(d = [-start:a_step / 4:start])
                    let(
                        theta = radians(d),
                        r = pow(phi, theta * 2 / PI)
                    )
                    r * [cos(d), sin(d)]
                ];
                
            render() 
            difference() {
                union() {
                    for(i = [0:spirals - 1]) {
                        rotate(a_step * i) 
                        difference() {
                            
                            offset(-offset_rr / 2) 
                            union()
                            for(j = [0:len(polygons2) - 13]) {
                                poly = polygons2[j];
                                polygon(poly);
                            }
                            
                            
                            for(j = [0:len(polygons2) - 5]) {
                                poly = polygons2[j];
                                // a piece with blanks
                                difference() {
                                   //polygon(poly);
                                   u_poly = polygons2[j + 1];
                                   r_poly = [
                                        for(p = polygons2[j + 4]) 
                                            ptf_rotate(p, a_step * (spirals - 1))
                                   ];
                                   
                                   union() {
                                        if(j >= start_n * 4) {
                                            interlocking_part2(r_poly, offset_rr);   
                                        }

                                       if(j >= start_n * 4 + 3) {
                                            interlocking_part1(u_poly, offset_rr);
                                       }        
                                   }                       
                                }
                            }
                        }
                    }
                    circle(pow(phi, radians(start)  / PI) * 0.95);
                }
                
                union() 
                for(i = [0:spirals - 1]) {
                    rotate(a_step * i) 
                    polyline_join(points)
                        circle(offset_rr / 2);
                }
            }
        }
    }
}