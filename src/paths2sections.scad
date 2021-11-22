/**
* paths2sections.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-paths2sections.html
*
**/

function paths2sections(paths) =
    let(
        _ = echo("`paths2sections` is deprecated since 3.2. Use `rails2sections` instead."),
        leng_path = len(paths[0]),
        leng_paths = len(paths)
    )
    [
        for(i = 0; i < leng_path; i = i + 1)
            [
                for(j = 0; j < leng_paths; j = j + 1)
                    paths[j][i]
            ] 
    ];