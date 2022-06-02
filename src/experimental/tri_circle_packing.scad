use <triangle/tri_incenter.scad>;
use <ptf/ptf_rotate.scad>;

function r(sin, leng_cv, pre_R) = sin * (leng_cv - pre_R) / (1 + sin);

// the 3rd circle
function c3_r(r1, r2) = (r1 * r2) / (r1 + r2 + 2 * sqrt(r1 * r2));
function c3_a(r1, r2, r3) = 
    let(
        a = r3 + r1,
        b = r3 + r2,
        c = r1 + r2
    )
    acos((b ^ 2 + c ^ 2 - a ^ 2) / (2 * b * c));

function tri_circle_packing(t, density, min_r) =
    let(
        center = tri_incenter(t),
        s1 = t[1] - t[0],
        s2 = t[2] - t[1],
        s3 = t[0] - t[2],
        leng_s1 = norm(s1),
        leng_s2 = norm(s2),
        leng_s3 = norm(s3),
        R = abs(cross(s1, s2)) / (leng_s1 + leng_s2 + leng_s3),
        ca = center - t[0],
        leng_ca = norm(ca),
        unit_ca = ca / leng_ca,
        sina = R / leng_ca,
        cb = center - t[1],
        leng_cb = norm(cb),
        unit_cb = cb / leng_cb,
        sinb = R / leng_cb,
        cc = center - t[2],
        leng_cc = norm(cc),
        unit_cc = cc / leng_cc,
        sinc = R / leng_cc,
        _small_circles = function(density, pre_leng_a = R, pre_leng_b = R, pre_leng_c = R, pre_ra = R, pre_rb = R, pre_rc = R) 
            density <= 0 ? [] :
            let(
                ra = r(sina, leng_ca, pre_leng_a),
                Ra = pre_leng_a + ra,
                ct_a = center - unit_ca * Ra,

                rb = r(sinb, leng_cb, pre_leng_b),
                Rb = pre_leng_b + rb,
                ct_b = center - unit_cb * Rb,

                rc = r(sinc, leng_cc, pre_leng_c),
                Rc = pre_leng_c + rc,
                ct_c = center - unit_cc * Rc,

                r3a = c3_r(pre_ra, ra),
                alpha3a = c3_a(pre_ra, ra, r3a),
                vta = unit_ca * (r3a + ra),
                ct1a = ct_a + ptf_rotate(vta, alpha3a),
                ct2a = ct_a + ptf_rotate(vta, -alpha3a),

                r3b = c3_r(pre_rb, rb),
                alpha3b = c3_a(pre_rb, rb, r3b),
                vtb = unit_cb * (r3b + rb),
                ct1b = ct_b + ptf_rotate(vtb, alpha3b),
                ct2b = ct_b + ptf_rotate(vtb, -alpha3b),

                r3c = c3_r(pre_rc, rc),
                alpha3c = c3_a(pre_rc, rc, r3c),
                vtc = unit_cc * (r3c + rc),
                ct1c = ct_c + ptf_rotate(vtc, alpha3c),
                ct2c = ct_c + ptf_rotate(vtc, -alpha3c)                  
            )
            [
                if(ra > min_r) each [[ct_a, ra], if(r3a > min_r) each [[ct1a, r3a], [ct2a, r3a]]], 
                if(rb > min_r) each [[ct_b, rb], if(r3b > min_r) each [[ct1b, r3b], [ct2b, r3b]]], 
                if(rc > min_r) each [[ct_c, rc], if(r3c > min_r) each [[ct1c, r3c], [ct2c, r3c]]], 
                each _small_circles(density - 1, ra + Ra, rb + Rb, rc + Rc, ra, rb, rc)
            ]
    )
    [[center, R], each _small_circles(density - 1)];    
    