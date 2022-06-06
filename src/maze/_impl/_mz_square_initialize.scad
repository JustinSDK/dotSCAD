use <_mz_square_comm.scad>

include <_mz_square_cell_constants.scad>

// create a starting maze for being visited later.
function _rc_maze(rows, columns) =  [
    for(y = [0:rows - 1]) 
    [
        for(x = [0:columns - 1])
        cell(
            x, y, 
            // all cells have top and right walls
            TOP_RIGHT_WALL, 
            UNVISITED 
        )
    ]
];

function _mz_mask(mask) = 
    let(
        rows = len(mask),
        columns = len(mask[0])
    )
    [
        for(y = [0:rows - 1])
        let(mask_y = mask[rows - y - 1])
        [
            for(x = [0:columns - 1])
            mask_y[x] == 0 ?
                cell(
                    x, y, 						
                    MASK, 
                    VISITED 
                )
                :
                cell(
                    x, y, 
                    TOP_RIGHT_WALL, 
                    UNVISITED 
                )
        ]
    ];