/**
* sum.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sum.html
*
**/ 

function sum(lt) = [for(i = [0:len(lt) - 1]) 1] * lt;