use <_impl/_footprints3.scad>;
use <turtle3d.scad>;

/* 
 cmds: "forward" ("xu_move"), "turn" ("zu_turn"), "roll" ("xu_turn"), "pitch" ("yu_turn"), 
       "xu_move", "yu_move", "zu_move", "xu_turn", "yu_turn", "turn"

```
use <hull_polyline3d.scad>;
use <turtle/footprints3.scad>;
 
function xy_arc_cmds(radius, angle, steps) = 
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

// cmds: "forward" ("xu_move"), "turn" ("zu_turn"), "roll" ("xu_turn"), "pitch" (negative "yu_turn")    
poly = footprints3(
    concat(
        [
            ["forward", 10],
            ["turn", 90],
            ["forward", 10] 
        ], 
        xy_arc_cmds(5, 180, 12),
        [
            ["pitch", 90],
            ["forward", 10],
            ["roll", -90]
        ],
        xy_arc_cmds(5, 180, 12),
        [
            ["forward", 10]
        ]
    )
);

hull_polyline3d(poly, thickness = 1);
```
*/
function footprints3(cmds, start = [0, 0, 0]) = 
    let(
        t = turtle3d("create", start, [[1, 0, 0], [0, 1, 0], [0, 0, 1]]),
        leng = len(cmds)
    )
    concat([turtle3d("pt", t)], _footprints3(cmds, t, leng));