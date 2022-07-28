/**
* m_replace.scad
*
* @copyright Justin Lin, 2022
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-m_replace.html
*
**/

function m_replace(m, i, j, value) =
    let(
		rowI = m[i],
		newRowI = [
            for(c = [0:len(rowI) - 1]) 
            if(c == j) value
            else rowI[c]
        ]
	)
    [
        for(r = [0:len(m) - 1])
        if(r == i) newRowI
        else m[r]
    ];
