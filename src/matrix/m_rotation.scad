/**
* m_rotation.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-m_rotation.html
*
**/

use <_impl/_m_rotation_impl.scad>

function m_rotation(a, v) = _m_rotation_impl(a, v);