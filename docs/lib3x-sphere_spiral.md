# sphere_spiral

Creates all points and angles on the path of a spiral around a sphere. It returns a vector of `[[x, y, z], [ax, ay, az]]`. `[x, y, z]` is actually obtained from rotating `[radius, 0, 0]` by `[ax, ay, az]`.

## Parameters

- `radius` : The radius of the sphere.
- `za_step` : The spiral rotates around the z axis. When the rotated angle increases `za_step`, a point will be calculated.
- `z_circles` : The spiral rotates around the z axis. This parameter determines how many circles it will rotate from the top to the end. It defaults to 1.
- `begin_angle` : The default value is 0 which means begins from the north pole of the sphere. See examples below.
- `end_angle` : The default value is 0 which means begins from the sourth pole of the sphere. See examples below.
- `vt_dir` : `"SPI_DOWN"` for spiraling down. `"SPI_UP"` for spiraling up. The default value is `"SPI_DOWN"`.
- `rt_dir` : `"CT_CLK"` for counterclockwise. `"CLK"` for clockwise. The default value is `"CT_CLK"`.

## Examples
    
	use <polyline_join.scad>
	use <sphere_spiral.scad>
	
	points_angles = sphere_spiral(
	    radius = 40, 
	    za_step = 10, 
	    z_circles = 20, 
	    begin_angle = 90, 
	    end_angle = 90
	);
	
	polyline_join([for(pa = points_angles) pa[0]])
	    sphere(.5);
	
	%sphere(40);

![sphere_spiral](images/lib3x-sphere_spiral-1.JPG)

![sphere_spiral](images/lib3x-sphere_spiral-2.JPG)

![sphere_spiral](images/lib3x-sphere_spiral-3.JPG)

	use <sphere_spiral.scad>

	points_angles = sphere_spiral(
	    radius = 40, 
	    za_step = 20, 
	    z_circles = 40, 
	    begin_angle = 900
	);
	
	for(pa = points_angles) {
	    translate(pa[0]) rotate(pa[1])
		rotate([90, 0, 90]) linear_extrude(1) 
			text("A", valign = "center", halign = "center");
	}
	
	%sphere(40);

![sphere_spiral](images/lib3x-sphere_spiral-5.JPG)

	use <polyline_join.scad>
	use <sphere_spiral.scad>
	
	points_angles = sphere_spiral(
	    radius = 40, 
	    za_step = 5
	);
	
	for(a = [0:30:360]) {
	    rotate(a) 
		polyline_join([for(pa = points_angles) pa[0]])
			sphere(1);
	}

![sphere_spiral](images/lib3x-sphere_spiral-6.JPG)
