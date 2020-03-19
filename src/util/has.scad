/**
* has.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-has.html
*
**/ 

use <util/bsearch.scad>;

function has(lt, elem, sorted = false) = 
    sorted ? bsearch(lt, elem, by = "vt") != -1 :
             search([elem], lt) != [[]];