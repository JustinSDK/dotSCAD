# vrn2_cells_space

Create cell shapes of Voronoi in the first quadrant. You specify a space and a grid width. The center of each cell will be distributed in each grid randomly.

**Since:** 2.4

## Parameters

- `size` : 2 value array [x, y], rectangle with dimensions x and y.
- `grid_w` : The width of each grid. If it can split `size` equally, the voronoi diagram is seamless at the junction of top-bottom and left-right. 
- `seed` : Seed value for random number generator for repeatable results.

## Examples

    use <polyline_join.scad>
    use <voronoi/vrn2_cells_space.scad>

    size = [20, 20];
    grid_w = 5;
    cells = vrn2_cells_space(size, grid_w);

    for(cell = cells) {
        cell_pt = cell[0];
        cell_poly = cell[1];

        linear_extrude(1)
		polyline_join([each cell_poly, cell_poly[0]])
			circle(.5);
        
        color(rands(0, 1, 3))
        translate(cell_pt)    
        linear_extrude(2, scale = 0.8)
        translate(-cell_pt)    
            polygon(cell_poly);  
    }

![vrn2_cells_space](images/lib3x-vrn2_cells_space-1.JPG)

    use <polyline_join.scad>
    use <ptf/ptf_torus.scad>
    use <voronoi/vrn2_cells_space.scad>
    
    size = [40, 80];
    grid_w = 5;
    cells = vrn2_cells_space(size, grid_w);

    $fn = 4;

    for(cell = cells) {
        cell_poly = [for(p = cell[1]) ptf_torus(size, p, [10, 5], [360, 360])];

        polyline_join(cell_poly)
		    sphere(.5);
    }
    
![vrn2_cells_space](images/lib3x-vrn2_cells_space-2.JPG)