# paths2sections

Given a list of paths, this function will return all cross-sections described by those paths. Combined with the `sweep` module, you can describe a more complex model.

You paths should be indexed count-clockwisely.

## Parameters

- `paths` : A list of paths used to describe the surface of the model.

## Examples

	use <paths2sections.scad>
	use <polyline_join.scad>
	use <sweep.scad>
	
	paths = [
	    [[5, 0, 5], [15, 10, 10], [25, 20, 5]],
	    [[-5, 0, 5], [-15, 10, 10], [-25, 20, 5]],
	    [[-5, 0, -5], [-15, 10, -10], [-25, 20, -5]],  
	    [[5, 0, -5], [15, 10, -10], [25, 20, -5]]
	];
	
	sections = paths2sections(paths);
	
	sweep(sections);
	
	#for(path = paths) {
	    polyline_join(path)
		    sphere(.25);
	}

![paths2sections](images/lib3x-paths2sections-1.JPG)

	use <bezier_curve.scad>
	use <paths2sections.scad>
	use <polyline_join.scad>
	use <sweep.scad>
	
	t_step = 0.05;
	
	paths = [
	    bezier_curve(t_step, 
	        [[1.25, 0, 5], [5, 20, 5], [16, 20, -2], [18, 20, 10], [30, 15, 8]]
	    ),
	    bezier_curve(t_step, 
	        [[-1.25, 0, 5], [0, 20, 5],  [16, 22, -2], [18, 20, 10], [30, 25, 8]]
	    ),
	    bezier_curve(t_step, 
	        [[-1.25, 0, -5], [0, 20, -5], [16, 20, 1], [18, 27, -3], [20, 27, -5]]
	    ),
	    bezier_curve(t_step, 
	        [[1.25, 0, -5], [5, 20, -5], [16, 20, 1], [18, 17.5, -3], [20, 17.5, -5]]
	    )
	];
	
	
	sections = paths2sections(paths);
	
	sweep(sections);
	
	#for(path = paths) {
	    polyline_join(path)
		    sphere(.25);
	}

![paths2sections](images/lib3x-paths2sections-2.JPG)
