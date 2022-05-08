function _row(r_count, row_bits, width, height, center, invert) =
    let(
        half_w = width / 2,
        half_h = height / 2,
        offset_x = center ? 0 : half_w,
        offset_y = center ? -half_h : 0,
        bit = invert ? 0 : 1,
        y = r_count + offset_y
    ) 
    [for(i = 0; i < width; i = i + 1) if(row_bits[i] == bit) [i - half_w + offset_x, y]];

function _vx_from_impl(binaries, center, invert) = 
    let(
        width = len(binaries[0]),
        height = len(binaries),
        offset_i = height / 2
    )
    [
        for(i = height - 1; i > -1; i = i - 1) 
        each _row(height - i - 1, binaries[i], width, height, center, invert)
    ];