use <triangle/tri_incenter.scad>
use <ptf/ptf_rotate.scad>

function r2(sinv, leng_cv, pre_R) = sinv * (leng_cv - pre_R) / (1 + sinv);

// the 3rd circle
function c3_r(r1, r2) = (r1 * r2) / (r1 + r2 + 2 * sqrt(r1 * r2));
function c3_a(r1, r2, r3) = 
    let(
        a = r3 + r1,
        b = r3 + r2,
        c = r1 + r2
    )
    acos((b ^ 2 + c ^ 2 - a ^ 2) / (2 * b * c));


function pack_one(min_r, center, v, sinv, leng_cv, unit_cv, pre_leng, pre_r) = 
            let(
                r2 = r2(sinv, leng_cv, pre_leng),
                leng = pre_leng + r2,
                r2_ct = center - unit_cv * leng,

                r3 = c3_r(pre_r, r2),
                a = c3_a(pre_r, r2, r3),
                vta = unit_cv * (r3 + r2),
                r3_ct1 = r2_ct + ptf_rotate(vta, a, v),
                r3_ct2 = r2_ct + ptf_rotate(vta, -a, v)           
            )
            r2 > min_r ? 
                concat(
                    [[r2_ct, r2], if(r3 > min_r) each [[r3_ct1, r3], [r3_ct2, r3]]], 
                    pack_one(min_r, center, v, sinv, leng_cv, unit_cv, r2 + leng, r2)
                )
                : [];

function tri_circle_packing(shape_pts, min_r) =
    let(
        center = tri_incenter(shape_pts),
        s1 = shape_pts[1] - shape_pts[0],
        s2 = shape_pts[2] - shape_pts[1],
        s3 = shape_pts[0] - shape_pts[2],
        cross_value = cross(s1, s2),
        nv = is_num(cross_value) ? [0, 0, cross_value] : cross_value,
        R = abs(norm(nv)) / (norm(s1) + norm(s2) + norm(s3)),

        ca = center - shape_pts[0],
        leng_ca = norm(ca),
        unit_ca = ca / leng_ca,
        sina = R / leng_ca,

        cb = center - shape_pts[1],
        leng_cb = norm(cb),
        unit_cb = cb / leng_cb,
        sinb = R / leng_cb,

        cc = center - shape_pts[2],
        leng_cc = norm(cc),
        unit_cc = cc / leng_cc,
        sinc = R / leng_cc
    )
    [
        [center, R], 
        each pack_one(min_r, center, nv, sina, leng_ca, unit_ca, R, R), 
        each pack_one(min_r, center, nv, sinb, leng_cb, unit_cb, R, R), 
        each pack_one(min_r, center, nv, sinc, leng_cc, unit_cc, R, R), 
    ];    
    