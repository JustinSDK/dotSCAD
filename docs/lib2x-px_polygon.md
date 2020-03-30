# px_polygon

Returns points that can be used to draw a pixel-style polygon.

**Since:** 2.0

## Parameters

- `points` : A list of points. Each point can be `[x, y]`. x, y must be integer.
- `filled` : Default to `false`. Set it `true` if you want a filled polygon.

## Examples

    use <pixel/px_polygon.scad>;
	use <shape_pentagram.scad>;

	pentagram = [
		for(pt = shape_pentagram(15)) 
			[round(pt[0]), round(pt[1])]
	];

	for(pt = px_polygon(pentagram)) {
		translate(pt) 
			linear_extrude(1, scale = 0.5) 
			    square(1, center = true);
	}

	translate([30, 0])
        for(pt = px_polygon(pentagram, filled = true)) {
            translate(pt) 
                linear_extrude(1, scale = 0.5) 
                    square(1, center = true);
        }

![px_polygon](images/lib2x-px_polygon-1.JPG)

