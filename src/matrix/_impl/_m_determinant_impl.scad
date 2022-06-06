use <../../util/sum.scad>

function _m_determinant_sub(matrix, leng, fc) = 
    let(
        init_sub_m = [for(i = [1:leng - 1]) matrix[i]],
        sub_m = [for(i = [0:len(init_sub_m) - 1]) 
		    let(
			    mi = init_sub_m[i],
				leng_mi = len(mi)
			)
		    [for(j = 0; j < leng_mi; j = j + 1) if(j != fc) mi[j]]
            
        ],
        sgn = pow(-1, fc % 2)
    )
    sgn * matrix[0][fc] * _m_determinant(sub_m);

function _m_determinant(matrix) = 
    let(leng = len(matrix))
    leng == 2 ? cross(matrix[0], matrix[1]) :
        sum([for(fc = [0:leng - 1]) _m_determinant_sub(matrix, leng, fc)]);