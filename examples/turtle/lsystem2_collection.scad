use <turtle/lsystem2.scad>
use <util/dedup.scad>
use <line2d.scad>

for(line = dedup(fern())) {
    line2d(
        line[0],
        line[1],
        .2,
        p1Style = "CAP_ROUND", 
        p2Style =  "CAP_ROUND"
    );
}

function fern(n = 8, angle = 4, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "EEEA",
        rules = [
            ["A", "[++++++++++++++EC]B+B[--------------ED]B+BA"],
            ["C", "[---------EE][+++++++++EE]B+C"],
            ["D", "[---------EE][+++++++++EE]B-D"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start, forward_chars = "ABCDE");  

function tree(n = 2, angle = 36, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F",
        rules = [
            ["F", "F[+FF][-FF]F[-F][+F]F"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);

function plant(n = 4, angle = 25, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "X",
        rules = [
            ["X", "F+[[X]-X]-F[-FX]+X"],
            ["F", "FF"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);

function koch_curve(n = 4, angle = 60, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F",
        rules = [
            ["F", "F-F++F-F"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);

function koch_curve_3(n = 3, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F-F-F-F",
        rules = [
            ["F", "FF-F+F-F-FF"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);

function koch_snowflake(n = 4, angle = 60, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F++F++F",
        rules = [
            ["F", "F-F++F-F"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);

function koch_quadratic(n = 3, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F-F-F-F",
        rules = [
            ["F", "FF-F-F-F-F-F+F"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);

function koch_quadratic_type1(n = 4, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F",
        rules = [
            ["F", "F-F+F+F-F"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);

function koch_quadratic_type2(n = 4, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F",
        rules = [
            ["F", "F-F+F+FF-F-F+F"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);

function koch_star(n = 4, angle = 60, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F++F++F",
        rules = [
            ["F", "F+F--F+F"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);   

function dragon_curve(n = 10, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "FX",
        rules = [
            ["X", "X+YF+"],
            ["Y", "-FX-Y"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);

function twin_dragon_curve(n = 8, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "FX+FX",
        rules = [
            ["X", "X+YF"],
            ["Y", "FX-Y"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);    

function hilbert_curve(n = 5, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "A",
        rules = [
            ["A", "-BF+AFA+FB-"],
            ["B", "+AF-BFB-FA+"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);    

function moore_curve(n = 4, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "LFL+F+LFL",
        rules = [
            ["L", "-RF+LFL+FR-"],
            ["R", "+LF-RFR-FL+"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);      

function peano_curve(n = 3, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "L",
        rules = [
            ["L", "LFRFL-F-RFLFR+F+LFRFL"],
            ["R", "RFLFR+F+LFRFL-F-RFLFR"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);       

function gosper_curve(n = 4, angle = 60, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "A",
        rules = [
            ["A", "A-B--B+A++AA+B-"],
            ["B", "+A-BB--B-A++A+B"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start, "AB");    

function gosper_star(n = 2, angle = 60, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "X-X-X-X-X-X",
        rules = [
            ["X", "FX+YF++YF-FX--FXFX-YF+"],
            ["Y", "-FX+YFYF++YF+FX--FX-FY"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);    

function levy_c_curve(n = 8, angle = 45, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F",
        rules = [
            ["F", "+F--F+"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);       

function island_curve(n = 2, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F-F-F-F",
        rules = [
            ["F", "F-f+FF-F-FF-Ff-FF+f-FF+F+FF+Ff+FFF"],
            ["f", "ffffff"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);  

function sierpinski_triangle(n = 5, angle = 120, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F-G-G",
        rules = [
            ["F", "F-G+F+G-F"],
            ["G", "GG"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start, "G");  

function sierpinski_arrowhead(n = 6, angle = 60, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "XF",
        rules = [
            ["X", "YF+XF+Y"],
            ["Y", "XF-YF-X"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);     

function sierpinski_square(n = 8, angle = 45, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "L--F--L--F",
        rules = [
            ["L", "+R-F-R+"],
            ["R", "-L+F+L-"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);      

function sierpinski_carpet(n = 4, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F",
        rules = [
            ["F", "F+F-F-F-G+F+F+F-F"],
            ["G", "GGG"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start, forward_chars = "G");          

function terdragon(n = 5, angle = 120, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F",
        rules = [
            ["F", "F+F-F"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);    

function pentadendrite(n = 2, angle = 72, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F-F-F-F-F",
        rules = [
            ["F", "F-F-F++F+F-F"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);    

function icy(n = 2, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F+F+F+F",
        rules = [
            ["F", "FF+F++F+F"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);        

function round_star(n = 6, angle = 77, leng = 10, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F",
        rules = [
            ["F", "F++F"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);   

function penrose_tiling(n = 2, angle = 36, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "[7]++[7]++[7]++[7]++[7]",
        rules = [
            ["6", "81++91----71[-81----61]++"],
            ["7", "+81--91[---61--71]+"],
            ["8", "-61++71[+++81++91]-"],
            ["9", "--81++++61[+91++++71]--71"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start, "6789");       

function bush(n = 3, angle = 16, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "++++F",
        rules = [
            ["F", "FF-[-F+F+F]+[+F-F-F]"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);       

function pentigree(n = 3, angle = 72, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F-F-F-F-F",
        rules = [
            ["F", "F-F++F+F-F-F"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);         

function penrose_snowflake(n = 3, angle = 18, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F----F----F----F----F",
        rules = [
            ["F", "F----F----F----------F++F----F"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);         

function weed(n = 6, angle = 22.5, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "F",
        rules = [
            ["F", "FF-[XY]+[XY]"],
            ["X", "+FY"],
            ["Y", "-FX"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start);

function euler_spiral(n = 30, angle = 2.75, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        axiom = "AF+",
        rules = [
            ["A", "AF+"],
			["F", "F+"]
        ]
    )
    lsystem2(axiom, rules, n, angle, leng, heading, start); 