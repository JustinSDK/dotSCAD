use <_mz_cube_comm.scad>

include <_mz_cube_constants.scad>

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
                    Z_Y_X_WALL, 
                    // unvisited
                    UNVISITED 
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
        for(z = [0:layers - 1])
        let(maze_z = mask[layers - z - 1]) 
        [
            for(y = [0:rows - 1]) 
            let(maze_zy = maze_z[rows - y - 1])
            [
                for(x = [0:columns - 1])
                maze_zy[x] == 0 ?
                    cell(
                        x, y, z,		
                        MASK,  
                        VISITED // visited
                    )
                    :
                    cell(
                        x, y, z,
                        Z_Y_X_WALL,
                        UNVISITED // unvisited
                    )
            ]
        ]
    ];