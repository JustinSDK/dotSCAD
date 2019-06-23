/**
* m_rotation.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-m_rotation.html
*
**/

include <__comm__/__to_ang_vect.scad>;
include <__comm__/__m_rotation.scad>;

function m_rotation(a, v) = __m_rotation(a, v);