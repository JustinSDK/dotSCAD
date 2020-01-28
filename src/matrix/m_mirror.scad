/**
* m_mirror.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2x-m_mirror.html
*
**/

function m_mirror(v) = 
    let(
        nv = v / norm(v),
        txx = -2* nv[0] * nv[0],
        txy = -2* nv[0] * nv[1],
        txz = -2* nv[0] * nv[2],
        tyy = -2* nv[1] * nv[1],
        tyz = -2* nv[1] * nv[2],
        tzz = -2* nv[2] * nv[2]
    )
    [
        [1 + txx, txy, txz, 0],
        [txy, 1 + tyy, tyz, 0],
        [txz, tyz, 1 + tzz, 0],
        [0, 0, 0, 1]
    ];