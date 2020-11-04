# vrn2_cells_from

Create cell shapes of Voronoi from a list of points. 

**Since:** 2.4

## Parameters

- `points` : Points for each cell. 

## Examples

    use <hull_polyline2d.scad>;
    use <voronoi/vrn2_cells_from.scad>;

    xs1 = rands(-20, 20, 15);
    ys1 = rands(-20, 20, 15);
    points = [for(i = [0:len(xs1) - 1]) [xs1[i], ys1[i]]];

    cells = vrn2_cells_from(points);
    for(i = [0:len(points) - 1]) {
        pt = points[i];
        cell = cells[i];
        
        linear_extrude(1)
            hull_polyline2d(concat(cell, [cell[0]]), width = 1);
        
        color(rands(0, 1, 3))
        translate(pt)    
        linear_extrude(2, scale = 0.8)
        translate(-pt)    
            polygon(cell);
    }

![vrn2_cells_from](images/lib2x-vrn2_cells_from-1.JPG)
