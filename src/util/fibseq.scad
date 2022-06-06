/**
* fibseq.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-fibseq.html
*
**/ 

use <_impl/_fibseq_impl.scad> 

function fibseq(from, to) = _fibseq_impl(from, to);