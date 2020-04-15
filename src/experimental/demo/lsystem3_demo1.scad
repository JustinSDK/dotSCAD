use <experimental/lsystem3.scad>;
use <hull_polyline3d.scad>;

//  Hilbert curve 3D
axiom = "A";
rules = [
    ["A", "B-F+CFC+F-D&F∧D-F+&&CFC+F+B//"],
    ["B", "A&F∧CFB∧F∧D∧∧-F-D∧|F∧B|FC∧F∧A//"],
    ["C", "|D∧|F∧B-F+C∧F∧A&&FA&F∧C+F+B∧F∧D//"],
    ["D", "|CFB-F+B|FA&F∧A&&FB-F+B|FC//"],
];

for(line = lsystem3(axiom, rules, 3, 90)) {
    hull_polyline3d(
        [line[0], line[1]], 
        thickness = 0.5, 
        $fn = 4
    );
}  