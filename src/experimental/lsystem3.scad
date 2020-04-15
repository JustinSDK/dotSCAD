use <experimental/_impl/_lsystem3_impl.scad>;
use <turtle/turtle3d.scad>;

/*

   F  Move forward and draw line
   f  Move forward without drawing a line
   +  Turn left
   -  Turn right
   |  Reverse direction (ie: turn by 180 degrees)
   &  Pitch down
   ∧  Pitch up
   \  Roll left
   /  Roll right       
   [  Push current turtle state onto stack
   ]  Pop current turtle state from the stack

*/

function lsystem3(axiom, rules, n, angle, leng = 1, heading = 0, start = [0, 0, 0], forward_chars = "F", rules_pr) =
    let(
        derived = _lsystem3_derive(axiom, rules, n, rules_pr),
        codes = forward_chars == "F" ? derived : _lsystem3_join([
            for(c = derived)
            let(idx = search(c, forward_chars))
            idx == [] ? c : "F"
        ])
    )
    _lines(
        turtle3d("create", start, [[1, 0, 0], [0, 1, 0], [0, 0, 1]]),
        codes,
        angle,
        leng
    );