/**
* lsystem3.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-lsystem3.html
*
**/ 

use <_impl/_lsystem3_impl.scad>;
use <turtle3d.scad>;

function lsystem3(axiom, rules, n, angle, leng = 1, heading = 0, start = [0, 0, 0], forward_chars = "F", rule_prs) =
    let(
        derived = _lsystem3_derive(axiom, rules, n, rule_prs),
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