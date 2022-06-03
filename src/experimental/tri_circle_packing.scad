use <triangle/tri_incenter.scad>;
use <ptf/ptf_rotate.scad>;

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

function tri_circle_packing(t, min_r) =
    let(
        center = tri_incenter(t),
        s1 = t[1] - t[0],
        s2 = t[2] - t[1],
        s3 = t[0] - t[2],
        R = abs(cross(s1, s2)) / (norm(s1) + norm(s2) + norm(s3)),

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
        
        pack_one = function(sinv, leng_cv, unit_cv, pre_leng = R, pre_r = R) 
            let(
                r2 = r2(sinv, leng_cv, pre_leng),
                leng = pre_leng + r2,
                r2_ct = center - unit_cv * leng,

                r3 = c3_r(pre_r, r2),
                a = c3_a(pre_r, r2, r3),
                vta = unit_cv * (r3 + r2),
                r3_ct1 = r2_ct + ptf_rotate(vta, a),
                r3_ct2 = r2_ct + ptf_rotate(vta, -a)           
            )
            r2 > min_r ? 
                concat(
                    [[r2_ct, r2], if(r3 > min_r) each [[r3_ct1, r3], [r3_ct2, r3]]], 
                    pack_one(sinv, leng_cv, unit_cv, r2 + leng, r2)
                )
                : []
    )
    [
        [center, R], 
        each pack_one(sina, leng_ca, unit_ca), 
        each pack_one(sinb, leng_cb, unit_cb), 
        each pack_one(sinc, leng_cc, unit_cc), 
    ];    
    