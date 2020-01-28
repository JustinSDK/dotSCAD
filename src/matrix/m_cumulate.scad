/**
* m_cumulate.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-m_cumulate.html
*
**/

use <matrix/_impl/_m_cumulate_impl.scad>;

function m_cumulate(matrice) = _m_cumulate_impl(matrice);
    
