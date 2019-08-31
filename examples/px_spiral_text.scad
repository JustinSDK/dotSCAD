include <hull_polyline2d.scad>;

tx = "3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679821480865132823066470938446095505822317253594081284811174502841027019385211055596446229489549303819644288109756659334461284756482337867831652712019091456485669234603486104543266482133936072602491412737245870066063155881748815209209628292540917153643678925903600113305305488204665213841469519415116094330572703657595919530921861173819326117931051185480744623799627495673518857527248912279381830119491298336733624406566430860213949463952247371907021798609437027705392171762931767523846748184676694051320005681271452635608277857713427577896091736371787214684409012249534301465495853710507922796892589235420199561121290219608640344181598136297747713099605187072113499999983729780499510597317328160963185950244594553469083026425223082533446850352619311881710100031378387528865875332083814206171776691473035982534904287554687311595628638823537875937519577818577805321712268066130019278766111959092164201989";

pts = px_spiral(1, floor(sqrt(len(tx))) + 1);
linear_extrude(.5) for(i = [0:len(tx) - 1]) {
    translate(pts[i]) difference() {
        circle(.4, $fn = 24);
        color("white") text(tx[i], font = "Arial Black", size = .5, valign = "center", halign = "center");
    } 
}
linear_extrude(.25) {
    for(i = [0:len(tx) - 1]) {
        translate(pts[i]) 
            circle(.4, $fn = 24);
    }
    hull_polyline2d([for(i = [0:len(tx) - 1]) pts[i]], width = 0.25);
}

function _px_spiral_forward(pt, leng, dir, clockwise) = 
    let(
        DIRS = clockwise ? [
            [1, 0],
            [0, -1],
            [-1, 0],
            [0, 1]
        ]
        : [ 
            [1, 0],
            [0, 1],
            [-1, 0],
            [0, -1]
        ]
    )
    pt + DIRS[dir] * leng;

function _px_spiral_go_turn(from, leng, max_leng, clockwise, dir) = 
    let(
        range = [1:leng],
        pts = [for(i = range) _px_spiral_forward(from, i, dir % 4, clockwise)],
        ps = pts[len(pts) - 1],
        pts2 = [for(i = range) _px_spiral_forward(ps, i, (dir + 1) % 4, clockwise)],
        pd = pts2[len(pts2) - 1]
    )
    concat(pts, pts2, _px_spiral(pd, leng + 1, max_leng, clockwise, dir + 2));
    
function _px_spiral(from, leng, max_leng, clockwise, dir) = 
    leng > max_leng ? [] : _px_spiral_go_turn(from, leng, max_leng, clockwise, dir);
    
function px_spiral(init_leng, max_leng, clockwise = false) =
    let(
        org = [0, 0]
    )
    concat([org], _px_spiral(org, init_leng, max_leng, clockwise, 0));
