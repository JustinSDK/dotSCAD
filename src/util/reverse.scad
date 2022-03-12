/**
* reverse.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-reverse.html
*
**/ 

function reverse(lt) = [for(i = len(lt) - 1; i > -1; i = i - 1) lt[i]];