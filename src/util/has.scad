/**
* has.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-has.html
*
**/ 

function has(lt, elem) = search([elem], lt) != [[]];