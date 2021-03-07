/**
* find_index.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-find_index.html
*
**/ 

use <_impl/_find_index_impl.scad>;

function find_index(lt, test) = _find_index(lt, test, len(lt));