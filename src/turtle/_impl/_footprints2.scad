use <../turtle2d.scad>;

function _footprints2(cmds, t, leng, i = 0) =
    i == leng ? [] :
        let(
            nxt = turtle2d(cmds[i][0], t, cmds[i][1]),
            pts = _footprints2(cmds, nxt, leng, i + 1)
        )
        cmds[i][0] != "forward" ? pts : concat([turtle2d("pt", nxt)], pts);