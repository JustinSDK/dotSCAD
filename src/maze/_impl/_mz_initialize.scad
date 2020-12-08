use <_mz_comm.scad>;

// create a starting maze for being visited later.
function _rc_maze(rows, columns) =  [
    for(y = [1:rows]) 
        for(x = [1:columns]) 
            block(
                x, y, 
                // all blocks have top and right walls
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
        for(y = [1:rows])
            for(x = [1:columns])
                mask[rows - y][x - 1] == 0 ?
                    block(
                        x, y, 						
                        4, // mask
                        true // visited
                    )
                    :
                    block(
                        x, y, 
                        // all blocks have top and right walls
                        3, 
                        // unvisited
                        false 
                    )
    ];