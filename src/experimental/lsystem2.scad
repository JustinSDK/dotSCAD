use <experimental/_impl/_lsystem2_impl.scad>;
use <turtle/turtle2d.scad>;

function lsystem2(rule, n, angle, leng = 1, heading = 0, start_pt = [0, 0]) =
    let(
        produced = produce(rule, n),
        cmds = [
            for(s = produced) 
            let(c = cmd(s, [leng, angle]))
            if(c != []) c
        ]
    )
    _lines(
        turtle2d("create", start_pt[0], start_pt[0], heading), 
        cmds
    );