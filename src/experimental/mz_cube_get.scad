// NO_WALL = 0;       
// Y_WALL = 1;    
// X_WALL = 2;    
// Y_X_WALL = 3; 
// Z_WALL = 4;
// Z_Y_WALL = 5;    
// Z_X_WALL = 6;    
// Z_Y_X_WALL = 7; 
// MASK = 8; 

function mz_cube_get(cell, query) = 
    let(
        i = search(query, [
            ["x", 0],
            ["y", 1],
            ["z", 2],
            ["t", 3]
 	    ])[0]
    )
    i != 3 ? cell[i] : ["NO_WALL", "Y_WALL", "X_WALL", "Y_X_WALL", "Z_WALL", "Z_Y_WALL", "Z_X_WALL", "Z_Y_X_WALL", "MASK"][cell[i]];