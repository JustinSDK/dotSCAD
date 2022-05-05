/**
* m_mirror.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-m_mirror.html
*
**/

function m_mirror(v) = 
    let(
        nv = v / norm(v),
        txx = -2 * nv.x ^ 2,
        txy = -2 * nv.x * nv.y,
        txz = -2 * nv.x * nv.z,
        tyy = -2 * nv.y ^ 2,
        tyz = -2 * nv.y * nv.z,
        tzz = -2 * nv.z ^ 2
    )
    [
        [1 + txx, txy, txz, 0],
        [txy, 1 + tyy, tyz, 0],
        [txz, tyz, 1 + tzz, 0],
        [0, 0, 0, 1]
    ];