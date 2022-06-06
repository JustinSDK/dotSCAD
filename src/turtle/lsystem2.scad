/**
* lsystem2.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-lsystem2.html
*
**/ 

use <_impl/_lsystem_comm.scad>
use <turtle2d.scad>

function lsystem2(axiom, rules, n, angle, leng = 1, heading = 0, start = [0, 0], forward_chars = "F", rule_prs, seed) =
    let(
        codes = _codes(axiom, rules, n, forward_chars, rule_prs, seed),
        next_t2 = function(t, code, angle, leng)
            is_undef(code) || code == "[" || code == "]" ? t :
            code == "F" || code == "f" ? turtle2d("forward", t, leng) :
            code == "+" ? turtle2d("turn", t, angle) :
            code == "-" ? turtle2d("turn", t, -angle) : 
            code == "|" ? turtle2d("turn", t, 180) : t    
    )
    _lines(
        turtle2d("create", start.x, start.y, heading), 
        codes,
        angle,
        leng,
        next_t2, 
        function(t) turtle2d("pt", t)
    );