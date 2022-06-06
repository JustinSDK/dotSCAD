use <../__comm__/__ra_to_xy.scad>
use <../__comm__/__to_degree.scad>

function _superformula_r(angle, m1, m2, n1, n2 = 1, n3 = 1, a = 1, b = 1) = 
    let(a_d4 = angle / 4)
    (abs(cos(m1 * a_d4) / a) ^ n2 + abs(sin(m2 * a_d4) / b) ^ n3) ^ (-1 / n1);

function _shape_superformula_impl(phi_step, m1, m2, n1, n2 = 1, n3 = 1, a = 1, b = 1) = 
   let(tau = PI * 2)
   [
        for(phi = 0; phi <= tau; phi = phi + phi_step) 
            let(
                angle = __to_degree(phi),
                r = _superformula_r(angle, m1, m2, n1, n2, n3, a, b)
            )
            __ra_to_xy(r, angle)
   ];