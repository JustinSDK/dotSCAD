/**
* contains.scad
*
* @copyright Justin Lin, 2022
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-contains.html
*
**/ 

function contains(lt, elem) = search([elem], lt) != [[]];