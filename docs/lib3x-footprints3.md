# footprints3

A 3D verion of [footprint2](https://openhome.cc/eGossip/OpenSCAD/lib3x-footprints2.html). 

**Since:** 2.4

## Parameters

- `cmds` : A list of `["forward", length]`s, `["turn", angle]`s, `["roll", angle]`s and `["pitch", angle]`s. 
- `start` : Set the start point of the turtle. Default to `[0, 0, 0]`.

## Examples
	    
	use <polyline_join.scad>
	use <turtle/footprints3.scad>
	
	function xy_arc_cmds(radius, angle, steps) = 
		let(
			fa = angle / steps,
			ta = fa / 2,
			leng = sin(ta) * radius * 2
		)
        [
            ["turn", ta],
            each [
				for(i = [0:steps - 2])
				each [["forward", leng], ["turn", fa]]
			],
            ["forward", leng], 
            ["turn", ta]
        ];

	poly = footprints3(
        [
            ["forward", 10],
            ["turn", 90],
            ["forward", 10],
            each xy_arc_cmds(5, 180, 12),
            ["pitch", 90],
            ["forward", 10],
            ["roll", 90],
            each xy_arc_cmds(5, 180, 12),
            ["forward", 10]
        ]
	);

	polyline_join(poly)
	    sphere(.5);

![footprints3](images/lib3x-footprints3-1.JPG)

