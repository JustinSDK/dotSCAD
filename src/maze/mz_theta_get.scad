function mz_theta_get(cell, query) = 
    let(
        i = search(query, [
            ["r", 0],
            ["c", 1],
            ["t", 2]
 	    ])[0]
    )
    i != 2 ? cell[i] : ["NO_WALL", "INWARD_WALL", "CCW_WALL", "INWARD_CCW_WALL"][cell[i]];