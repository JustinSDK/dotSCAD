use <stereographic_extrude.scad>

rows = 8;
line_width = 15;
block_width = 50;

module grid(rows, block_width, line_width) {
    half_side_length = (block_width * rows + line_width) / 2;
    
    translate([-half_side_length, -half_side_length]) 
        for(i = [0:rows]) {
            translate([0, i * block_width, 0]) 
                square([block_width * rows, line_width]);
                
            translate([i * block_width, 0, 0]) 
                square([line_width, block_width * rows + line_width]);
        }
}
 
stereographic_extrude(block_width * rows + line_width, $fn = 48, convexity = 15) 
    grid(rows, block_width, line_width);
  
if($preview) {
     color("black") grid(rows, block_width, line_width);
 }