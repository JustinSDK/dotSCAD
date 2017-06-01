/**
* paths2sections.scad
*
* Given a list of paths, this function will return all cross-sections described by those paths.
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-paths2sections.html
*
**/

function paths2sections(paths) =
    let(
        leng_path = len(paths[0]),
        leng_paths = len(paths)
    )
    [
        for(i = [0:leng_path - 1])
            [
                for(j = [0:leng_paths - 1])
                    paths[j][i]
            ] 
    ];