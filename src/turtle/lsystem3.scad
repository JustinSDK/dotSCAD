/**
* lsystem3.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-lsystem3.html
*
**/ 

use <_impl/_lsystem_comm.scad>
use <turtle3d.scad>

function lsystem3(axiom, rules, n, angle, leng = 1, heading = 0, start = [0, 0, 0], forward_chars = "F", rule_prs, seed) =
    let(
        codes = _codes(axiom, rules, n, forward_chars, rule_prs, seed),
        _next_t2 = function(t, code, angle, leng)
            is_undef(code) || code == "[" || code == "]" ? t :
            code == "F" || code == "f" ? turtle3d("forward", t, leng) :
            code == "+"  ? turtle3d("turn", t, angle) :
            code == "-"  ? turtle3d("turn", t, -angle) : 
            code == "|"  ? turtle3d("turn", t, 180) :   
            code == "&"  ? turtle3d("pitch", t, -angle) :        
            code == "^"  ? turtle3d("pitch", t, angle) :
            code == "\\" ? turtle3d("roll", t, angle) :             
            code == "/"  ? turtle3d("roll", t, -angle) : t      
    )
    _lines(
        turtle3d("create", start, [[1, 0, 0], [0, 1, 0], [0, 0, 1]]),
        codes,
        angle,
        leng,
        _next_t2,
        function(t) turtle3d("pt", t)
    );