use <maze/mz_square.scad>
use <maze/mz_tiles.scad>
use <util/find_index.scad>
use <voronoi/vrn2_cells_space.scad>
use <noise/nz_perlin2.scad>

rows = 5;
columns = 5;
height = 5;
height_smooth = 5;

giant_maze();

module giant_maze() {
    bitmaps = [
        [[0, 0, 0], [0, 0, 0], [0, 0, 0]],
        [[0, 0, 0], [0, 1, 0], [0, 1, 0]],
        [[0, 0, 0], [0, 1, 1], [0, 0, 0]],
        [[0, 0, 0], [0, 1, 1], [0, 1, 0]],
        [[0, 1, 0], [0, 1, 0], [0, 0, 0]],
        [[0, 1, 0], [0, 1, 0], [0, 1, 0]],
        [[0, 1, 0], [0, 1, 1], [0, 0, 0]],
        [[0, 1, 0], [0, 1, 1], [0, 1, 0]],
        [[0, 0, 0], [1, 1, 0], [0, 0, 0]],
        [[0, 0, 0], [1, 1, 0], [0, 1, 0]],
        [[0, 0, 0], [1, 1, 1], [0, 0, 0]],
        [[0, 0, 0], [1, 1, 1], [0, 1, 0]],
        [[0, 1, 0], [1, 1, 0], [0, 0, 0]],
        [[0, 1, 0], [1, 1, 0], [0, 1, 0]],
        [[0, 1, 0], [1, 1, 1], [0, 0, 0]],
        [[0, 1, 0], [1, 1, 1], [0, 1, 0]]
    ];

    function tiles2bits(tiles) = 
        [
            for(tile = tiles) 
            let(
                bitmap = bitmaps[tile[2]],
                sx = tile.x * 3,
                sy = tile.y * 3
            )
            each [for(y = [0:2], x = [0:2]) [[sx + x, sy + y], bitmap[y][x]]]
        ];

    bits = tiles2bits(mz_tiles(mz_square(rows, columns)));

    m = [
        for(r = [0:rows * 3 - 1]) 
        [
            for(c = [0:columns * 3 - 1])
            let(i = find_index(bits, function(elem) elem[0] == [c, r]))
            bits[i][1]
        ]
    ];

    cells = vrn2_cells_space([len(m[0]), len(m)], 1);
    seed = rands(0, 1000, 1)[0];
    for(cell = cells) {
        cell_pt = cell[0];
        cell_poly = cell[1];

        b = m[cell_pt[1]][cell_pt[0]];
        if(!is_undef(b) && b == 1) {
            noise = 2 * nz_perlin2(cell_pt.x / height_smooth, cell_pt.y / height_smooth, seed) + height;
            color("LightGrey")
            translate(cell_pt)   
            linear_extrude(noise, scale = 0.9)
            translate(-cell_pt)  
                polygon(cell_poly); 
        }
        else {
            noise = nz_perlin2(cell_pt.x / height_smooth / 2, cell_pt.y / height_smooth / 2, seed + 1) + height / 2;
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