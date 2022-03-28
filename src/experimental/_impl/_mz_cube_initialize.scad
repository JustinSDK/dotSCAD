use <_mz_cube_comm.scad>;

// create a starting maze for being visited later.
function _lrc_maze(layers, rows, columns) =  
    [
        for(z = [0:layers - 1])
        [
            for(y = [0:rows - 1]) 
            [
                for(x = [0:columns - 1])
                cell(
                    x, y, z,
                    // all cells have up/top/right walls
                    7, 
                    // unvisited
                    false 
                )
            ]
        ]
    ];

function _mz_mask(mask) = 
    let(
        layers = len(mask),
        rows = len(mask[0]),
        columns = len(mask[0][1])
    )
    [
        for(z = [0:layers - 1]) [
            for(y = [0:rows - 1]) [
                for(x = [0:columns - 1])
                mask[layers - z - 1][rows - y - 1][x] == 0 ?
                    cell(
                        x, y, z,		
                        8,   // mask
                        true // visited
                    )
                    :
                    cell(
                        x, y, z,
                        // all cells have up/top/right walls
                        7, // unvisited
                        false 
                    )
            ]
        ]
    ];