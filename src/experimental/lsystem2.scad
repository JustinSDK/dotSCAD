use <experimental/_impl/_lsystem2_impl.scad>;
use <turtle/turtle2d.scad>;

function lsystem2(rules, n, angle, leng = 1, heading = 0, start = [0, 0], forward_chars = "F", rules_pr) =
    let(
        derived = _lsystem2_derive(rules, n, rules_pr),
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