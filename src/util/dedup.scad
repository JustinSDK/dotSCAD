/**
* dedup.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-dedup.html
*
**/ 

use <util/_impl/_dedup_impl.scad>;

function dedup(lt, sorted = false) = 
    sorted ?  _dedup_sorted(lt, len(lt)) :
              _dedup(lt, [], len(lt));