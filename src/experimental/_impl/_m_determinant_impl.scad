use <util/slice.scad>;
use <experimental/sum.scad>;

function _m_determinant_sub(matrix, leng, fc) = 
    let(
        init_sub_m = [for(i = [1:leng - 1]) matrix[i]],
        sub_m = [for(i = [0:len(init_sub_m) - 1]) 
            concat(slice(init_sub_m[i], 0, fc), slice(init_sub_m[i], fc + 1))
        ],
        sgn = pow(-1, fc % 2)
    )
    sgn * matrix[0][fc] * _m_determinant(sub_m);

function _m_determinant(matrix) = 
    let(leng = len(matrix))
    leng == 2 ? matrix[0][0] * matrix[1][1] - matrix[1][0] * matrix[0][1] :
        let(indices = [for(i = [0:leng - 1]) i])
        sum([for(fc = indices) _m_determinant_sub(matrix, leng, fc)]);