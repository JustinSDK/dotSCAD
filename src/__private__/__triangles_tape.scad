function __triangles_tape(shape_pts) =
    let(leng = len(shape_pts))
    concat(
        [
            for(i = [0:leng / 2 - 2]) 
                [i, leng - i - 1, leng - i - 2]
        ],
        [
            for(i = [0:leng / 2 - 2])
                [i, i + 1, leng - i - 2]
        ]
    );