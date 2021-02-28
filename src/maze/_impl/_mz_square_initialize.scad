use <_mz_square_comm.scad>;

// create a starting maze for being visited later.
function _rc_maze(rows, columns) =  [
    for(y = [0:rows - 1]) 
        for(x = [0:columns - 1]) 
            cell(
                x, y, 
                // all cells have top and right walls
                3, 
                // unvisited
                false 
            )
];

function _mz_mask(mask) = 
    let(
        rows = len(mask),
        columns = len(mask[0])
    )
    [
        for(y = [0:rows - 1])
            for(x = [0:columns - 1])
                mask[rows - y - 1][x] == 0 ?
                    cell(
                        x, y, 						
                        4, // mask
                        true // visited
                    )
                    :
                    cell(
                        x, y, 
                        // all cells have top and right walls
                        3, // unvisited
                        false 
                    )
    ];