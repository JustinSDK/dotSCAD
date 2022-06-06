# vx_polygon

Returns points that can be used to draw a voxel-style polygon.

**Since:** 2.4

## Parameters

- `points` : A list of points. Each point can be `[x, y]`. x, y must be integer.
- `filled` : Default to `false`. Set it `true` if you want a filled polygon.

## Examples

    use <voxel/vx_polygon.scad>
	use <shape_pentagram.scad>

	pentagram = [
		for(pt = shape_pentagram(15)) 
			[round(pt.x), round(pt.y)]
	];

	for(pt = vx_polygon(pentagram)) {
		translate(pt) 
		linear_extrude(1, scale = 0.5) 
			square(1, center = true);
	}

	translate([30, 0])
        for(pt = vx_polygon(pentagram, filled = true)) {
            translate(pt) 
			linear_extrude(1, scale = 0.5) 
				square(1, center = true);
        }

![vx_polygon](images/lib3x-vx_polygon-1.JPG)

