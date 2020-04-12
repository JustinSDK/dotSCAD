use <experimental/lsystem2_collections.scad>;
use <line2d.scad>;

for(line = sierpinski_square()) {
    line2d(
        line[0],
        line[1],
        .5,
        p1Style = "CAP_ROUND", 
        p2Style =  "CAP_ROUND"
    );
}