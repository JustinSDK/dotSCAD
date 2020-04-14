use <experimental/_impl/_lsystem2_impl.scad>;
use <turtle/turtle2d.scad>;

function lsystem2(rule, n, angle, leng = 1, heading = 0, start = [0, 0], forward_chars = "F", derived_pr) =
    let(
        derived = _lsystem2_derive(rule, n, derived_pr),
        codes = forward_chars == "F" ? derived : _join([
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