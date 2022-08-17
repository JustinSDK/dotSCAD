use <turtle/lsystem3.scad>
use <util/dedup.scad>
use <polyline_join.scad>

for(line = dedup(hilbert_curve())) {
    polyline_join(line)
	    sphere(.25, $fn = 4);
}  

function tree1(n = 4, angle = 22.5, leng = 1, heading = 0, start = [0, 0, 0]) = 
    let(
        axiom = "FFFA",
        rules = [
            ["A", "[&FFFA]////[&FFFA]////[&FFFA]"]
        ]
    )
    lsystem3(axiom, rules, n, angle, leng, heading, start);  

function tree2(n = 5, angle = 18, leng = 1, heading = 0, start = [0, 0, 0]) = 
    let(
        axiom = "BBBBBA",
        rules = [
            ["A", "[++BB[--C][++C][&&C][^^C]A]/////+BBB[--C][++C][&&C][^^C]A"],
            ["B", "\\\\B"],
            ["C", ""]
        ]
    )
    lsystem3(axiom, rules, n, angle, leng, heading, start, forward_chars = "ABC");  

function plant(n = 4, angle = 30, leng = 1, heading = 0, start = [0, 0, 0]) = 
    let(
        axiom = "A",
        rules = [
            ["A", "B[+A]\\\\\\\\[+A]\\\\\\\\[+A]\\\\\\\\BA"],
            ["B", "BB"],
            ["B", "A/B"]
        ]
    )
    lsystem3(axiom, rules, n, angle, leng, heading, start, forward_chars = "AB", rule_prs = [1, .5, .5]);

function hilbert_curve(n = 3, angle = 90, leng = 1, heading = 0, start = [0, 0, 0]) = 
    let(
        axiom = "A",
        rules = [
            ["A", "B-F+CFC+F-D&F^D-F+&&CFC+F+B//"],
            ["B", "A&F^CFB^F^D^^-F-D^|F^B|FC^F^A//"],
            ["C", "|D^|F^B-F+C^F^A&&FA&F^C+F+B^F^D//"],
            ["D", "|CFB-F+B|FA&F^A&&FB-F+B|FC//"]
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

function vine(n = 3, angle = 18, leng = 1, heading = 0, start = [0, 0, 0]) = 
    let(
        axiom = "--F",
        rules = [
            ["F", "/F[++F]-\\F[--F]+//F"]
        ]
    )
    lsystem3(axiom, rules, n, angle, leng, heading, start);  

function spring(n = 8, angle = 12, leng = 1, heading = 0, start = [0, 0, 0]) = 
    let(
        axiom = "F",
        rules = [
            ["F", "F-^F"]
        ]
    )
    lsystem3(axiom, rules, n, angle, leng, heading, start);  