# px_ascii

Generate 8x8 pixel points of printable ASCII characters (codes 32dec to 126dec). You can use these points to build pixel-style models. 

**Since:** 2.1

## Parameters

- `char` : A printable ASCII character.
- `center`: . If `true`, object is centered in X- and Y-axis. Otherwise, the object is placed in the positive quadrant. Defaults to `false`.
- `invert`: Inverts points of the character. Default to `false`. 

## Examples

    include <pixel/px_from.scad>;
    include <pixel/px_ascii.scad>;

    for(i = [0:94]) {
        translate([8 * (i % 10), -8 * floor(i / 10), 0]) 
            for(p = px_ascii(chr(i + 32))) {
                translate(p) 
                    linear_extrude(1, scale = 0.8) 
                        square(1);
            }
    }       

![px_ascii](images/lib2-px_ascii-1.JPG)

    include <pixel/px_from.scad>;
    include <pixel/px_ascii.scad>;

    t = "dotSCAD";
     
    for(i = [0:len(t) - 1]) {
        translate([i * 8, 0]) 
            for(pt = px_ascii(t[i], invert = true)) {
                translate(pt)
                    sphere(0.5, $fn = 24);
            }
    }

![px_ascii](images/lib2-px_ascii-2.JPG)