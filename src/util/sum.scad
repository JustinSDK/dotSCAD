/**
* sum.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sum.html
*
**/ 

use <_impl/_sum_impl.scad>;

function sum(lt) = _sum_impl(lt, len(lt));