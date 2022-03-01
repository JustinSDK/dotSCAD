/**
* sum.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sum.html
*
**/ 

function sum(lt) = 
    let(leng = len(lt))
    [for(i = 0; i < leng; i = i + 1) 1] * lt;