/**
* taken from http://www.thingiverse.com/thing:58478
* author Wouter Robers
**/
module rounded_cylinder(r1=10,r2=10,h=10,b=2)
{translate([0,0,-h/2]) hull(){rotate_extrude() translate([r1-b,b,0]) circle(r = b); rotate_extrude() translate([r2-b, h-b, 0]) circle(r = b);}}
