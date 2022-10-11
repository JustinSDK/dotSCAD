/**
* rails2sections.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-rails2sections.html
*
**/

use <matrix/m_transpose.scad>

function rails2sections(rails) = echo("rails2sections is deprecated. use maxtrix/m_transpose instead.") m_transpose(rails);