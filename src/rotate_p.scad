/**
* rotate_p.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-rotate_p.html
*
**/ 

use <ptf/_impl/_rotate_p_impl.scad>;

function rotate_p(point, a, v) = 
    let(_ = echo("<b><i>rotate_p</i> is deprecated: use <i>ptf_rotate</i> instead.</b>"))
    _rotate_p_impl(point, a, v);