/**
* px_from.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_from.html
*
**/ 

function _px_from_row(r_count, row_bits, width, height, center, invert) =
    let(
        half_w = width / 2,
        half_h = height / 2,
        offset_x = center ? 0 : half_w,
        offset_y = center ? -half_h : 0,
        bit = invert ? 0 : 1
    ) 
    [for(i = 0; i < width; i = i + 1) if(row_bits[i] == bit) [i - half_w + offset_x, r_count + offset_y]];

function px_from(binaries, center = false, invert = false) = 
    let(
        width = len(binaries[0]),
        height = len(binaries),
        offset_i = height / 2
    )
    [
        for(i = height - 1; i > -1; i = i - 1) 
        let(row = _px_from_row(height - i - 1, binaries[i], width, height, center, invert))
        if(row != []) each row
    ];