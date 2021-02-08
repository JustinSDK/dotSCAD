/**
* dedup.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-dedup.html
*
**/ 

use <_impl/_dedup_impl.scad>;

function dedup(lt, sorted = false, eq) = 
    sorted ? _dedup_sorted(lt, len(lt), eq) : _dedup(lt, [], len(lt), eq);