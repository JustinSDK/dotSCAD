use <bezier_smooth.scad>;
use <hull_polyline3d.scad>;
use <util/dedup.scad>;
use <turtle/lsystem3.scad>;

diameter = 0.3;
corner_r = 0.5;

lines = hilbert_curve();
hilbert_path = dedup(
    concat(
        [for(line = lines) line[0]], 
        [lines[len(lines) - 1][1]])
    );
smoothed_hilbert_path = bezier_smooth(hilbert_path, corner_r);

hull_polyline3d(smoothed_hilbert_path,  diameter = diameter);

function hilbert_curve() = 
    let(
        axiom = "A",
        rules = [
            ["A", "B-F+CFC+F-D&F^D-F+&&CFC+F+B//"],
            ["B", "A&F^CFB^F^D^^-F-D^|F^B|FC^F^A//"],
            ["C", "|D^|F^B-F+C^F^A&&FA&F^C+F+B^F^D//"],
            ["D", "|CFB-F+B|FA&F^A&&FB-F+B|FC//"]
        ]
    )
    lsystem3(axiom, rules, 2, 90, 1, 0,  [0, 0, 0]);  