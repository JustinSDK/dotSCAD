/**
* has.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-has.html
*
**/ 

use <bsearch.scad>

function has(lt, elem, sorted = false) = 
    echo("has is deprecated. use util/contains instead.")
    sorted ? bsearch(lt, elem) != -1 :
             search([elem], lt) != [[]];