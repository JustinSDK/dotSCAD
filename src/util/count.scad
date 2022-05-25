/**
* count.scad
*
* @copyright Justin Lin, 2022
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-count.html
*
**/ 

function count(lt, test) = len([for(elem = lt) if(test(elem)) undef]);