use <experimental/lsystem3.scad>;
use <hull_polyline3d.scad>;

for(line = plant()) {
    hull_polyline3d(
        [line[0], line[1]], 
        thickness = 0.25, 
        $fn = 4
    );
}  

function tree(n = 4, angle = 22.5, leng = 1, heading = 0, start = [0, 0, 0]) = 
    let(
        axiom = "FFFA",
        rules = [
            ["A", "[&FFFA]////[&FFFA]////[&FFFA]"]
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

function fern(n = 8, angle = 4, leng = 1, heading = 0, start = [0, 0, 0]) = 
    let(
        axiom = "EEEA",
        rules = [
            ["A", "[++++++++++++++EC]B^+B[--------------ED]B+BA"],
            ["C", "[---------EE][+++++++++EE]B&&+C"],
            ["D", "[---------EE][+++++++++EE]B&&-D"]
        ]
    )
    lsystem3(axiom, rules, n, angle, leng, heading, start, forward_chars = "ABCDE");  

function plant(n = 3, angle = 18, leng = 1, heading = 0, start = [0, 0, 0]) = 
    let(
        axiom = "--F",
        rules = [
            ["F", "/F[++F]-\F[--F]+//F"]
        ]
    )
    lsystem3(axiom, rules, n, angle, leng, heading, start);  