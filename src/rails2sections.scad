/**
* rails2sections.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-rails2sections.html
*
**/

function rails2sections(rails) =
    let(
        leng_rail = len(rails[0]),
        leng_rails = len(rails)
    )
    [
        for(i = 0; i < leng_rail; i = i + 1)
            [
                for(j = 0; j < leng_rails; j = j + 1)
                    rails[j][i]
            ] 
    ];