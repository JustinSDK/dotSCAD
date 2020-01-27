/**
* m_shearing.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-m_shearing.html
*
**/

use <matrix/_impl/_m_shearing_impl.scad>;

function m_shearing(sx = [0, 0], sy = [0, 0], sz = [0, 0]) = _m_shearing_impl(sx, sy, sz);