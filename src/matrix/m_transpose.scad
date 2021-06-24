/**
* m_transpose.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-m_transpose.html
*
**/

function m_transpose(m) =
    let(
        column = len(m[0]),
        row = len(m)
    )
    [
        for(y = 0; y < column; y = y + 1)
        [
            for(x = 0; x < row; x = x + 1)
            m[x][y]
        ]
    ];