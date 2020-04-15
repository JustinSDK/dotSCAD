use <experimental/lsystem3.scad>;
use <hull_polyline3d.scad>;

for(line = tree()) {
    hull_polyline3d(
        [line[0], line[1]], 
        thickness = 0.25, 
        $fn = 4
    );
}  

function tree(n = 5, angle = 22.5, leng = 1, heading = 0, start = [0, 0, 0]) = 
    let(
        axiom = "A",
        rules = [
            ["A", "F[&FLA]/////[&FLA]///////[&FLA]"],
            ["F", "/////F"]
        ]
    )
    lsystem3(axiom, rules, n, angle, leng, heading, start);  

function hilbert_curve(n = 3, angle = 90, leng = 1, heading = 0, start = [0, 0, 0]) = 
    let(
        axiom = "A",
        rules = [
            ["A", "B-F+CFC+F-D&F∧D-F+&&CFC+F+B//"],
            ["B", "A&F∧CFB∧F∧D∧∧-F-D∧|F∧B|FC∧F∧A//"],
            ["C", "|D∧|F∧B-F+C∧F∧A&&FA&F∧C+F+B∧F∧D//"],
            ["D", "|CFB-F+B|FA&F∧A&&FB-F+B|FC//"]
        ]
    )
    lsystem3(axiom, rules, n, angle, leng, heading, start);  