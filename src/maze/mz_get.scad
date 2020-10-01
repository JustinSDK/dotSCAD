function mz_get(block, query) = 
    let(
        i = search(query, [
            ["x", 0],
            ["y", 1],
            ["w", 2]
 	    ])[0]
    )
    i != 2 ? block[i] : ["NO_WALL", "UPPER_WALL", "RIGHT_WALL", "UPPER_RIGHT_WALL"][block[i]];