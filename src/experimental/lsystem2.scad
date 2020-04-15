use <experimental/_impl/_lsystem2_impl.scad>;
use <turtle/turtle2d.scad>;

/*

   F  Move forward and draw line
   f  Move forward without drawing a line
   +  Turn left
   -  Turn right
   |  Reverse direction (ie: turn by 180 degrees)
   [  Push current turtle state onto stack
   ]  Pop current turtle state from the stack

*/

function lsystem2(axiom, rules, n, angle, leng = 1, heading = 0, start = [0, 0], forward_chars = "F", rules_pr) =
    let(
        derived = _lsystem2_derive(axiom, rules, n, rules_pr),
        codes = forward_chars == "F" ? derived : _lsystem2_join([
            for(c = derived)
            let(idx = search(c, forward_chars))
            idx == [] ? c : "F"
        ])
    )
    _lines(
        turtle2d("create", start[0], start[0], heading), 
        codes,
        angle,
        leng
    );