/**
* shape_pentagram.scad
*
* Returns shape points and triangle indexes of a pentagram.
* They can be used with xxx_extrude modules of dotSCAD.
* The shape points can be also used with the built-in polygon module. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_ellipse.html
*
**/

function shape_pentagram(r) =
    [
        // shape points
        [
            [0, 1], [-0.224514, 0.309017], 
            [-0.951057, 0.309017], [-0.363271, -0.118034], 
            [-0.587785, -0.809017], [0, -0.381966], 
            [0.587785, -0.809017], [0.363271, -0.118034], 
            [0.951057, 0.309017], [0.224514, 0.309017]
        ] * r,
        // triangles
        [   
            [0, 1, 9],
            [2, 3, 1],
            [4, 5, 3],
            [6, 7, 5],
            [8, 9, 7],
            [1, 3, 5],
            [1, 5, 7],
            [1, 7, 9]
        ]
    ];