function _bitmap_row(r_count, row_bits, dimension, range, center, invert) =
    let(
        half_d = dimension / 2,
        offset_p = center ? 0 : half_d,
        bit = invert ? 0 : 1
    ) 
    [for(i = range) if(row_bits[i] == bit) [i - half_d + offset_p, r_count + offset_p]];


function bitmap(raw_data, center = true, invert = false) = 
    let(
        dimension = sqrt(len(raw_data)),
        range = [0:dimension - 1],
        rows = [
            for(row = range)
                [for(column = range)
                    raw_data[row * dimension + column]]
        ],
        offset_i = dimension / 2 - 1
    )
    [
        for(i = range) 
        let(row = _bitmap_row(-i + offset_i, rows[i], dimension, range, center, invert))
        if(row != []) each row
        
    ];