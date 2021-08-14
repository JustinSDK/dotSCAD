# rail_extruded_sections

Given a rail with the first point at the outline of a shape. This function uses the rail to extrude the shape and returns all sections in the reversed order of the rail. Combined with the `sweep` module, you can create rail extrusion. 

In order to control extrusion easily, I suggest using `[x, 0, 0]` as the first point and keeping y = 0 while building the rail.

**Since:** 3.2

## Parameters

- `shape_pts` : A list of points represent a shape.
- `rail` : A list of points represent the edge path.

## Examples

	use <hull_polyline3d.scad>;
	use <shape_taiwan.scad>;
	use <rail_extruded_sections.scad>;
	use <sweep.scad>;

	taiwan = shape_taiwan(100);
	fst_pt = [13, 0, 0];

	rail = [
		fst_pt,
		fst_pt + [0, 0, 10],
		fst_pt + [10, 0, 20],
		fst_pt + [8, 0, 30],
		fst_pt + [12, 0, 40],
		fst_pt + [0, 0, 50],
		fst_pt + [0, 0, 60]
	];

	#hull_polyline3d(rail);
	sweep(rail_extruded_sections(taiwan, rail));

![rail_extruded_sections](images/lib3x-rail_extruded_sections-1.JPG)

	use <hull_polyline3d.scad>;
	use <shape_taiwan.scad>;
	use <rail_extruded_sections.scad>;
	use <sweep.scad>;
	use <bezier_curve.scad>;


	taiwan = shape_taiwan(100);
	fst_pt = [13, 0, 0];

	rail = bezier_curve(0.05, [
		fst_pt,
		fst_pt + [0, 0, 10],
		fst_pt + [10, 0, 20],
		fst_pt + [8, 0, 30],
		fst_pt + [12, 0, 40],
		fst_pt + [0, 0, 50],
		fst_pt + [0, 0, 60]
	]);

	#hull_polyline3d(rail);
	sweep(rail_extruded_sections(taiwan, rail));

![rail_extruded_sections](images/lib3x-rail_extruded_sections-2.JPG)

	use <shape_taiwan.scad>;
	use <rail_extruded_sections.scad>;
	use <sweep.scad>;
	use <bezier_curve.scad>;
	use <ptf/ptf_rotate.scad>;

	taiwan = shape_taiwan(100);
	fst_pt = [13, 0, 0];

	rail = bezier_curve(0.05, [
		fst_pt,
		fst_pt + [0, 0, 10],
		fst_pt + [10, 0, 20],
		fst_pt + [8, 0, 30],
		fst_pt + [12, 0, 40],
		fst_pt + [0, 0, 50],
		fst_pt + [0, 0, 60]
	]);

	leng = len(rail);
	twist = -90;
	twist_step = twist / leng;
	sections = rail_extruded_sections(taiwan, rail);

	rotated_sections = [
		for(i = [0:leng - 1]) 
		[
			for(p = sections[i]) 
				ptf_rotate(p, twist_step * i)        
		]
	];

	sweep(rotated_sections);

![rail_extruded_sections](images/lib3x-rail_extruded_sections-3.JPG)	

	use <hull_polyline3d.scad>;
	use <shape_taiwan.scad>;
	use <rail_extruded_sections.scad>;
	use <sweep.scad>;
    use <ptf/ptf_rotate.scad>;

	taiwan = shape_taiwan(100);

    /* 
	    You can use any point as the first point of the edge path.
		Just remember that your edge path radiates from the origin.
	*/
	fst_pt = [taiwan[0][0], taiwan[0][1], 0];//[13, 0, 0];
    a = atan2(fst_pt[1], fst_pt[0]);
	rail = [
		fst_pt,
		fst_pt + ptf_rotate([0, 0, 10], a),
		fst_pt + ptf_rotate([10, 0, 20], a),
		fst_pt + ptf_rotate([8, 0, 30], a),
		fst_pt + ptf_rotate([10, 0, 40], a),
		fst_pt + ptf_rotate([0, 0, 50], a),
		fst_pt + ptf_rotate([0, 0, 60], a)
	];

	#hull_polyline3d(rail);
	sweep(rail_extruded_sections(taiwan, rail));

![rail_extruded_sections](images/lib3x-rail_extruded_sections-4.JPG)