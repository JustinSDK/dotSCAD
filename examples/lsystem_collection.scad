use <experimental/lsystem2.scad>;
use <line2d.scad>;

for(line = plant()) {
    line2d(
        line[0],
        line[1],
        .2,
        p1Style = "CAP_ROUND", 
        p2Style =  "CAP_ROUND"
    );
}

function tree(n = 2, angle = 36, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F"],
            ["F", "F[+FF][-FF]F[-F][+F]F"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);

function plant(n = 4, angle = 25, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "X"],
            ["X", "F+[[X]-X]-F[-FX]+X"],
            ["F", "FF"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start, rule_pr = [1, 1, 1]);

function koch_curve(n = 4, angle = 60, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F"],
            ["F", "F-F++F-F"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);

function koch_curve_3(n = 3, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F-F-F-F"],
            ["F", "FF-F+F-F-FF"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);

function koch_snowflake(n = 4, angle = 60, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F++F++F"],
            ["F", "F-F++F-F"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);

function koch_quadratic(n = 3, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F-F-F-F"],
            ["F", "FF-F-F-F-F-F+F"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);

function koch_quadratic_type1(n = 4, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F"],
            ["F", "F-F+F+F-F"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);

function koch_quadratic_type2(n = 4, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F"],
            ["F", "F-F+F+FF-F-F+F"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);

function koch_star(n = 4, angle = 60, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F++F++F"],
            ["F", "F+F--F+F"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start, "6789");   

function dragon_curve(n = 10, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "FX"],
            ["X", "X+YF+"],
            ["Y", "-FX-Y"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);
    
function twin_dragon_curve(n = 8, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "FX+FX+"],
            ["X", "X+YF"],
            ["Y", "Y=FX-Y"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);    
    
function hilbert_curve(n = 5, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "A"],
            ["A", "-BF+AFA+FB-"],
            ["B", "+AF-BFB-FA+"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);    

function moore_curve(n = 4, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "LFL+F+LFL"],
            ["L", "-RF+LFL+FR-"],
            ["R", "+LF-RFR-FL+"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);      

function peano_curve(n = 3, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "L"],
            ["L", "LFRFL-F-RFLFR+F+LFRFL"],
            ["R", "RFLFR+F+LFRFL-F-RFLFR"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);       

function gosper_curve(n = 4, angle = 60, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "A"],
            ["A", "A-B--B+A++AA+B-"],
            ["B", "+A-BB--B-A++A+B"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start, "AB");    

function gosper_star(n = 2, angle = 60, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "X-X-X-X-X-X"],
            ["X", "FX+YF++YF-FX--FXFX-YF+"],
            ["Y", "-FX+YFYF++YF+FX--FX-FY"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);    
    
function levy_c_curve(n = 8, angle = 45, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F"],
            ["F", "+F--F+"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);       

function island_curve(n = 2, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F-F-F-F"],
            ["F", "F-M+FF-F-FF-FM-FF+M-FF+F+FF+FM+FFF"],
            ["M", "MMMMMM"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);  
    
function sierpinski_triangle(n = 5, angle = 120, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F-G-G"],
            ["F", "F-G+F+G-F"],
            ["G", "GG"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start, "FG");  

function sierpinski_arrowhead(n = 6, angle = 60, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "XF"],
            ["X", "YF+XF+Y"],
            ["Y", "XF-YF-X"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);     

function sierpinski_square(n = 8, angle = 45, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "L--F--L--F"],
            ["L", "+R-F-R+"],
            ["R", "-L+F+L-"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);      
    
function terdragon(n = 5, angle = 120, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F"],
            ["F", "F+F-F"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);    

function pentadendrite(n = 2, angle = 72, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F-F-F-F-F"],
            ["F", "F-F-F++F+F-F"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);    
    
function icy(n = 2, angle = 90, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F+F+F+F"],
            ["F", "FF+F++F+F"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);        

function round_star(n = 3, angle = 77, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F"],
            ["F", "F++F"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);   
    
function penrose_tiling(n = 2, angle = 36, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "[7]++[7]++[7]++[7]++[7]"],
            ["6", "81++91----71[-81----61]++"],
            ["7", "+81--91[---61--71]+"],
            ["8", "-61++71[+++81++91]-"],
            ["9", "--81++++61[+91++++71]--71"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start, "6789");       

function bush(n = 3, angle = 16, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "++++F"],
            ["F", "FF-[-F+F+F]+[+F-F-F]"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);       

function pentigree(n = 3, angle = 72, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F-F-F-F-F"],
            ["F", "F-F++F+F-F-F"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);         

function penrose_snowflake(n = 3, angle = 18, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F----F----F----F----F"],
            ["F", "F----F----F----------F++F----F"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);         

function weed(n = 6, angle = 22.5, leng = 1, heading = 0, start = [0, 0]) = 
    let(
        rule = [
            ["S", "F"],
            ["F", "FF-[XY]+[XY]"],
            ["X", "+FY"],
            ["Y", "-FX"]
        ]
    )
    lsystem2(rule, n, angle, leng, heading, start);         