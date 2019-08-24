function _px_from_row(r_count, row_bits, width, height, center, invert) =
    let(
        half_w = width / 2,
        half_h = height / 2,
        offset_x = center ? 0 : half_w,
        offset_y = center ? 0 : half_h,
        bit = invert ? 0 : 1
    ) 
    [for(i = 0; i < width; i = i + 1) if(row_bits[i] == bit) [i - half_w + offset_x, r_count + offset_y]];

function px_from(binaries, size, center = false, invert = false) = 
    let(
        squar = sqrt(len(binaries)),
        siz = is_undef(size) ? [squar, squar] : size,
        width = siz[0],
        height = siz[1],
        rows = [
            for(row = height - 1; row > -1; row = row - 1)
                [for(column = 0; column < width; column = column + 1)
                    binaries[row * width + column]]
        ],
        offset_i = height / 2
    )
    [
        for(i = 0; i < height; i = i + 1) 
        let(row = _px_from_row(i - offset_i, rows[i], width, height, center, invert))
        if(row != []) each row
    ];