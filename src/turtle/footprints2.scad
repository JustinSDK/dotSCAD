use <turtle2d.scad>;
use <_impl/_footprints2.scad>;

/*
    cmds: "turn", "forward"

demo code
```
use <turtle/footprints2.scad>;
use <hull_polyline2d.scad>;
 
function arc_cmds(radius, angle, steps) = 
    let(
        fa = angle / steps,
        ta = fa / 2,
        leng = sin(ta) * radius * 2
    )
    concat(
        [["turn", ta]],
        [
            for(i = [0:steps - 2])
            each [["forward", leng], ["turn", fa]]
        ],
        [["forward", leng], ["turn", ta]]
    );
    
poly = footprints2(
    concat(
        [
            ["forward", 10],
            ["turn", 90],
            ["forward", 10] 
        ], 
        arc_cmds(5, 180, 12),
        [
            ["turn", -90],
            ["forward", 10],
            ["turn", 90],
            ["forward", 10],
            ["turn", 90],
            ["forward", 10]
        ]
    ),
    start = [10, 10],
    angle = 90
);

hull_polyline2d(poly, width = 1);
```
*/
function footprints2(cmds, start = [0, 0], angle = 0) = 
    let(
        t = turtle2d("create", start[0], start[1], angle),
        leng = len(cmds)
    )
    concat([turtle2d("pt", t)], _footprints2(cmds, t, leng));