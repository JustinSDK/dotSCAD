use <maze/mz_theta_cells.scad>
use <voxel/vx_line.scad>
use <voxel/vx_circle.scad>
use <util/dedup.scad>
use <util/find_index.scad>
use <noise/nz_perlin2.scad>
use <voronoi/vrn2_cells_space.scad>

rows = 4;
beginning_number = 8;
height = 5;
height_smooth = 5;

devil_maze();

module devil_maze() {
    cell_width = 3;
    NO_WALL = 0;           
    INWARD_WALL = 1;      
    CCW_WALL = 2;         
    INWARD_CCW_WALL = 3;   


    function vt_from_angle(theta, r) = [r * cos(theta), r * sin(theta)];

    function line_pts(pt1, pt2, r) = 
        let(
            p1 = pt1 + [r, r],
            p2 = pt2 + [r, r]
        )
        vx_line([round(p1[0]), round(p1[1])], [round(p2[0]), round(p2[1])]);

    function circle_pts(r) = [
        for(pt = vx_circle(r)) pt + [r, r]
    ];


    r = cell_width * (rows + 1);
    maze = mz_theta_cells(rows, beginning_number);

    wall_pts = dedup(
        concat(
            [
                for(rows = maze, cell = rows)
                let(
                    ri = cell[0],
                    ci = cell[1],
                    type = cell[2],
                    thetaStep = 360 / len(maze[ri]),
                    innerR = (ri + 1) * cell_width,
                    outerR = (ri + 2) * cell_width,
                    theta1 = thetaStep * ci,
                    theta2 = thetaStep * (ci + 1),
                    innerVt1 = vt_from_angle(theta1, innerR),
                    innerVt2 = vt_from_angle(theta2, innerR),
                    outerVt2 = vt_from_angle(theta2, outerR),
                    wall1 = type == INWARD_WALL || type == INWARD_CCW_WALL ? line_pts(innerVt1, innerVt2, r) : [],
                    wall2 = type == CCW_WALL || type == INWARD_CCW_WALL ? line_pts(innerVt2, outerVt2, r) : []
                )
                each concat(wall1, wall2)
            ],
            circle_pts(r)
        )
    );

    size = [r, r] * 2;

    bitmaps = [
        for(r = [0:size.y])
        [
            for(c = [0:size.x])
            let(i = find_index(wall_pts, function(pt) pt == [c, r]))
            if(i != -1) 1 else 0
        ]
    ];

    cells = vrn2_cells_space([r, r] * 2 + [1, 1], 1);
    seed = rands(0, 1000, 1)[0];
    for(cell = cells) {
        cell_pt = cell[0];
        cell_poly = cell[1];
        
        b = bitmaps[cell_pt[1]][cell_pt[0]];
        if(cell_pt[1] > 0 && cell_pt[0] > 0 && !is_undef(b) && b == 1) {
            noise = 2 * nz_perlin2(cell_pt.x / height_smooth, cell_pt.y / height_smooth, seed) + height + (r - norm(cell_pt - [r, r])) / 2;
            color("LightGrey")
            translate(cell_pt)   
            linear_extrude(noise, scale = 0.9)
            offset(.1)
            translate(-cell_pt)  
                polygon(cell_poly); 
        }
        else {
            noise = nz_perlin2(cell_pt.x / height_smooth / 2, cell_pt.y / height_smooth / 2, seed + 1) + height / 2 + (r - norm(cell_pt - [r, r])) / 4;
            color("gray")
            translate(cell_pt)    
            linear_extrude(noise, scale = 0.75)
            translate(-cell_pt)    
                polygon(cell_poly);  
        }
    }

    color("DimGray")
    linear_extrude(height / 5)
    for(cell = cells) {
        offset(.1)
            polygon(cell[1]); 
    }
}