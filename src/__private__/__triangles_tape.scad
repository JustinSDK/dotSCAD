function __triangles_tape(leng_pts) =
    concat(
        [
            for(i = [0:leng_pts / 2 - 2]) 
                [i, leng_pts - i - 1, leng_pts - i - 2]
        ],
        [
            for(i = [0:leng_pts / 2 - 2])
                [i, i + 1, leng_pts - i - 2]
        ]
    );