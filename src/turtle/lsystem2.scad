/**
* lsystem2.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-lsystem2.html
*
**/ 

use <_impl/_lsystem2_impl.scad>;
use <turtle2d.scad>;

function lsystem2(axiom, rules, n, angle, leng = 1, heading = 0, start = [0, 0], forward_chars = "F", rule_prs, seed) =
    let(
        derived = _lsystem2_derive(axiom, rules, n, rule_prs, seed),
        codes = forward_chars == "F" ? derived : _lsystem2_join([
            for(c = derived)
            let(idx = search(c, forward_chars))
            idx == [] ? c : "F"
        ])
    )
    _lines(
        turtle2d("create", start.x, start.y, heading), 
        codes,
        angle,
        leng
    );