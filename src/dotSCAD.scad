
    
/**
 * The dotSCAD library
 * @copyright Justin Lin, 2017
 * @license https://opensource.org/licenses/lgpl-3.0.html
 *
 * @see https://github.com/JustinSDK/dotSCAD
*/

function __angy_angz(p1, p2) = 
    let(
        dx = p2[0] - p1[0],
        dy = p2[1] - p1[1],
        dz = p2[2] - p1[2],
        ya = atan2(dz, sqrt(dx * dx + dy * dy)),
        za = atan2(dy, dx)
    ) [ya, za];

/**
* voronoi2d.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-voronoi2d.html
*
**/

module voronoi2d(points, spacing = 1, r = 0, delta = 0, chamfer = false, region_type = "square") {
    xs = [for(p = points) p[0]];
    ys = [for(p = points) abs(p[1])];

    region_size = max([(max(xs) -  min(xs) / 2), (max(ys) -  min(ys)) / 2]);    
    half_region_size = 0.5 * region_size; 
    offset_leng = spacing * 0.5 + half_region_size;

    function normalize(v) = v / norm(v);
    
    module region(pt) {
        intersection_for(p = points) {
            if(pt != p) {
                v = p - pt;
                translate((pt + p) / 2 - normalize(v) * offset_leng)
                rotate(atan2(v[1], v[0])) 
                if(region_type == "square") {
                    square(region_size, center = true);
                }
                else if(region_type == "circle") {
                    circle(region_size / 2);
                }       
            }
        }
    }    
    
    for(p = points) {	
        if(r != 0) {        
            offset(r) region(p);
        }
        else {
            offset(delta = delta, chamfer = chamfer) region(p);
        }
    }
}

/**
* shape_ellipse.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_ellipse.html
*
**/


function shape_ellipse(axes) =
    let(
        frags = __frags(axes[0]),
        step_a = 360 / frags,
        a_end = 360 - step_a,
        shape_pts = [
            for(a = 0; a <= a_end; a = a + step_a) 
                [axes[0] * cos(a), axes[1] * sin(a)]
        ]
    ) shape_pts;

/**
* bezier_curve.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bezier_curve.html
*
**/ 


function _combi(n, k) =
    let(  
        bi_coef = [      
               [1],     // n = 0: for padding
              [1,1],    // n = 1: for Linear curves, how about drawing a line directly?
             [1,2,1],   // n = 2: for Quadratic curves
            [1,3,3,1]   // n = 3: for Cubic Bézier curves
        ]  
    )
    n < len(bi_coef) ? bi_coef[n][k] : (
        k == 0 ? 1 : (_combi(n, k - 1) * (n - k + 1) / k)
    );
        
function bezier_curve_coordinate(t, pn, n, i = 0) = 
    i == n + 1 ? 0 : 
        (_combi(n, i) * pn[i] * pow(1 - t, n - i) * pow(t, i) + 
            bezier_curve_coordinate(t, pn, n, i + 1));
        
function _bezier_curve_point(t, points) = 
    let(n = len(points) - 1) 
    [
        bezier_curve_coordinate(
            t, 
            [for(p = points) p[0]], 
            n
        ),
        bezier_curve_coordinate(
            t,  
            [for(p = points) p[1]], 
            n
        ),
        bezier_curve_coordinate(
            t, 
            [for(p = points) p[2]], 
            n
        )
    ];

function bezier_curve(t_step, points) = 
    let(
        t_end = ceil(1 / t_step),
        pts = concat([
            for(t = 0; t < t_end; t = t + 1)
                _bezier_curve_point(t * t_step, points)
        ], [_bezier_curve_point(1, points)])
    ) 
    len(points[0]) == 3 ? pts : [for(pt = pts) __to2d(pt)];


/**
* shape_taiwan.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_taiwan.html
*
**/

function shape_taiwan(h, distance = 0) = 
    let(
        tw = [[3.85724, 6.24078], [3.7902, 6.25779], [3.73596, 6.26288], [3.62807, 6.24587], [3.59581, 6.2602], [3.55429, 6.32386], [3.51698, 6.4571], [3.50768, 6.5361], [3.51188, 6.58284], [3.53917, 6.63708], [3.48981, 6.66934], [2.78286, 6.83905], [2.7218, 6.86112], [2.68441, 6.90272], [2.61063, 6.96209], [2.64288, 7.05549], [2.61062, 7.06568], [2.56396, 7.06058], [2.50281, 7.04109], [2.44849, 7.15647], [2.29319, 7.37123], [2.22438, 7.42555], [2.05644, 7.44248], [1.88674, 7.40509], [1.73901, 7.32879], [1.63795, 7.238], [1.58868, 7.14974], [1.54463, 7.0555], [1.5149, 7.0411], [1.48526, 7.01895], [1.53658, 6.9725], [1.58825, 6.92909], [1.63096, 6.86281], [1.61348, 6.80387], [1.57757, 6.83721], [1.53949, 6.89116], [1.48525, 6.87393], [1.43851, 6.87393], [1.40381, 6.86623], [1.37408, 6.85174], [1.28068, 6.77282], [1.20682, 6.7457], [0.723984, 6.65659], [0.586451, 6.60741], [0.5152, 6.57094], [0.458435, 6.52167], [0.393838, 6.47922], [0.108666, 6.38843], [-0.002506, 6.2925], [-0.110307, 6.16693], [-0.278327, 5.89785], [-0.312266, 5.80452], [-0.319942, 5.74076], [-0.35978, 5.72804], [-0.398773, 5.69411], [-0.431113, 5.64921], [-0.443073, 5.60508], [-0.45317, 5.54563], [-0.477762, 5.51429], [-0.504966, 5.48196], [-0.527025, 5.4379], [-0.511683, 5.32413], [-0.544022, 5.28008], [-0.630518, 5.10523], [-0.652506, 5.02118], [-0.721317, 4.96517], [-0.751047, 4.87851], [-0.807895, 4.81922], [-0.849502, 4.76313], [-0.835106, 4.67916], [-0.94535, 4.70123], [-1.03193, 4.67664], [-1.10318, 4.62476], [-1.16685, 4.55856], [-1.18724, 4.52125], [-1.20679, 4.47981], [-1.23643, 4.44755], [-1.33927, 4.41782], [-1.36462, 4.37621], [-1.38844, 4.28037], [-1.47747, 4.11993], [-1.51477, 4.03419], [-1.52674, 3.93321], [-1.55638, 3.87122], [-1.87389, 3.52162], [-1.92308, 3.43757], [-1.96721, 3.28479], [-2.11055, 3.03862], [-2.15224, 2.84946], [-2.18703, 2.75092], [-2.23874, 2.70864], [-2.2481, 2.65676], [-2.43313, 2.44284], [-2.47482, 2.40393], [-2.48998, 2.36148], [-2.49681, 2.20617], [-2.51727, 2.15951], [-2.59526, 2.09828], [-2.61312, 2.05583], [-2.62237, 2.00926], [-2.64705, 1.98728], [-2.68183, 1.97279], [-2.71915, 1.94559], [-2.76589, 1.90137], [-2.80741, 1.82768], [-2.89576, 1.58074], [-2.9601, 1.46267], [-3.00171, 1.34223], [-3.03396, 1.29978], [-3.14261, 1.19451], [-3.16223, 1.14945], [-3.18683, 1.04173], [-3.21142, 0.994987], [-3.30988, 0.906048], [-3.32504, 0.864443], [-3.42105, 0.738702], [-3.43797, 0.692212], [-3.47452, 0.558807], [-3.54409, 0.411083], [-3.62553, 0.283068], [-3.69434, 0.142925], [-3.72407, -0.047077], [-3.71634, -0.135425], [-3.67474, -0.317847], [-3.65948, -0.475761], [-3.62302, -0.539348], [-3.61029, -0.588533], [-3.62554, -0.628538], [-3.65703, -0.687068], [-3.61029, -0.73878], [-3.64002, -0.795629], [-3.57542, -0.918676], [-3.67902, -1.14784], [-3.62553, -1.18944], [-3.59589, -1.2046], [-3.60515, -1.24376], [-3.6476, -1.28781], [-3.68162, -1.37186], [-3.72138, -1.38205], [-3.74597, -1.40925], [-3.79785, -1.54426], [-3.80458, -1.58157], [-3.81731, -1.61121], [-3.84956, -1.65526], [-3.87677, -1.70958], [-3.8665, -1.75893], [-3.84714, -1.80812], [-3.83434, -1.86665], [-3.85397, -1.90666], [-3.89633, -1.91845], [-3.93532, -1.94052], [-3.94552, -2.0025], [-3.90315, -2.05169], [-3.83687, -2.10846], [-3.91452, -2.12525], [-3.92486, -2.16746], [-3.8021, -2.21718], [-3.78004, -2.24169], [-3.79537, -2.28599], [-3.84194, -2.30292], [-3.9014, -2.31052], [-3.94553, -2.3325], [-3.90902, -2.38984], [-3.81228, -2.42599], [-3.7487, -2.45311], [-3.7359, -2.49042], [-3.61032, -2.51249], [-3.51439, -2.52698], [-3.49737, -2.60598], [-3.53645, -2.69921], [-3.61031, -2.75101], [-3.55085, -2.813], [-3.52197, -2.86732], [-3.47455, -3.17194], [-3.46268, -3.20175], [-3.42108, -3.27805], [-3.36173, -3.36723], [-3.3667, -3.40353], [-3.39137, -3.45802], [-3.39137, -3.50468], [-3.37605, -3.57332], [-3.3048, -3.72879], [-3.22849, -3.84755], [-3.18689, -3.9332], [-3.16473, -4.02239], [-3.18175, -4.08606], [-3.21401, -4.15723], [-3.18942, -4.22848], [-3.1377, -4.29316], [-2.99756, -4.4237], [-2.91612, -4.51458], [-2.85675, -4.62575], [-2.84478, -4.76572], [-2.64282, -4.92119], [-2.55624, -4.90831], [-2.51219, -4.92877], [-2.47733, -4.95075], [-2.40355, -5.01441], [-2.33222, -5.06116], [-2.17691, -5.13485], [-2.10053, -5.19944], [-2.05126, -5.27328], [-2.00199, -5.30293], [-1.87641, -5.40147], [-1.84416, -5.44552], [-1.77804, -5.59577], [-1.69399, -5.70181], [-1.66687, -5.74611], [-1.35963, -6.53694], [-1.36899, -6.58351], [-1.4063, -6.638], [-1.41556, -6.68466], [-1.41556, -6.84915], [-1.42322, -6.93076], [-1.41556, -6.96992], [-1.33, -7.11073], [-1.34945, -7.21845], [-1.34692, -7.25315], [-1.28999, -7.29989], [-1.23921, -7.31522], [-1.20181, -7.27783], [-1.19675, -7.17685], [-1.07362, -7.20658], [-0.953101, -7.2609], [-0.849593, -7.33982], [-0.778259, -7.44248], [-0.775729, -7.35413], [-0.795186, -7.21416], [-0.797786, -7.08606], [-0.736641, -7.02913], [-0.685014, -6.99014], [-0.645009, -6.89851], [-0.620417, -6.78565], [-0.637343, -5.77062], [-0.612751, -5.52192], [-0.590692, -5.43534], [-0.443136, -5.1799], [-0.371802, -4.92362], [-0.341989, -4.73344], [-0.29036, -4.64283], [-0.16723, -4.48735], [-0.128151, -4.41105], [-0.046711, -4.20395], [-0.014539, -4.16235], [0.027066, -4.14297], [0.191803, -3.96039], [0.441265, -3.79565], [0.515127, -3.72608], [0.588904, -3.63285], [0.62032, -3.58105], [0.640788, -3.5317], [0.643228, -3.48757], [0.633124, -3.39173], [0.640794, -3.35189], [0.689979, -3.29336], [0.9039, -3.11338], [0.923353, -3.07093], [1.08363, -2.84522], [1.11605, -2.75342], [1.16262, -2.55407], [1.23396, -2.42344], [1.26116, -2.33518], [1.27809, -2.30031], [1.31035, -2.26637], [1.38421, -2.21213], [1.41638, -2.17987], [1.49024, -2.02701], [1.50464, -1.87935], [1.50212, -1.72405], [1.52671, -1.54937], [1.55897, -1.45589], [1.59897, -1.37942], [1.70669, -1.23616], [1.74147, -1.16044], [1.98243, 0.226167], [2.05637, 0.376416], [2.18195, 0.989965], [2.27788, 1.25316], [2.32959, 1.50186], [2.33469, 1.60107], [2.34741, 1.65447], [2.40173, 1.74366], [2.42118, 1.79798], [2.38391, 1.88363], [2.36176, 1.9185], [2.33473, 1.99994], [2.33213, 2.07136], [2.3542, 2.13747], [2.46798, 2.30473], [2.51203, 2.49221], [2.55625, 2.58553], [2.59356, 2.62284], [2.71147, 2.72138], [2.69968, 2.75364], [2.72175, 2.78497], [2.793, 2.8419], [2.89145, 2.97513], [2.98064, 3.06078], [2.97805, 3.26778], [2.98485, 3.3638], [2.99757, 3.41297], [3.01702, 3.44775], [3.03412, 3.48936], [3.02732, 3.59547], [3.03152, 3.64474], [3.14008, 3.76771], [3.23348, 3.82464], [3.27332, 3.8611], [3.26572, 3.90356], [3.23852, 3.94517], [3.22673, 3.98929], [3.23343, 4.02904], [3.32515, 4.08085], [3.33955, 4.16659], [3.31748, 4.26758], [3.2784, 4.34405], [3.3056, 4.3635], [3.37526, 4.38649], [3.39869, 4.42513], [3.32514, 4.42541], [3.22669, 4.4874], [3.17237, 4.58324], [3.16977, 4.70636], [3.19192, 4.7675], [3.19432, 4.8294], [3.14261, 5.06624], [3.14001, 5.17909], [3.14781, 5.29709], [3.1724, 5.41583], [3.20634, 5.51943], [3.25384, 5.59329], [3.54153, 5.94036], [3.62558, 6.01431], [3.94553, 6.17215], [3.91327, 6.21106]] / 15 * h,
        leng = len(tw)
    )
    distance == 0 ? tw : [for(i = 0; i < leng; i = i + 1) if(norm(tw[i] - tw[i + 1]) >  distance) tw[i]]; 


/**
* t3d.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-t3d.html
*
**/ 

function _t3d_x(pt) = pt[0];
function _t3d_y(pt) = pt[1];
function _t3d_z(pt) = pt[2];

function _t3d_pt3D(x, y, z) = [x, y, z];

function _t3d_create(pt, unit_vts) = 
    [
        is_undef(pt) ? _t3d_pt3D(0, 0, 0) : pt, 
        is_undef(unit_vts) ? [_t3d_pt3D(1, 0, 0), _t3d_pt3D(0, 1, 0), _t3d_pt3D(0, 0, 1)] : unit_vts
    ];

function _t3d_plus(pt, n) = 
    _t3d_pt3D(_t3d_x(pt) + n, _t3d_y(pt) + n, _t3d_z(pt) + n);
function _t3d_minus(pt, n) = 
    _t3d_pt3D(_t3d_x(pt) - n, _t3d_y(pt) - n, _t3d_z(pt) + n);
function _t3d_mlt(pt, n) = 
    _t3d_pt3D(_t3d_x(pt) * n, _t3d_y(pt) * n, _t3d_z(pt) * n);
function _t3d_div(pt, n) = 
    _t3d_pt3D(_t3d_x(pt) / n, _t3d_y(pt) / n, _t3d_z(pt) / n);
function _t3d_neg(pt, n) = 
    _t3d_mlt(pt, -1);

function _t3d_ptPlus(pt1, pt2) = 
    _t3d_pt3D(
        _t3d_x(pt1) + _t3d_x(pt2), 
        _t3d_y(pt1) + _t3d_y(pt2), 
        _t3d_z(pt1) + _t3d_z(pt2)
    );

function _t3d_pt(turtle) = turtle[0];
function _t3d_unit_vts(turtle) = turtle[1];

// forward the turtle in the x' direction
function _t3d_xu_forward(turtle, leng) = _t3d_create(
    _t3d_ptPlus(_t3d_pt(turtle), _t3d_mlt(_t3d_unit_vts(turtle)[0], leng)),
    _t3d_unit_vts(turtle)
);

// forward the turtle in the y' direction
function _t3d_yu_forward(turtle, leng) = _t3d_create(
    _t3d_ptPlus(_t3d_pt(turtle), _t3d_mlt(_t3d_unit_vts(turtle)[1], leng)),
    _t3d_unit_vts(turtle)
);

// forward the turtle in the z' direction
function _t3d_zu_forward(turtle, leng) = _t3d_create(
    _t3d_ptPlus(
        _t3d_pt(turtle), 
        _t3d_mlt(_t3d_unit_vts(turtle)[2], leng)
    ),
    _t3d_unit_vts(turtle)
);

// turn the turtle around the x'-axis
// return a new unit vector
function _t3d_xu_turn(turtle, a) = 
    let(cosa = cos(a), sina = sin(a))
    _t3d_create(
        _t3d_pt(turtle),
        [
            _t3d_unit_vts(turtle)[0], 
            _t3d_ptPlus(
                _t3d_mlt(_t3d_unit_vts(turtle)[1], cosa), 
                _t3d_mlt(_t3d_unit_vts(turtle)[2], sina)
            ), 
            _t3d_ptPlus(
                _t3d_mlt(_t3d_neg(_t3d_unit_vts(turtle)[1]), sina), 
                _t3d_mlt(_t3d_unit_vts(turtle)[2], cosa)
            )
        ]
    );

// turn the turtle around the y'-axis
// return a new unit vector
function _t3d_yu_turn(turtle, a) = 
    let(cosa = cos(a), sina = sin(a))
    _t3d_create(
        _t3d_pt(turtle),
        [
            _t3d_ptPlus(
                _t3d_mlt(_t3d_unit_vts(turtle)[0], cosa), 
                _t3d_mlt(_t3d_neg(_t3d_unit_vts(turtle)[2]), sina)
            ),
            _t3d_unit_vts(turtle)[1], 
            _t3d_ptPlus(
                _t3d_mlt(_t3d_unit_vts(turtle)[0], sina), 
                _t3d_mlt(_t3d_unit_vts(turtle)[2], cosa)
            )
        ]
    );

// turn the turtle around the z'-axis
// return a new unit vector
function _t3d_zu_turn(turtle, a) = 
    let(cosa = cos(a), sina = sin(a))
    _t3d_create(
        _t3d_pt(turtle),
        [
            _t3d_ptPlus(
                _t3d_mlt(_t3d_unit_vts(turtle)[0], cosa), 
                _t3d_mlt(_t3d_unit_vts(turtle)[1], sina)
            ),
            _t3d_ptPlus(
                _t3d_mlt(_t3d_neg(_t3d_unit_vts(turtle)[0]), sina), 
                _t3d_mlt(_t3d_unit_vts(turtle)[1], cosa)
            ),
            _t3d_unit_vts(turtle)[2], 
        ]
    );
    
function _t3d_set_point(t, point) = 
    _t3d_create(point, _t3d_unit_vts(t));

function _t3d_set_unit_vectors(t, unit_vectors) =
    _t3d_create(_t3d_pt(t), unit_vectors);

function _t3d_get(t, cmd) = 
    cmd == "point" ? _t3d_pt(t) : 
    cmd == "unit_vectors" ? _t3d_unit_vts(t) : 
    assert(false, "unknown command");

function _t3d_set(t, point, unit_vectors) = 
    !is_undef(point) ? _t3d_set_point(t, point) :
    !is_undef(unit_vectors) ? _t3d_set_unit_vectors(t, unit_vectors) :
    assert(false, "no target to set");

function _t3d_cmd(t, cmd, point, unit_vectors, leng, angle) = 
    cmd == "xforward" ? _t3d_xu_forward(t, leng) : 
    cmd == "yforward" ? _t3d_yu_forward(t, leng) : 
    cmd == "zforward" ? _t3d_zu_forward(t, leng) : 
    cmd == "xturn" ? _t3d_xu_turn(t, angle) : 
    cmd == "yturn" ? _t3d_yu_turn(t, angle) : 
    cmd == "zturn" ? _t3d_zu_turn(t, angle) : 
    _t3d_get(t, cmd);

function _t3d_cmdline(cmd, t, arg) = 
    is_undef(arg) ? _t3d_get(t, cmd) : 
    cmd == "xforward" ? _t3d_xu_forward(t, arg) : 
    cmd == "yforward" ? _t3d_yu_forward(t, arg) : 
    cmd == "zforward" ? _t3d_zu_forward(t, arg) : 
    cmd == "xturn" ? _t3d_xu_turn(t, arg) : 
    cmd == "yturn" ? _t3d_yu_turn(t, arg) : 
    cmd == "zturn" ? _t3d_zu_turn(t, arg) : 
    cmd == "point" ? _t3d_set_point(t, point) : 
    cmd == "unit_vectors" ? _t3d_set_unit_vectors(t, unit_vectors) :  
    assert(false, "unknown command");

function _t3d_cmds(t, cmds, i = 0) = 
    i == len(cmds) ? t :
    let(
        cmd = cmds[i][0],
        arg = cmds[i][1]
    )
    _t3d_cmds(_t3d_cmdline(cmd, t, arg), cmds, i + 1);

function t3d(t, cmd, point, unit_vectors, leng, angle) =
    is_undef(t) ? _t3d_create(point, unit_vectors) :
    is_undef(cmd) ? _t3d_set(t, point, unit_vectors) :
    is_string(cmd) ? _t3d_cmd(t, cmd, point, unit_vectors, leng, angle) :
                     _t3d_cmds(t, cmd);

/**
* in_shape.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-in_shape.html
*
**/


function _in_shape_in_line_equation(edge, pt) = 
    let(
        x1 = edge[0][0],
        y1 = edge[0][1],
        x2 = edge[1][0],
        y2 = edge[1][1],
        a = (y2 - y1) / (x2 - x1),
        b = y1 - a * x1
    )
    (pt[1] == a * pt[0] + b);

function _in_shape_in_any_edges(edges, pt, epsilon) = 
    let(
        leng = len(edges),
        maybe_last = [for(i = 0; i < leng && !__in_line(edges[i], pt, epsilon); i = i + 1) i][leng - 1] 
    )
    is_undef(maybe_last);

function _in_shape_interpolate_x(y, p1, p2) = 
    p1[1] == p2[1] ? p1[0] : (
        p1[0] + (p2[0] - p1[0]) * (y - p1[1]) / (p2[1] - p1[1])
    );
    
function _in_shape_does_pt_cross(pts, i, j, pt) = 
    ((pts[i][1] > pt[1]) != (pts[j][1] > pt[1])) &&
    (pt[0] < _in_shape_interpolate_x(pt[1], pts[i], pts[j]));
    

function _in_shape_sub(shapt_pts, leng, pt, cond, i, j) =
    j == leng ? cond : (
        _in_shape_does_pt_cross(shapt_pts, i, j, pt) ? 
            _in_shape_sub(shapt_pts, leng, pt, !cond, j, j + 1) :
            _in_shape_sub(shapt_pts, leng, pt, cond, j, j + 1)
    );
 
function in_shape(shapt_pts, pt, include_edge = false, epsilon = 0.0001) = 
    let(
        leng = len(shapt_pts),
        edges = __lines_from(shapt_pts, true)
    )
    _in_shape_in_any_edges(edges, pt, epsilon) ? include_edge : 
    _in_shape_sub(shapt_pts, leng, pt, false, leng - 1, 0);

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

/**
* sphere_spiral.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-sphere_spiral.html
*
**/ 

function sphere_spiral(radius, za_step, z_circles = 1, begin_angle = 0, end_angle = 0, vt_dir = "SPI_DOWN", rt_dir = "CT_CLK") = 
    let(
        a_end = 90 * z_circles - end_angle
    )
    [
        for(a = begin_angle; a <= a_end; a = a + za_step) 
            let(
                ya = vt_dir == "SPI_DOWN" ? (-90 + 2 * a / z_circles) : (90 + 2 * a / z_circles),
                za = (rt_dir == "CT_CLK" ? 1 : -1) * a,
                ra = [0, ya, za]
            )
            [rotate_p([radius, 0, 0], ra), ra]
    ];

function __shape_pie(radius, angle) =
    let(
        frags = __frags(radius),
        a_step = 360 / frags,
        leng = radius * cos(a_step / 2),
        angles = is_num(angle) ? [0:angle] : angle,
        m = floor(angles[0] / a_step) + 1,
        n = floor(angles[1] / a_step),
        edge_r_begin = leng / cos((m - 0.5) * a_step - angles[0]),
        edge_r_end = leng / cos((n + 0.5) * a_step - angles[1]),
        shape_pts = concat(
            [[0, 0], __ra_to_xy(edge_r_begin, angles[0])],
            m > n ? [] : [
                for(i = m; i <= n; i = i + 1)
                    let(a = a_step * i) 
                    __ra_to_xy(radius, a)
            ],
            angles[1] == a_step * n ? [] : [__ra_to_xy(edge_r_end, angles[1])]
        )
    ) shape_pts;

/**
* px_cylinder.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_cylinder.html
*
**/ 

function _px_cylinder_px_circle(radius, filled, thickness) = 
    let(range = [-radius: radius - 1])
    filled ? [
        for(y = range)        
           for(x = range)
               let(v = [x, y])
               if(norm(v) < radius) v
    ] :
    let(ishell = radius * radius - 2 * thickness * radius)
    [
        for(y = range)        
           for(x = range)
               let(
                   v = [x, y],
                   leng = norm(v)
               )
               if(leng < radius && (leng * leng) > ishell) v    
    ];

function _px_cylinder_diff_r(r, h, filled, thickness) =
    let(
        r1 = r[0],
        r2 = r[1]
    )
    r1 == r2 ? _px_cylinder_same_r(r1, h, filled, thickness) :
    let(dr = (r2 - r1) / (h - 1))
    [
        for(i = 0; i < h; i = i + 1)
        let(r = round(r1 + dr * i))
        each [
            for(pt = _px_cylinder_px_circle(r, filled, thickness))
            [pt[0], pt[1], i]
        ]
    ]; 

function _px_cylinder_same_r(r, h, filled, thickness) =
    let(c = _px_cylinder_px_circle(r, filled, thickness))
    [
        for(i = 0; i < h; i = i + 1)
        each [
            for(pt = c)
            [pt[0], pt[1], i]
        ]
    ]; 

function px_cylinder(r, h, filled = false, thickness = 1) =
    is_num(r) ? 
        _px_cylinder_same_r(r, h, filled, thickness) :
        _px_cylinder_diff_r(r, h, filled, thickness); 

function __in_line(line_pts, pt, epsilon = 0.0001) =
    let(
        pts = len(line_pts[0]) == 2 ? [for(p = line_pts) __to3d(p)] : line_pts,
        pt3d = len(pt) == 2 ? __to3d(pt) : pt,
        v1 = pts[0] - pt3d, 
        v2 = pts[1] - pt3d
    )
    (norm(cross(v1, v2)) < epsilon) && ((v1 * v2) <= epsilon);

/**
* reverse.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-rand.html
*
**/ 

function rand(min_value = 0, max_value = 1, seed_value) = 
    is_undef(seed_value) ? rands(min_value, max_value , 1)[0] : rands(min_value, max_value , 1, seed_value)[0];

/**
* polyline3d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polyline3d.html
*
**/

module polyline3d(points, thickness, startingStyle = "CAP_CIRCLE", endingStyle = "CAP_CIRCLE") {
    leng_pts = len(points);
    
    s_styles = [startingStyle, "CAP_BUTT"];
    e_styles = ["CAP_SPHERE", endingStyle];
    default_styles = ["CAP_SPHERE", "CAP_BUTT"];

    module line_segment(index) {
        styles = index == 1 ? s_styles : 
                 index == leng_pts - 1 ? e_styles : 
                 default_styles;

        p1 = points[index - 1];
        p2 = points[index];
        p1Style = styles[0];
        p2Style = styles[1];        
        
        line3d(p1, p2, thickness, 
               p1Style = p1Style, p2Style = p2Style);

        // hook for testing
        test_line3d_segment(index, p1, p2, thickness, p1Style, p2Style);               
    }

    module polyline3d_inner(index) {
        if(index < leng_pts) {
            line_segment(index);
            polyline3d_inner(index + 1);
        }
    }

    polyline3d_inner(1);
}

// override it to test
module test_line3d_segment(index, point1, point2, thickness, p1Style, p2Style) {

}

/**
* starburst.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-starburst.html
*
**/

module starburst(r1, r2, n, height) {
    a = 180 / n;

    p0 = [0, 0, 0];
    p1 = [r2 * cos(a), r2 * sin(a), 0];
    p2 = [r1, 0, 0];
    p3 = [0, 0, height];

    module half_burst() {
        polyhedron(points = [p0, p1, p2, p3], 
            faces = [
                [0, 2, 1],
                [0, 1, 3],
                [0, 3, 2], 
                [2, 1, 3]
            ]
        );
    }

    module burst() {
        hull() {
            half_burst();
            mirror([0, 1,0]) half_burst();
        }
    }

    for(i = [0 : n - 1]) {
        rotate(2 * a * i) burst();
    }    
}

/**
* line3d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-line3d.html
*
**/


module line3d(p1, p2, thickness, p1Style = "CAP_CIRCLE", p2Style = "CAP_CIRCLE") {
    r = thickness / 2;

    frags = __nearest_multiple_of_4(__frags(r));
    half_fa = 180 / frags;
    
    dx = p2[0] - p1[0];
    dy = p2[1] - p1[1];
    dz = p2[2] - p1[2];
    
    length = sqrt(pow(dx, 2) + pow(dy, 2) + pow(dz, 2));
    ay = 90 - atan2(dz, sqrt(pow(dx, 2) + pow(dy, 2)));
    az = atan2(dy, dx);

    angles = [0, ay, az];

    module cap_with(p) { 
        translate(p) 
        rotate(angles) 
            children();  
    } 

    module cap_butt() {
        cap_with(p1)                 
            linear_extrude(length) 
                circle(r, $fn = frags);
        
        // hook for testing
        test_line3d_butt(p1, r, frags, length, angles);
    }

    module cap(p, style) {
        if(style == "CAP_CIRCLE") {
            cap_leng = r / 1.414;
            cap_with(p) 
            linear_extrude(cap_leng * 2, center = true) 
                circle(r, $fn = frags);

            // hook for testing
            test_line3d_cap(p, r, frags, cap_leng, angles);
        } else if(style == "CAP_SPHERE") { 
            cap_leng = r / cos(half_fa);
            cap_with(p)
                sphere(cap_leng, $fn = frags);  
            
            // hook for testing
            test_line3d_cap(p, r, frags, cap_leng, angles);
        }            
    }


    cap_butt();
    cap(p1, p1Style);
    cap(p2, p2Style);
}

// Override them to test
module test_line3d_butt(p, r, frags, length, angles) {

}

module test_line3d_cap(p, r, frags, cap_leng, angles) {
    
}

function __to_degree(phi) = 180 / PI * phi;

/**
* circle_path.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-circle_path.html
*
**/


function circle_path(radius, n) =
    let(
        _frags = __frags(radius),
        step_a = 360 / _frags,
        end_a = 360 - step_a * ((is_undef(n) || n > _frags) ? 1 : _frags - n + 1)
    )
    [
        for(a = 0; a <= end_a; a = a + step_a)
            [radius * cos(a), radius * sin(a)]
    ];


function __to2d(p) = [p[0], p[1]];

/**
* m_mirror.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-m_mirror.html
*
**/

function m_mirror(v) = 
    let(
        nv = v / norm(v),
        txx = -2* nv[0] * nv[0],
        txy = -2* nv[0] * nv[1],
        txz = -2* nv[0] * nv[2],
        tyy = -2* nv[1] * nv[1],
        tyz = -2* nv[1] * nv[2],
        tzz = -2* nv[2] * nv[2]
    )
    [
        [1 + txx, txy, txz, 0],
        [txy, 1 + tyy, tyz, 0],
        [txz, tyz, 1 + tzz, 0],
        [0, 0, 0, 1]
    ];

/**
* shape_superformula.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_superformula.html
*
**/ 


function _superformula_r(angle, m1, m2, n1, n2 = 1, n3 = 1, a = 1, b = 1) = 
    pow(
        pow(abs(cos(m1 * angle / 4) / a), n2) + 
        pow(abs(sin(m2 * angle / 4) / b), n3),
        - 1 / n1    
    );

function shape_superformula(phi_step, m1, m2, n1, n2 = 1, n3 = 1, a = 1, b = 1) = 
   let(tau = PI * 2)
   [
        for(phi = 0; phi <= tau; phi = phi + phi_step) 
            let(
                angle = __to_degree(phi),
                r = _superformula_r(angle, m1, m2, n1, n2, n3, a, b)
            )
            __ra_to_xy(r, angle)
   ];

/**
* arc.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-arc.html
*
**/ 


module arc(radius, angle, width, width_mode = "LINE_CROSS") {
    polygon(__shape_arc(radius, angle, width, width_mode));
}

function __polytransversals(transversals) =
    let(
        leng_trs = len(transversals),
        leng_tr = len(transversals[0]),
        lefts = [
            for(i = 1; i < leng_trs - 1; i = i + 1)
                let(tr = transversals[leng_trs - i])
                    tr[0]
        ],
        rights = [
            for(i = 1; i < leng_trs - 1; i = i + 1)
                let(tr = transversals[i])
                    tr[leng_tr - 1]
        ]
    ) concat(
        transversals[0], 
        rights, 
        __reverse(transversals[leng_trs - 1]), 
        lefts
    );

/**
* helix_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-helix_extrude.html
*
**/


module helix_extrude(shape_pts, radius, levels, level_dist, 
                     vt_dir = "SPI_DOWN", rt_dir = "CT_CLK", 
                     twist = 0, scale = 1.0, triangles = "SOLID") {

    function reverse(vt) = 
        let(leng = len(vt))
        [
            for(i = 0; i < leng; i = i + 1)
                vt[leng - 1 - i]
        ];                         
                         
    is_flt = is_num(radius);
    r1 = is_flt ? radius : radius[0];
    r2 = is_flt ? radius : radius[1];
    
    init_r = vt_dir == "SPI_DOWN" ? r2 : r1;

    frags = __frags(init_r);

    v_dir = vt_dir == "SPI_UP" ? 1 : -1;
    r_dir = rt_dir == "CT_CLK" ? 1 : -1;
            
    angle_step = 360 / frags * r_dir;
    initial_angle = atan2(level_dist / frags, PI * 2 * init_r / frags) * v_dir * r_dir;

    path_points = helix(
        radius = radius, 
        levels = levels, 
        level_dist = level_dist, 
        vt_dir = vt_dir, 
        rt_dir = rt_dir
    );

    clk_a = r_dir == 1 ? 0 : 180;
    ax = 90 + initial_angle;
    angles = [
        for(i = 0; i < len(path_points); i = i + 1) 
            [ax, 0, clk_a + angle_step * i]
    ];
    
    sections = cross_sections(shape_pts, path_points, angles, twist, scale);

    polysections(
        sections,
        triangles = triangles
    );
    
    // hook for testing
    test_helix_extrude(sections);
}

// override it to test
module test_helix_extrude(sections) {

}

function __frags(radius) = $fn > 0 ? 
            ($fn >= 3 ? $fn : 3) : 
            max(min(360 / $fa, radius * PI * 2 / $fs), 5);

/**
* shape_square.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_square.html
*
**/

 
function shape_square(size, corner_r = 0) = 
    let(
        is_flt = is_num(size),
        x = is_flt ? size : size[0],
        y = is_flt ? size : size[1]        
    )
    __trapezium(
        length = x, 
        h = y, 
        round_r = corner_r
    );
    

/**
* turtle2d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-turtle2d.html
*
**/ 

function _turtle2d_turtle(x, y, angle) = [[x, y], angle];

function _turtle2d_set_point(turtle, point) = [point, _turtle2d_get_angle(turtle)];

function _turtle2d_set_x(turtle, x) = [[x, _turtle2d_get_y(turtle)], _turtle2d_get_angle(turtle)];
function _turtle2d_set_y(turtle, y) = [[_turtle2d_get_x(turtle), y], _turtle2d_get_angle(turtle)];
function _turtle2d_set_angle(turtle, angle) = [_turtle2d_get_pt(turtle), angle];

function _turtle2d_forward(turtle, leng) = 
    _turtle2d_turtle(
        _turtle2d_get_x(turtle) + leng * cos(_turtle2d_get_angle(turtle)), 
        _turtle2d_get_y(turtle) + leng * sin(_turtle2d_get_angle(turtle)), 
        _turtle2d_get_angle(turtle)
    );

function _turtle2d_turn(turtle, angle) = [_turtle2d_get_pt(turtle), _turtle2d_get_angle(turtle) + angle];

function _turtle2d_get_x(turtle) = turtle[0][0];
function _turtle2d_get_y(turtle) = turtle[0][1];
function _turtle2d_get_pt(turtle) = turtle[0];
function _turtle2d_get_angle(turtle) = turtle[1];

function _turtle2d_three_args_command(cmd, arg1, arg2, arg3) = 
    cmd == "create" ? _turtle2d_turtle(arg1, arg2, arg3) : _turtle2d_two_args_command(cmd, arg1, arg2);

function _turtle2d_two_args_command(cmd, arg1, arg2) =
    is_undef(arg2) ? _turtle2d_one_arg_command(cmd, arg1) : 
    cmd == "pt" ? _turtle2d_set_point(arg1, arg2) : 
    cmd == "x" ? _turtle2d_set_x(arg1, arg2) : 
    cmd == "y" ? _turtle2d_set_y(arg1, arg2) : 
    cmd == "angle" ? _turtle2d_set_angle(arg1, arg2) : 
    cmd == "forward" ? _turtle2d_forward(arg1, arg2) : 
    cmd == "turn" ? _turtle2d_turn(arg1, arg2) : undef;
    
function _turtle2d_one_arg_command(cmd, arg) =
    cmd == "x" ? _turtle2d_get_x(arg) : 
    cmd == "y" ? _turtle2d_get_y(arg) : 
    cmd == "angle" ? _turtle2d_get_angle(arg) : 
    cmd == "pt" ? _turtle2d_get_pt(arg) : undef;

function turtle2d(cmd, arg1, arg2, arg3) = 
    _turtle2d_three_args_command(cmd, arg1, arg2, arg3);


/**
* voronoi3d.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-voronoi3d.html
*
**/


// slow but workable

module voronoi3d(points, space_size = "auto", spacing = 1) {
    xs = [for(p = points) p[0]];
    ys = [for(p = points) abs(p[1])];
    zs = [for(p = points) abs(p[2])];

    space_size = max([max(xs) -  min(xs), max(ys) -  min(ys), max(zs) -  min(zs)]);    
    half_space_size = 0.5 * space_size; 
    offset_leng = spacing * 0.5 + half_space_size;

    function normalize(v) = v / norm(v);
    
    module space(pt) {
        intersection_for(p = points) {
            if(pt != p) {
                v = p - pt;
                ryz = __angy_angz(p, pt);

                translate((pt + p) / 2 - normalize(v) * offset_leng)
                rotate([0, -ryz[0], ryz[1]]) 
                    cube([space_size, space_size * 2, space_size * 2], center = true); 
            }
        }
    }    
    
    for(p = points) {	
        space(p);
    }
}

function __line_intersection(line_pts1, line_pts2, epsilon = 0.0001) = 
    let(
        a1 = line_pts1[0],
        a2 = line_pts1[1],
        b1 = line_pts2[0],
        b2 = line_pts2[1],
        a = a2 - a1, 
        b = b2 - b1, 
        s = b1 - a1
    )
    abs(cross(a, b)) < epsilon ? [] :  // they are parallel or conincident edges
        a1 + a * cross(s, b) / cross(a, b);

function __tr__corner_t_leng_lt_zero(frags, t_sector_angle, l1, l2, h, round_r) = 
    let(t_height = tan(t_sector_angle) * l1 - round_r / sin(90 - t_sector_angle) - h / 2)
    [ 
        for(pt = __pie_for_rounding(round_r, 90 - t_sector_angle, 90, frags * t_sector_angle / 180))
            [pt[0], pt[1] + t_height]
    ];

function __tr_corner_t_leng_gt_or_eq_zero(frags, t_sector_angle, t_leng, h, round_r) = 
    let(offset_y = h / 2 - round_r)
    [
        for(pt = __pie_for_rounding(round_r, 90 - t_sector_angle, 90, frags * t_sector_angle / 360))
            [pt[0] + t_leng, pt[1] + offset_y]
    ];    

function __tr_corner(frags, b_ang, l1, l2, h, round_r) = 
    let(t_leng = l2 - round_r * tan(b_ang / 2))
    t_leng >= 0 ? 
        __tr_corner_t_leng_gt_or_eq_zero(frags, b_ang, t_leng, h, round_r) : 
        __tr__corner_t_leng_lt_zero(frags, b_ang, l1, l2, h, round_r);

function __tr__corner_b_leng_lt_zero(frags, b_sector_angle, l1, l2, h, round_r) = 
    let(
        reversed = __tr__corner_t_leng_lt_zero(frags, b_sector_angle, l2, l1, h, round_r),
        leng = len(reversed)
    )
    [
        for(i = [0:leng - 1])
            let(pt = reversed[leng - 1 - i])
            [pt[0], -pt[1]]
    ];

function __br_corner_b_leng_gt_or_eq_zero(frags, b_sector_angle, l1, l2, b_leng, h, round_r) = 
    let(half_h = h / 2) 
    [
        for(pt = __pie_for_rounding(round_r, -90, -90 + b_sector_angle, frags * b_sector_angle / 360))
            [pt[0] + b_leng, pt[1] + round_r - half_h]
    ];

function __br_corner(frags, b_ang, l1, l2, h, round_r) = 
    let(b_leng = l1 - round_r / tan(b_ang / 2)) 
    b_leng >= 0 ? 
    __br_corner_b_leng_gt_or_eq_zero(frags, 180 - b_ang, l1, l2, b_leng, h, round_r) :
    __tr__corner_b_leng_lt_zero(frags, 180 - b_ang, l1, l2, h, round_r);

function __half_trapezium(length, h, round_r) =
    let(
        is_flt = is_num(length),
        l1 = is_flt ? length : length[0],
        l2 = is_flt ? length : length[1],
        frags = __frags(round_r),
        b_ang = atan2(h, l1 - l2),
        br_corner = __br_corner(frags, b_ang, l1, l2, h, round_r),
        tr_corner = __tr_corner(frags, b_ang, l1, l2, h, round_r)
    )    
    concat(
        br_corner,
        tr_corner
    );

/**
* golden_spiral.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-golden_spiral.html
*
**/ 

function _fast_fibonacci_sub(nth) = 
    let(
        _f = _fast_fibonacci_2_elems(floor(nth / 2)),
        a = _f[0],
        b = _f[1],
        c = a * (b * 2 - a),
        d = a * a + b * b
    ) 
    nth % 2 == 0 ? [c, d] : [d, c + d];

function _fast_fibonacci_2_elems(nth) =
    nth == 0 ? [0, 1] : _fast_fibonacci_sub(nth);
    
function _fast_fibonacci(nth) =
    _fast_fibonacci_2_elems(nth)[0];
    
function _remove_same_pts(pts1, pts2) = 
    pts1[len(pts1) - 1] == pts2[0] ? 
        concat(pts1, [for(i = 1; i < len(pts2); i = i + 1) pts2[i]]) : 
        concat(pts1, pts2);    

function _golden_spiral_from_ls_or_eql_to(from, to, point_distance, rt_dir) = 
    let(
        f1 = _fast_fibonacci(from),
        f2 = _fast_fibonacci(from + 1),
        fn = floor(f1 * 6.28312 / point_distance), 
        $fn = fn + 4 - (fn % 4),
        circle_pts = circle_path(radius = f1, n = $fn / 4 + 1),
        len_pts = len(circle_pts),
        a_step = 360 / $fn * rt_dir,
        range_i = [0:len_pts - 1],
        arc_points_angles = (rt_dir == 1 ? [
            for(i = range_i)
                [circle_pts[i], a_step * i] 
        ] : [
            for(i = range_i) let(idx = len_pts - i - 1)
                [circle_pts[idx], a_step * i] 
        ]),
        offset = f2 - f1
    ) _remove_same_pts(
        arc_points_angles, 
        [
            for(pt_a = _golden_spiral(from + 1, to, point_distance, rt_dir)) 
                [ 
                    rotate_p(pt_a[0], [0, 0, 90 * rt_dir]) + 
                    (rt_dir == 1 ? [0, -offset, 0] : [-offset, 0, 0]), 
                    pt_a[1] + 90 * rt_dir
                ]
        ] 
    ); 

function _golden_spiral(from, to, point_distance, rt_dir) = 
    from <= to ? 
        _golden_spiral_from_ls_or_eql_to(from, to, point_distance, rt_dir) : [];

function golden_spiral(from, to, point_distance, rt_dir = "CT_CLK") =    
    _golden_spiral(from, to, point_distance, (rt_dir == "CT_CLK" ? 1 : -1));

/**
* px_polyline.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_polyline.html
*
**/ 


function px_polyline(points) =
    let(
        is_2d = len(points[0]) == 2,
        pts = is_2d ? [for(pt = points) __to3d(pt)] : points,
        polyline = [for(line =  __lines_from(pts)) each px_line(line[0], line[1])]
    )
    is_2d ? [for(pt = polyline) __to2d(pt)] : polyline;

/**
* parse_number.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-parse_number.html
*
**/ 
    
function _str_to_int(t) =  ord(t) - 48;
    
function _parse_positive_int(t, value = 0, i = 0) =
    i == len(t) ? value : _parse_positive_int(t, value * pow(10, i) + _str_to_int(t[i]), i + 1);

function _parse_positive_decimal(t, value = 0, i = 0) =
    i == len(t) ? value : _parse_positive_decimal(t, value + _str_to_int(t[i]) * pow(10, -(i + 1)), i + 1);
    
function _parse_positive_number(t) =
    len(search(".", t)) == 0 ? _parse_positive_int(t) :
        _parse_positive_int(split_str(t, ".")[0]) + _parse_positive_decimal(split_str(t, ".")[1]);
         
function parse_number(t) = 
    t[0] == "-" ? -_parse_positive_number(sub_str(t, 1, len(t))) : _parse_positive_number(t);



/**
* m_cumulate.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-m_cumulate.html
*
**/

function _m_cumulate(matrice, i) = 
    i == len(matrice) - 2 ?
        matrice[i] * matrice[i + 1] :
        matrice[i] * _m_cumulate(matrice, i + 1);

function m_cumulate(matrice) = 
    len(matrice) == 1 ? matrice[0] : _m_cumulate(matrice, 0);
    


function __pie_for_rounding(r, begin_a, end_a, frags) =
    let(
        sector_angle = end_a - begin_a,
        step_a = sector_angle / frags,
        is_integer = frags % 1 == 0
    )
    r < 0.00005 ? [[0, 0]] : concat([
        for(ang = begin_a; ang <= end_a; ang = ang + step_a)
            [
                r * cos(ang), 
                r * sin(ang)
            ]
    ], 
    is_integer ? [] : [[
            r * cos(end_a), 
            r * sin(end_a)
        ]]
    );

/**
* sub_str.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-sub_str.html
*
**/ 

function _sub_str(t, begin, end) = 
    begin == end ? "" : str(t[begin], sub_str(t, begin + 1, end));
    
function sub_str(t, begin, end) = 
    is_undef(end) ? _sub_str(t, begin, len(t)) : _sub_str(t, begin, end);


/**
* m_shearing.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-m_shearing.html
*
**/


function m_shearing(sx = [0, 0], sy = [0, 0], sz = [0, 0]) = __m_shearing(sx, sy, sz);

function __m_shearing(sx, sy, sz) = 
    let(
        sx_along_y = sx[0],
        sx_along_z = sx[1],
        sy_along_x = sy[0],
        sy_along_z = sy[1],
        sz_along_x = sz[0],
        sz_along_y = sz[1]   
    ) 
    [
        [1, sx_along_y, sx_along_z, 0],
        [sy_along_x, 1, sy_along_z, 0],
        [sz_along_x, sz_along_y, 1, 0],
        [0, 0, 0, 1]
    ];

/**
* shear.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shear.html
*
**/


module shear(sx = [0, 0], sy = [0, 0], sz = [0, 0]) {
    multmatrix(__m_shearing(sx, sy, sz)) children();
}

/**
* bijection_offset.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bijection_offset.html
*
**/

    
function _bijection_inward_edge_normal(edge) =  
    let(
        pt1 = edge[0],
        pt2 = edge[1],
        dx = pt2[0] - pt1[0],
        dy = pt2[1] - pt1[1],
        edge_leng = norm([dx, dy])
    )
    [-dy / edge_leng, dx / edge_leng];

function _bijection_outward_edge_normal(edge) = -1 * _bijection_inward_edge_normal(edge);

function _bijection_offset_edge(edge, dx, dy) = 
    let(
        pt1 = edge[0],
        pt2 = edge[1],
        dxy = [dx, dy]
    )
    [pt1 + dxy, pt2 + dxy];
    
function _bijection__bijection_offset_edges(edges, d) = 
    [ 
        for(edge = edges)
        let(
            ow_normal = _bijection_outward_edge_normal(edge),
            dx = ow_normal[0] * d,
            dy = ow_normal[1] * d
        )
        _bijection_offset_edge(edge, dx, dy)
    ];

function bijection_offset(pts, d, epsilon = 0.0001) = 
    let(
        es = __lines_from(pts, true), 
        offset_es = _bijection__bijection_offset_edges(es, d),
        leng = len(offset_es),
        leng_minus_one = leng - 1,
        last_p = __line_intersection(offset_es[leng_minus_one], offset_es[0], epsilon)
    )
    concat(
        last_p != [] && last_p == last_p ? [last_p] : [],
        [
            for(i = 0; i < leng_minus_one; i = i + 1)
            let(
                this_edge = offset_es[i],
                next_edge = offset_es[i + 1],
                p = __line_intersection(this_edge, next_edge, epsilon)
            )
            // p == p to avoid [nan, nan], because [nan, nan] != [nan, nan]
            if(p != [] && p == p) p
        ]
    );
    

/**
* bend.scad
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bend.html
*
**/ 


module bend(size, angle, frags = 24) {
    x = size[0];
    y = size[1];
    z = size[2];
    frag_width = x / frags;
    frag_angle = angle / frags;
    half_frag_width = 0.5 * frag_width;
    half_frag_angle = 0.5 * frag_angle;
    r = half_frag_width / sin(half_frag_angle);
    h = r * cos(half_frag_angle);
    
    tri_frag_pts = [
        [0, 0], 
        [half_frag_width, h], 
        [frag_width, 0], 
        [0, 0]
    ];

    module triangle_frag() {
        translate([0, -z, 0]) 
        linear_extrude(y) 
            polygon(tri_frag_pts);    
    }
    
    module get_frag(i) {
        translate([-frag_width * i - half_frag_width, -h + z, 0]) 
        intersection() {
            translate([frag_width * i, 0, 0]) 
                triangle_frag();
            rotate([90, 0, 0]) 
                children();
        }
    }

    rotate(90) for(i = [0 : frags - 1]) {
        rotate(i * frag_angle + half_frag_angle) 
        get_frag(i) 
            children();  
    }

    // hook for testing
    test_bend_tri_frag(tri_frag_pts, frag_angle);
}

// override it to test
module test_bend_tri_frag(points, angle) {

}

/**
* polytransversals.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polytransversals.html
*
**/


module polytransversals(transversals) {
    polygon(
        __polytransversals(transversals)
    );
}

/**
* rounded_cylinder.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rounded_cylinder.html
*
**/


module rounded_cylinder(radius, h, round_r, convexity = 2, center = false) {  
    r_corners = __half_trapezium(radius, h, round_r);
    
    shape_pts = concat(
        [[0, -h/2]],
        r_corners,           
        [[0, h/2]]
    );

    center_pt = center ? [0, 0, 0] : [0, 0, h/2];

    translate(center_pt) 
    rotate(180) 
    rotate_extrude(convexity = convexity) 
        polygon(shape_pts);

    // hook for testing
    test_center_half_trapezium(center_pt, shape_pts);
}

// override it to test
module test_center_half_trapezium(center_pt, shape_pts) {
    
}


/**
* rounded_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rounded_extrude.html
*
**/


module rounded_extrude(size, round_r, angle = 90, twist = 0, convexity = 10) {
    is_flt = is_num(size);
    x = is_flt ? size : size[0];
    y = is_flt ? size : size[1];
    
    q_corner_frags = __frags(round_r) / 4;
    
    step_a = angle / q_corner_frags;
    twist_step = twist / q_corner_frags;

    module layers(pre_x, pre_y, pre_h = 0, i = 1) {
        module one_layer(current_a) {
            wx = pre_x;    
            wy = pre_y;
            
            h = (round_r - pre_h) - round_r * cos(current_a);
            
            d_leng = round_r * (sin(current_a) - sin(step_a * (i - 1)));
            
            sx = (d_leng * 2 + wx) / wx;
            sy = (d_leng * 2 + wy) / wy;

            translate([0, 0, pre_h]) 
            rotate(-twist_step * (i - 1)) 
            linear_extrude(
                h, 
                slices = 1, 
                scale = [sx, sy], 
                convexity = convexity, 
                twist = twist_step
            ) 
            scale([wx / x, wy / y]) 
                children();     

            test_rounded_extrude_data(i, wx, wy, pre_h, sx, sy);

            layers(wx * sx, wy * sy, h + pre_h, i + 1)
                children();   
                    
        }    
    
        if(i <= q_corner_frags) {
            one_layer(i * step_a) 
                children();
        } else if(i - q_corner_frags < 1) {
            one_layer(q_corner_frags * step_a) 
                children();
        }
    }
    
    layers(x, y) 
        children();
}

module test_rounded_extrude_data(i, wx, wy, pre_h, sx, sy) {

}

/**
* shape_path_extend.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-path_extend.html
*
**/


function _shape_path_extend_az(p1, p2) = 
    let(
        x1 = p1[0],
        y1 = p1[1],
        x2 = p2[0],
        y2 = p2[1]
    ) -90 + atan2((y2 - y1), (x2 - x1));

function _shape_path_first_stroke(stroke_pts, path_pts) =
    let(
        p1 = path_pts[0],
        p2 = path_pts[1],
        a = _shape_path_extend_az(p1, p2)
    )
    [
        for(p = stroke_pts)
            rotate_p(p, a) + p1
    ];    

function _shape_path_extend_stroke(stroke_pts, p1, p2, scale_step, i) =
    let(
        leng = norm(__to3d(p2) - __to3d(p1)),
        a = _shape_path_extend_az(p1, p2)
    )
    [
        for(p = stroke_pts)
            rotate_p(p * (1 + scale_step * i) + [0, leng], a) + p1
    ];
    
function _shape_path_extend_inner(stroke_pts, path_pts, leng_path_pts, scale_step) =
    [
        for(i = 1; i < leng_path_pts; i = i + 1)
            _shape_path_extend_stroke(
                stroke_pts, 
                path_pts[i - 1], 
                path_pts[i ], 
                scale_step, 
                i 
            )
    ];

function shape_path_extend(stroke_pts, path_pts, scale = 1.0, closed = false) =
    let(
        leng_path_pts = len(path_pts),
        scale_step = (scale - 1) / (leng_path_pts - 1),
        strokes = _shape_path_extend_inner(stroke_pts, path_pts, leng_path_pts, scale_step)        
    )
    closed && path_pts[0] == path_pts[leng_path_pts - 1] ? 
        __polytransversals(concat(strokes, [strokes[0]])) : 
        __polytransversals(
            concat([_shape_path_first_stroke(stroke_pts, path_pts)], strokes)
        );
        


/**
* archimedean_spiral.scad
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-archimedean_spiral.html
*
**/ 

function _radian_step(b, theta, l) =
    let(
        r_square = pow(b * theta, 2),
        double_r_square = 2 * r_square
    )
    acos((double_r_square - pow(l, 2)) / double_r_square) / 180 * PI;

function _find_radians(b, point_distance, radians, n, count = 1) =
    let(pre_radians = radians[count - 1])
    count == n ? radians : (
        _find_radians(
            b, 
            point_distance, 
            concat(
                radians,
                [pre_radians + _radian_step(b, pre_radians, point_distance)]
            ), 
            n,
        count + 1) 
    );

function archimedean_spiral(arm_distance, init_angle, point_distance, num_of_points, rt_dir = "CT_CLK") =
    let(b = arm_distance / (2 * PI), init_radian = init_angle * PI / 180)
    [
        for(theta = _find_radians(b, point_distance, [init_radian], num_of_points)) 
           let(r = b * theta, a = (rt_dir == "CT_CLK" ? 1 : -1) * theta * 57.2958)
           [[r * cos(a), r * sin(a)], a]
    ];

/**
* midpt_smooth.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-midpt_smooth.html
*
**/

function _midpt_smooth_sub(points, iend, closed = false) = 
    concat(
        [
            for(i = 0; i < iend; i = i + 1) 
                (points[i] + points[i + 1]) / 2
        ],
        closed ? [(points[iend] + points[0]) / 2] : []
    );

function midpt_smooth(points, n, closed = false) =
    let(
        smoothed = _midpt_smooth_sub(points, len(points) - 1, closed)
    )
    n == 1 ? smoothed : midpt_smooth(smoothed, n - 1, closed);

/**
* px_ascii.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_ascii.html
*
**/ 

function px_ascii(char, center = false, invert = false) = 
    let(code = ord(char))
    assert(code > 31 && code < 127, "not printable character")
    let(
        idx = code - 32,
        binaries = [
            [// " " 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0]
		    ],        
            [// "!"
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,1,0,0,0],
                [0,0,0,0,1,0,0,0],
                [0,0,0,0,1,0,0,0],
                [0,0,0,0,1,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,1,0,0,0],
                [0,0,0,0,0,0,0,0]
		    ],
            [// "\""
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,0,1,0,0],
                [0,0,0,1,0,1,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0]
		    ],
            [// "#"
                [0,0,0,0,0,0,0,0],
                [0,0,1,0,0,1,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,1,0,0,1,0,0],
                [0,0,1,0,0,1,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,1,0,0,1,0,0],
                [0,0,0,0,0,0,0,0]
		    ],
            [// "$"
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,0,1,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,1,0,0,1,0],
                [0,1,1,1,1,1,0,0],
                [0,0,0,1,0,0,0,0]
		    ],
            [// "%"
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,1,1,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,0,0,0,1,1,0],
                [0,0,0,0,0,0,0,0]
		    ],
            [// "&"
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,1,0,0,1,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,1,0,0,1,0,1,0],
                [0,1,0,0,0,1,0,0],
                [0,0,1,1,1,0,1,0],
                [0,0,0,0,0,0,0,0]
		    ],
            [// "'"
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,1,0,0,0],
                [0,0,0,0,1,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0]
		    ],
            [// "("
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,1,1,0,0],
                [0,0,1,1,1,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,0,1,1,1,0,0,0],
                [0,0,0,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
		    ],
            [// ")"
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,0,0,0],
                [0,0,0,1,1,1,0,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,1,1,1,0,0],
                [0,0,1,1,1,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "*"
                [0,0,0,0,0,0,0,0],
                [0,1,0,1,0,1,0,0],
                [0,0,1,1,1,0,0,0],
                [0,0,0,1,0,0,0,0],
                [0,0,1,1,1,0,0,0],
                [0,1,0,1,0,1,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "+"
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// ","
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,0,0,0,0]
            ],
            [// "-"
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "."
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "/"
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,1,1,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "0"
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,1,1,1,0],
                [0,1,1,1,1,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "1"
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "2"
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "3"
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "4"
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,1,1,1,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,1,1,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "5"
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,1,1,1,0,0],
                [0,0,0,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "6"
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "7"
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,0,1,1,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "8" 
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "9"
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,1,0],
                [0,0,0,0,0,1,1,0],
                [0,0,0,0,1,1,0,0],
                [0,0,1,1,1,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// ":" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// ";" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,0,0,0,0]
            ],
            [// "<" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,1,1,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,0,0,1,1,0]
            ],
            [// "=" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// ">" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,1,1,0,0,0,0,0]
            ],
            [// "?" 
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "@" 
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,1,0,1,0],
                [0,1,1,0,1,1,1,0],
                [0,1,1,0,0,0,0,0],
                [0,0,1,1,1,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "A" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,1,1,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "B" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "C" 
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "D" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,0,0,0],
                [0,1,1,0,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,1,1,0,0],
                [0,1,1,1,1,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "E" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,1,1,1,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "F" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,1,1,1,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "G" 
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,1,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,1,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "H" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,1,1,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "I" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "J" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,1,1,1,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,0,1,1,0,0],
                [0,1,0,0,1,1,0,0],
                [0,1,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0],
            ],
            [// "K" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,1,1,0,0],
                [0,1,1,1,1,0,0,0],
                [0,1,1,1,1,0,0,0],
                [0,1,1,0,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "L" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "M" 
                [0,0,0,0,0,0,0,0],
                [1,1,0,0,0,1,1,0],
                [1,1,1,0,1,1,1,0],
                [1,1,1,1,1,1,1,0],
                [1,1,0,1,0,1,1,0],
                [1,1,0,0,0,1,1,0],
                [1,1,0,0,0,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "N" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,1,0,1,1,0],
                [0,1,1,1,1,1,1,0],
                [0,1,1,1,1,1,1,0],
                [0,1,1,0,1,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "O" 
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "P" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,1,1,1,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "Q" 
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,1,1,1,0,0],
                [0,0,1,1,0,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "R" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,1,1,1,0,0],
                [0,1,1,0,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "S" 
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,1,1,0],
                [0,0,0,0,0,1,1,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "T" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "U" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "V" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "W" 
                [0,0,0,0,0,0,0,0],
                [1,1,0,0,0,1,1,0],
                [1,1,0,0,0,1,1,0],
                [1,1,0,1,0,1,1,0],
                [1,1,1,1,1,1,1,0],
                [1,1,1,0,1,1,1,0],
                [1,1,0,0,0,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "X" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "Y" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "Z" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "/" 
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,0,1,1,0,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "\\" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,0,0,1,1,0],
                [0,0,0,0,0,0,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "]" 
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,0,1,1,0,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "^" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,0,0,0,0,1,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "_" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [1,1,1,1,1,1,1,1]
            ],
            [// "`" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,0,0,0,0],
                [0,0,0,0,1,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "a" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,1,1,0],
                [0,0,1,1,1,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "b" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "c" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "d" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,1,1,0],
                [0,0,0,0,0,1,1,0],
                [0,0,1,1,1,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "e" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,1,1,1,1,0],
                [0,1,1,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "f" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,1,1,1,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,1,1,1,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "g" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,1,0],
                [0,0,0,0,0,1,1,0],
                [0,1,1,1,1,1,0,0]
            ],
            [// "h" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "i" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "j" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,1,1,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,1,1,0],
                [0,0,0,0,0,1,1,0],
                [0,0,0,0,0,1,1,0],
                [0,0,0,0,0,1,1,0],
                [0,0,1,1,1,1,0,0]
            ],
            [// "k" 
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,1,1,0,0],
                [0,1,1,1,1,0,0,0],
                [0,1,1,0,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "l" 
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "m" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,1,1,1,1,1],
                [0,1,1,1,1,1,1,1],
                [0,1,1,0,1,0,1,1],
                [0,1,1,0,0,0,1,1],
                [0,0,0,0,0,0,0,0]
            ],
            [// "n" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "o" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "p" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,1,1,1,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0]
            ],
            [// "q" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,1,0],
                [0,0,0,0,0,1,1,0],
                [0,0,0,0,0,1,1,0]
            ],
            [// "r" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,1,1,0,0,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "s" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,1,1,0],
                [0,1,1,0,0,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,0,0,1,1,0],
                [0,1,1,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "t" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,1,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "u" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "v" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "w" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,0,1,1],
                [0,1,1,0,1,0,1,1],
                [0,1,1,1,1,1,1,1],
                [0,0,1,1,1,1,1,0],
                [0,0,1,1,0,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "x" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,1,1,0,0,1,1,0],
                [0,0,1,1,1,1,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,1,1,0,0],
                [0,1,1,0,0,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "y" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "z" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,1,1,1,1,1,1,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "{" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,1,1,0,0],
                [0,0,1,1,0,0,0,0],
                [0,1,1,1,0,0,0,0],
                [0,1,1,1,0,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,0,0,1,1,1,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "|" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,1,1,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "}" 
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,1,0,0,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,0,1,1,1,0],
                [0,0,0,0,1,1,1,0],
                [0,0,0,0,1,1,0,0],
                [0,0,1,1,1,0,0,0],
                [0,0,0,0,0,0,0,0]
            ],
            [// "~" 
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,1,1,0,0,0,0],
                [0,1,0,1,1,0,1,0],
                [0,0,0,0,1,1,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0],
                [0,0,0,0,0,0,0,0]
            ]                   
        ]
    )
    px_from(binaries[idx], center = center, invert = invert);

function __to3d(p) = [p[0], p[1], 0];

function __trapezium(length, h, round_r) =
    let(
        r_half_trapezium = __half_trapezium(length / 2, h, round_r),
        to = len(r_half_trapezium) - 1,
        l_half_trapezium = [
            for(i = 0; i <= to; i = i + 1)
                let(pt = r_half_trapezium[to - i])
                [-pt[0], pt[1]]
        ]
    )    
    concat(
        r_half_trapezium,
        l_half_trapezium
    );

/**
* golden_spiral_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-golden_spiral_extrude.html
*
**/

module golden_spiral_extrude(shape_pts, from, to, point_distance, 
                             rt_dir = "CT_CLK", twist = 0, scale = 1.0, triangles = "SOLID") {

    pts_angles = golden_spiral(
        from = from, 
        to = to, 
        point_distance = point_distance,
        rt_dir = rt_dir
    );

    pts = [for(pt_angle = pts_angles) pt_angle[0]];
    
    az = rt_dir == "CT_CLK" ? 0 : -90;
    angles = [
        for(pt_angle = pts_angles) 
            [90, 0, pt_angle[1] + az]
    ];

    sections = cross_sections(
        shape_pts, 
        pts, angles, 
        twist = twist, 
        scale = scale
    );

    polysections(
        sections,
        triangles = triangles
    );

    // testing hook
    test_golden_spiral_extrude(sections);
}

// override it to test
module test_golden_spiral_extrude(sections) {

}

/**
* ellipse_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-ellipse_extrude.html
*
**/

module ellipse_extrude(semi_minor_axis, height, center = false, convexity = 10, twist = 0, slices = 20) {
    h = is_undef(height) ? semi_minor_axis : (
        // `semi_minor_axis` is always equal to or greater than `height`.
        height > semi_minor_axis ? semi_minor_axis : height
    );
    angle = asin(h / semi_minor_axis) / slices; 

    f_extrude = [
        for(i = 1; i <= slices; i = i + 1) 
        [
            cos(angle * i) / cos(angle * (i - 1)), 
            semi_minor_axis * sin(angle * i)
        ]
    ]; 
    len_f_extrude = len(f_extrude);

    accm_fs =
        [
            for(i = 0, pre_f = 1; i < len_f_extrude; pre_f = pre_f * f_extrude[i][0], i = i + 1)
                pre_f * f_extrude[i][0]
        ];

    child_fs = concat([1], accm_fs);
    pre_zs = concat(
        [0],
        [
            for(i = 0; i < len_f_extrude; i = i + 1)
                f_extrude[i][1]
        ]
    );

    module extrude() {
        for(i = [0:len_f_extrude - 1]) {
            f = f_extrude[i][0];
            z = f_extrude[i][1];

            translate([0, 0, pre_zs[i]]) 
            rotate(-twist / slices * i) 
            linear_extrude(
                z - pre_zs[i], 
                convexity = convexity,
                twist = twist / slices, 
                slices = 1,
                scale = f 
            ) 
            scale(child_fs[i]) 
                children();
        }
    }
    
    center_offset = [0, 0, center == true ? -h / 2 : 0];
    translate(center_offset) 
    extrude() 
        children();

    // hook for testing
    test_ellipse_extrude_fzc(child_fs, pre_zs, center_offset);
}

// override for testing
module test_ellipse_extrude_fzc(child_fs, pre_zs, center_offset) {

}

/**
* shape_star.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_starburst.html
*
**/

function __outer_points_shape_starburst(r1, r2, n) = 
    let(
        a = 360 / n
    )
    [for(i = 0; i < n; i = i + 1) [r1 * cos(a * i), r1 * sin(a * i)]];

function __inner_points_shape_starburst(r1, r2, n) = 
    let (
        a = 360 / n,
        half_a = a / 2
    )
    [for(i = 0; i < n; i = i + 1) [r2 * cos(a * i + half_a), r2 * sin(a * i + half_a)]];
    
function shape_starburst(r1, r2, n) = 
   let(
       outer_points = __outer_points_shape_starburst(r1, r2, n),
       inner_points = __inner_points_shape_starburst(r1, r2, n),
       leng = len(outer_points)
    )
   [for(i = 0; i < leng; i = i + 1) each [outer_points[i], inner_points[i]]];

/**
* reverse.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-reverse.html
*
**/ 


function reverse(lt) = __reverse(lt);

/**
* sphere_spiral_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-sphere_spiral_extrude.html
*
**/

module sphere_spiral_extrude(shape_pts, radius, za_step, 
                             z_circles = 1, begin_angle = 0, end_angle = 0, vt_dir = "SPI_DOWN", rt_dir = "CT_CLK", 
                             twist = 0, scale = 1.0, triangles = "SOLID") {

    points_angles = sphere_spiral(
        radius = radius, 
        za_step = za_step,  
        z_circles = z_circles, 
        begin_angle = begin_angle, 
        end_angle = end_angle,
        vt_dir = vt_dir,
        rt_dir = rt_dir
    );

    v_clk = vt_dir == "SPI_DOWN" ? 90 : -90;
    r_clk = rt_dir == "CT_CLK" ? 0 : 180;

    points = [for(pa = points_angles) pa[0]];
    angles = [for(pa = points_angles) [pa[1][0] + v_clk, pa[1][1], pa[1][2] + r_clk]];

    sections = cross_sections(
        shape_pts, points, angles, twist = twist, scale = scale
    );

    polysections(
        sections, 
        triangles = triangles
    );

    // testing hook
    test_sphere_spiral_extrude(sections);
}

// override it to test
module test_sphere_spiral_extrude(sections) {

}

/**
* crystal_ball.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-crystal_ball.html
*
**/ 


module crystal_ball(radius, theta = 360, phi = 180) {
    phis = is_num(phi) ? [0, phi] : phi;
    
    frags = __frags(radius);

    shape_pts = shape_pie(
        radius, 
        [90 - phis[1], 90 - phis[0]], 
        $fn = __nearest_multiple_of_4(frags)
    );

    ring_extrude(
        shape_pts, 
        angle = theta, 
        radius = 0, 
        $fn = frags
    );

    // hook for testing
    test_crystal_ball_pie(shape_pts);
}

// override it to test
module test_crystal_ball_pie(shape_pts) {

}

/**
* rounded_cube.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rounded_cube.html
*
**/


module rounded_cube(size, corner_r, center = false) {
    is_flt = is_num(size);
    x = is_flt ? size : size[0];
    y = is_flt ? size : size[1];
    z = is_flt ? size : size[2];

    corner_frags = __nearest_multiple_of_4(__frags(corner_r));
    edge_d = corner_r * cos(180 / corner_frags);

    half_x = x / 2;
    half_y = y / 2;
    half_z = z / 2;
    
    half_l = half_x - edge_d;
    half_w = half_y - edge_d;
    half_h = half_z - edge_d;
    
    half_cube_leng = size / 2;
    half_leng = half_cube_leng - edge_d;
        
    pair = [1, -1];
    corners = [
        for(z = pair) 
            for(y = pair) 
                for(x = pair) 
                    [half_l * x, half_w * y, half_h * z]
    ];

    module corner(i) {
        translate(corners[i]) 
            sphere(corner_r, $fn = corner_frags);        
    }

    center_pts = center ? [0, 0, 0] : [half_x, half_y, half_z];
    
    // Don't use `hull() for(...) {...}` because it's slow.
    translate(center_pts) hull() {
        corner(0);
        corner(1);
        corner(2);
        corner(3);
        corner(4);
        corner(5);
        corner(6);
        corner(7);      
    }

    // hook for testing
    test_rounded_edge_corner_center(corner_frags, corners, center_pts);
}

// override it to test
module test_rounded_edge_corner_center(corner_frags, corners, center_pts) {

}

function __reverse(vt) = [for(i = len(vt) - 1; i >= 0; i = i - 1) vt[i]];

/**
* pie.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-pie.html
*
**/

 
module pie(radius, angle) {
    polygon(__shape_pie(radius, angle));
}

/**
* px_circle.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_circle.html
*
**/ 

function _px_circle_y(f, y) = f >= 0 ? y - 1 : y;
function _px_circle_ddf_y(f, ddf_y) = f >= 0 ? ddf_y + 2 : ddf_y;
function _px_circle_f(f, ddf_y) = f >= 0 ? f + ddf_y : f;

function _px_circle(f, ddf_x, ddf_y, x, y, filled) = 
    x >= y ? [] : 
    let(
        ny = _px_circle_y(f, y),
        nddf_y = _px_circle_ddf_y(f, ddf_y),
        nx = x + 1,
        nddf_x = ddf_x + 2,
        nf = _px_circle_f(f, ddf_y) + nddf_x
    )
    concat(
        filled ? 
            concat(
               [for(xi = -nx; xi <= nx; xi = xi + 1) [xi, -ny]],
               [for(xi = -ny; xi <= ny; xi = xi + 1) [xi, -nx]],
               [for(xi = -ny; xi <= ny; xi = xi + 1) [xi, nx]],
               [for(xi = -nx; xi <= nx; xi = xi + 1) [xi, ny]]              
            )
            :
            [  
                [-nx, -ny], [nx, -ny],                 
                [-ny, -nx], [ny, -nx],
                [-ny, nx], [ny, nx],
                [-nx, ny], [nx, ny]
            ],
        _px_circle(nf, nddf_x, nddf_y, nx, ny, filled)
    );
    
function px_circle(radius, filled = false) =
    let(
        f = 1 - radius,
        ddf_x = 1,
        ddf_y = -2 * radius,
        x = 0,
        y = radius
    )
    concat(
        filled ? 
            concat(
                [[0, radius], [0, -radius]],
                [for(xi = -radius; xi <= radius; xi = xi + 1) [xi, 0]]
            )
            : 
            [
                [0, -radius],                
                [-radius, 0], 
                [radius, 0],
                [0, radius]
            ],
        _px_circle(f, ddf_x, ddf_y, x, y, filled)
    );

/**
* slice.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-slice.html
*
**/ 

function slice(lt, begin, end) = 
    let(ed = is_undef(end) ? len(lt) : end)
    [for(i = begin; i < ed; i = i + 1) lt[i]];
    

/**
* polysections.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polysections.html
*
**/


module polysections(sections, triangles = "SOLID") {

    function side_indexes(sects, begin_idx = 0) = 
        let(       
            leng_sects = len(sects),
            leng_pts_sect = len(sects[0]),
            range_j = [begin_idx:leng_pts_sect:begin_idx + (leng_sects - 2) * leng_pts_sect],
            range_i = [0:leng_pts_sect - 1]
        ) 
        concat(
            [
                for(j = range_j)
                    for(i = range_i) 
                        [
                            j + i, 
                            j + (i + 1) % leng_pts_sect, 
                            j + (i + 1) % leng_pts_sect + leng_pts_sect
                        ]
            ],
            [
                for(j = range_j)
                    for(i = range_i) 
                        [
                            j + i, 
                            j + (i + 1) % leng_pts_sect + leng_pts_sect , 
                            j + i + leng_pts_sect
                        ]
            ]      
        );

    function search_at(f_sect, p, leng_pts_sect, i = 0) =  
        i < leng_pts_sect ?
            (p == f_sect[i] ? i : search_at(f_sect, p, leng_pts_sect, i + 1)) : -1;
    
    function the_same_after_twisting(f_sect, l_sect, leng_pts_sect) =
        let(
            found_at_i = search_at(f_sect, l_sect[0], leng_pts_sect)
        )
        found_at_i <= 0 ? false : 
            l_sect == concat(
                [for(i = found_at_i; i < leng_pts_sect; i = i + 1) f_sect[i]],
                [for(i = 0; i < found_at_i; i = i + 1) f_sect[i]]
            ); 

    function to_v_pts(sects) = 
            [
            for(sect = sects) 
                for(pt = sect) 
                    pt
            ];                   

    module solid_sections(sects) {
        
        leng_sects = len(sects);
        leng_pts_sect = len(sects[0]);
        first_sect = sects[0];
        last_sect = sects[leng_sects - 1];
   
        v_pts = [
            for(sect = sects) 
                for(pt = sect) 
                    pt
        ];

        begin_end_the_same =
            first_sect == last_sect || 
            the_same_after_twisting(first_sect, last_sect, leng_pts_sect);

        if(begin_end_the_same) {
            f_idxes = side_indexes(sects);

            polyhedron(
                v_pts, 
                f_idxes
            ); 

            // hook for testing
            test_polysections_solid(v_pts, f_idxes);
        } else {
            range_i = [0:leng_pts_sect - 1];
            first_idxes = [for(i = range_i) leng_pts_sect - 1 - i];  
            last_idxes = [
                for(i = range_i) 
                    i + leng_pts_sect * (leng_sects - 1)
            ];    

            f_idxes = concat([first_idxes], side_indexes(sects), [last_idxes]);
            
            polyhedron(
                v_pts, 
                f_idxes
            );   

            // hook for testing
            test_polysections_solid(v_pts, f_idxes);             
        }
    }

    module hollow_sections(sects) {
        leng_sects = len(sects);
        leng_sect = len(sects[0]);
        half_leng_sect = leng_sect / 2;
        half_leng_v_pts = leng_sects * half_leng_sect;

        function strip_sects(begin_idx, end_idx) = 
            [
                for(i = 0; i < leng_sects; i = i + 1) 
                    [
                        for(j = begin_idx; j <= end_idx; j = j + 1)
                            sects[i][j]
                    ]
            ]; 

        function first_idxes() = 
            [
                for(i = 0; i < half_leng_sect; i = i + 1) 
                    [
                       i,
                       i + half_leng_v_pts,
                       (i + 1) % half_leng_sect + half_leng_v_pts, 
                       (i + 1) % half_leng_sect
                    ] 
            ];

        function last_idxes(begin_idx) = 
            [
                for(i = 0; i < half_leng_sect; i = i + 1) 
                    [
                       begin_idx + i,
                       begin_idx + (i + 1) % half_leng_sect,
                       begin_idx + (i + 1) % half_leng_sect + half_leng_v_pts,
                       begin_idx + i + half_leng_v_pts
                    ]     
            ];            

        outer_sects = strip_sects(0, half_leng_sect - 1);
        inner_sects = strip_sects(half_leng_sect, leng_sect - 1);

        outer_v_pts =  to_v_pts(outer_sects);
        inner_v_pts = to_v_pts(inner_sects);

        outer_idxes = side_indexes(outer_sects);
        inner_idxes = [ 
            for(idxes = side_indexes(inner_sects, half_leng_v_pts))
                __reverse(idxes)
        ];

        first_outer_sect = outer_sects[0];
        last_outer_sect = outer_sects[leng_sects - 1];
        first_inner_sect = inner_sects[0];
        last_inner_sect = inner_sects[leng_sects - 1];
        
        leng_pts_sect = len(first_outer_sect);

        begin_end_the_same = 
           (first_outer_sect == last_outer_sect && first_inner_sect == last_inner_sect) ||
           (
               the_same_after_twisting(first_outer_sect, last_outer_sect, leng_pts_sect) && 
               the_same_after_twisting(first_inner_sect, last_inner_sect, leng_pts_sect)
           ); 

        v_pts = concat(outer_v_pts, inner_v_pts);

        if(begin_end_the_same) {
            f_idxes = concat(outer_idxes, inner_idxes);

            polyhedron(
                v_pts,
                f_idxes
            );      

            // hook for testing
            test_polysections_solid(v_pts, f_idxes);                     
        } else {
            first_idxes = first_idxes();
            last_idxes = last_idxes(half_leng_v_pts - half_leng_sect);

            f_idxes = concat(first_idxes, outer_idxes, inner_idxes, last_idxes);
            
            polyhedron(
                v_pts,
                f_idxes
            ); 

            // hook for testing
            test_polysections_solid(v_pts, f_idxes);              
        }
    }
    
    module triangles_defined_sections() {
        module tri_sections(tri1, tri2) {
            hull() polyhedron(
                points = concat(tri1, tri2),
                faces = [
                    [0, 1, 2], 
                    [3, 5, 4], 
                    [1, 3, 4], [2, 1, 4], [2, 3, 0], 
                    [0, 3, 1], [2, 4, 5], [2, 5, 3]
                ]
            );  
        }

        module two_sections(section1, section2) {
            for(idx = triangles) {
               tri_sections(
                    [
                        section1[idx[0]], 
                        section1[idx[1]], 
                        section1[idx[2]]
                    ], 
                    [
                        section2[idx[0]], 
                        section2[idx[1]], 
                        section2[idx[2]]
                    ]
                );
            }
        }
        
        for(i = [0:len(sections) - 2]) {
             two_sections(
                 sections[i], 
                 sections[i + 1]
             );
        }
    }
    
    if(triangles == "SOLID") {
        solid_sections(sections);
    } else if(triangles == "HOLLOW") {
        hollow_sections(sections);
    }
    else {
        triangles_defined_sections();
    }
}

// override it to test

module test_polysections_solid(points, faces) {

}

/**
* shape_pie.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_pie.html
*
**/


function shape_pie(radius, angle) =
    __shape_pie(radius, angle);

/**
* cross_sections.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-cross_sections.html
*
**/


function cross_sections(shape_pts, path_pts, angles, twist = 0, scale = 1.0) =
    let(
        len_path_pts_minus_one = len(path_pts) - 1,
        sh_pts = len(shape_pts[0]) == 3 ? shape_pts : [for(p = shape_pts) __to3d(p)],
        pth_pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) __to3d(p)],
        scale_step_vt = is_num(scale) ? 
            [(scale - 1) / len_path_pts_minus_one, (scale - 1) / len_path_pts_minus_one] :
            [(scale[0] - 1) / len_path_pts_minus_one, (scale[1] - 1) / len_path_pts_minus_one]
            ,
        scale_step_x = scale_step_vt[0],
        scale_step_y = scale_step_vt[1],
        twist_step = twist / len_path_pts_minus_one
    )
    [
        for(i = 0; i <= len_path_pts_minus_one; i = i + 1)
            [
                for(p = sh_pts) 
                let(scaled_p = [p[0] * (1 + scale_step_x * i), p[1] * (1 + scale_step_y * i), p[2]])
                    rotate_p(
                        rotate_p(scaled_p, twist_step * i)
                        , angles[i]
                    ) + pth_pts[i]
            ]
    ];


/**
* turtle3d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-turtle3d.html
*
**/ 

function _turtle3d_x(pt) = pt[0];
function _turtle3d_y(pt) = pt[1];
function _turtle3d_z(pt) = pt[2];

function _turtle3d_pt3D(x, y, z) = [x, y, z];

function _turtle3d_create(pt, unit_vts) = [pt, unit_vts];
function _turtle3d_create_default() = _turtle3d_create(
    _turtle3d_pt3D(0, 0, 0), 
    // unit vectors from the turtle's viewpoint
    [_turtle3d_pt3D(1, 0, 0), _turtle3d_pt3D(0, 1, 0), _turtle3d_pt3D(0, 0, 1)] 
);

function _turtle3d_plus(pt, n) = 
    _turtle3d_pt3D(_turtle3d_x(pt) + n, _turtle3d_y(pt) + n, _turtle3d_z(pt) + n);
function _turtle3d_minus(pt, n) = 
    _turtle3d_pt3D(_turtle3d_x(pt) - n, _turtle3d_y(pt) - n, _turtle3d_z(pt) + n);
function _turtle3d_mlt(pt, n) = 
    _turtle3d_pt3D(_turtle3d_x(pt) * n, _turtle3d_y(pt) * n, _turtle3d_z(pt) * n);
function _turtle3d_div(pt, n) = 
    _turtle3d_pt3D(_turtle3d_x(pt) / n, _turtle3d_y(pt) / n, _turtle3d_z(pt) / n);
function _turtle3d_neg(pt, n) = 
    _turtle3d_mlt(pt, -1);

function _turtle3d_ptPlus(pt1, pt2) = 
    _turtle3d_pt3D(
        _turtle3d_x(pt1) + _turtle3d_x(pt2), 
        _turtle3d_y(pt1) + _turtle3d_y(pt2), 
        _turtle3d_z(pt1) + _turtle3d_z(pt2)
    );


function _turtle3d_pt(turtle) = turtle[0];
function _turtle3d_unit_vts(turtle) = turtle[1];

// forward the turtle in the x' direction
function _turtle3d_xu_move(turtle, leng) = _turtle3d_create(
    _turtle3d_ptPlus(_turtle3d_pt(turtle), _turtle3d_mlt(_turtle3d_unit_vts(turtle)[0], leng)),
    _turtle3d_unit_vts(turtle)
);

// forward the turtle in the y' direction
function _turtle3d_yu_move(turtle, leng) = _turtle3d_create(
    _turtle3d_ptPlus(_turtle3d_pt(turtle), _turtle3d_mlt(_turtle3d_unit_vts(turtle)[1], leng)),
    _turtle3d_unit_vts(turtle)
);

// forward the turtle in the z' direction
function _turtle3d_zu_move(turtle, leng) = _turtle3d_create(
    _turtle3d_ptPlus(
        _turtle3d_pt(turtle), 
        _turtle3d_mlt(_turtle3d_unit_vts(turtle)[2], leng)
    ),
    _turtle3d_unit_vts(turtle)
);

// turn the turtle around the x'-axis
// return a new unit vector
function _turtle3d_xu_turn(turtle, a) = 
    let(cosa = cos(a), sina = sin(a))
    _turtle3d_create(
        _turtle3d_pt(turtle),
        [
            _turtle3d_unit_vts(turtle)[0], 
            _turtle3d_ptPlus(
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[1], cosa), 
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[2], sina)
            ), 
            _turtle3d_ptPlus(
                _turtle3d_mlt(_turtle3d_neg(_turtle3d_unit_vts(turtle)[1]), sina), 
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[2], cosa)
            )
        ]
    );

// turn the turtle around the y'-axis
// return a new unit vector
function _turtle3d_yu_turn(turtle, a) = 
    let(cosa = cos(a), sina = sin(a))
    _turtle3d_create(
        _turtle3d_pt(turtle),
        [
            _turtle3d_ptPlus(
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[0], cosa), 
                _turtle3d_mlt(_turtle3d_neg(_turtle3d_unit_vts(turtle)[2]), sina)
            ),
            _turtle3d_unit_vts(turtle)[1], 
            _turtle3d_ptPlus(
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[0], sina), 
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[2], cosa)
            )
        ]
    );

// turn the turtle around the z'-axis
// return a new unit vector
function _turtle3d_zu_turn(turtle, a) = 
    let(cosa = cos(a), sina = sin(a))
    _turtle3d_create(
        _turtle3d_pt(turtle),
        [
            _turtle3d_ptPlus(
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[0], cosa), 
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[1], sina)
            ),
            _turtle3d_ptPlus(
                _turtle3d_mlt(_turtle3d_neg(_turtle3d_unit_vts(turtle)[0]), sina), 
                _turtle3d_mlt(_turtle3d_unit_vts(turtle)[1], cosa)
            ),
            _turtle3d_unit_vts(turtle)[2], 
        ]
    );

function _turtle3d_create_cmd(arg1, arg2) = 
    is_undef(arg1) && is_undef(arg2) ? _turtle3d_create_default() : 
    !is_undef(arg1) && !is_undef(arg2) ? _turtle3d_create(arg1, arg2) : undef;
    
function _turtle3d_chain_move(cmd, arg1, arg2) =
    cmd == "xu_move" ? _turtle3d_xu_move(arg1, arg2) : 
    cmd == "yu_move" ? _turtle3d_yu_move(arg1, arg2) : 
    cmd == "zu_move" ? _turtle3d_zu_move(arg1, arg2) : _turtle3d_chain_turn(cmd, arg1, arg2);
    
function _turtle3d_chain_turn(cmd, arg1, arg2) = 
    cmd == "xu_turn" ? _turtle3d_xu_turn(arg1, arg2) : 
    cmd == "yu_turn" ? _turtle3d_yu_turn(arg1, arg2) : 
    cmd == "zu_turn" ? _turtle3d_zu_turn(arg1, arg2) : _turtle3d_chain_one_arg(cmd, arg1);    

function _turtle3d_chain_one_arg(cmd, arg) = 
    cmd == "pt" ? _turtle3d_pt(arg) : 
    cmd == "unit_vts" ? _turtle3d_unit_vts(arg) : undef;
    
function turtle3d(cmd, arg1, arg2) =
    cmd == "create" ? 
        _turtle3d_create_cmd(arg1, arg2) : 
        _turtle3d_chain_move(cmd, arg1, arg2);    

function __m_rotation_q_rotation(a, v) = 
    let(
        half_a = a / 2,
        axis = v / norm(v),
        s = sin(half_a),
        x = s * axis[0],
        y = s * axis[1],
        z = s * axis[2],
        w = cos(half_a),
        
        x2 = x + x,
        y2 = y + y,
        z2 = z + z,

        xx = x * x2,
        yx = y * x2,
        yy = y * y2,
        zx = z * x2,
        zy = z * y2,
        zz = z * z2,
        wx = w * x2,
        wy = w * y2,
        wz = w * z2        
    )
    [
        [1 - yy - zz, yx - wz, zx + wy, 0],
        [yx + wz, 1 - xx - zz, zy - wx, 0],
        [zx - wy, zy + wx, 1 - xx - yy, 0],
        [0, 0, 0, 1]
    ];

function __m_rotation_xRotation(a) = 
    let(c = cos(a), s = sin(a))
    [
        [1, 0, 0, 0],
        [0, c, -s, 0],
        [0, s, c, 0],
        [0, 0, 0, 1]
    ];

function __m_rotation_yRotation(a) = 
    let(c = cos(a), s = sin(a))
    [
        [c, 0, s, 0],
        [0, 1, 0, 0],
        [-s, 0, c, 0],
        [0, 0, 0, 1]
    ];    

function __m_rotation_zRotation(a) = 
    let(c = cos(a), s = sin(a))
    [
        [c, -s, 0, 0],
        [s, c, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
    ];    

function __m_rotation_xyz_rotation(a) =
    let(ang = __to_ang_vect(a))
    __m_rotation_zRotation(ang[2]) * __m_rotation_yRotation(ang[1]) * __m_rotation_xRotation(ang[0]);

function __m_rotation(a, v) = 
    (a == 0 || a == [0, 0, 0] || a == [0] || a == [0, 0]) ? [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
    ] : (is_undef(v) ? __m_rotation_xyz_rotation(a) : __m_rotation_q_rotation(a, v));

/**
* path_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-path_extrude.html
*
**/


module path_extrude(shape_pts, path_pts, triangles = "SOLID", twist = 0, scale = 1.0, closed = false, method = "AXIS_ANGLE") {
    sh_pts = len(shape_pts[0]) == 3 ? shape_pts : [for(p = shape_pts) __to3d(p)];
    pth_pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) __to3d(p)];
        
    len_path_pts = len(pth_pts);
    len_path_pts_minus_one = len_path_pts - 1;
    
    module axis_angle_path_extrude() {
        twist_step_a = twist / len_path_pts;

        function scale_pts(pts, s) = [
            for(p = pts) [p[0] * s[0], p[1] * s[1], p[2] * s[2]]
        ];
        
        function translate_pts(pts, t) = [
            for(p = pts) [p[0] + t[0], p[1] + t[1], p[2] + t[2]]
        ];
            
        function rotate_pts(pts, a, v) = [for(p = pts) rotate_p(p, a, v)];

        scale_step_vt = is_num(scale) ? 
            let(s =  (scale - 1) / len_path_pts_minus_one) [s, s, s] : 
            [
                (scale[0] - 1) / len_path_pts_minus_one, 
                (scale[1] - 1) / len_path_pts_minus_one,
                is_undef(scale[2]) ? 0 : (scale[2] - 1) / len_path_pts_minus_one
            ];   

        // get rotation matrice for sections

        function local_ang_vects(j) = 
            [
                for(i = j; i > 0; i = i - 1) 
                let(
                    vt0 = pth_pts[i] - pth_pts[i - 1],
                    vt1 = pth_pts[i + 1] - pth_pts[i],
                    a = acos((vt0 * vt1) / (norm(vt0) * norm(vt1))),
                    v = cross(vt0, vt1)
                )
                [a, v]
            ];

        rot_matrice = [
            for(ang_vect = local_ang_vects(len_path_pts - 2)) 
                __m_rotation(ang_vect[0], ang_vect[1])
        ];

        leng_rot_matrice = len(rot_matrice);
        leng_rot_matrice_minus_one = leng_rot_matrice - 1;
        leng_rot_matrice_minus_two= leng_rot_matrice - 2;

        identity_matrix = [
            [1, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, 1]
        ];

        function cumulated_rot_matrice(i) = 
            leng_rot_matrice == 0 ? [identity_matrix] : (
                leng_rot_matrice == 1 ? [rot_matrice[0], identity_matrix] : 
                    (
                        i == leng_rot_matrice_minus_two ? 
                        [
                            rot_matrice[leng_rot_matrice_minus_one], 
                            rot_matrice[leng_rot_matrice_minus_two] * rot_matrice[leng_rot_matrice_minus_one]
                        ] 
                        : cumulated_rot_matrice_sub(i))
            );

        function cumulated_rot_matrice_sub(i) = 
            let(
                matrice = cumulated_rot_matrice(i + 1),
                curr_matrix = rot_matrice[i],
                prev_matrix = matrice[len(matrice) - 1]
            )
            concat(matrice, [curr_matrix * prev_matrix]);

        cumu_rot_matrice = cumulated_rot_matrice(0);

        // get all sections

        function init_section(a, s) =
            let(angleyz = __angy_angz(pth_pts[0], pth_pts[1]))
            rotate_pts(
                rotate_pts(
                    rotate_pts(
                        scale_pts(sh_pts, s), a
                    ), [90, 0, -90]
                ), [0, -angleyz[0], angleyz[1]]
            );
            
        function local_rotate_section(j, init_a, init_s) =
            j == 0 ? 
                init_section(init_a, init_s) : 
                local_rotate_section_sub(j, init_a, init_s);
        
        function local_rotate_section_sub(j, init_a, init_s) = 
            let(
                vt0 = pth_pts[j] - pth_pts[j - 1],
                vt1 = pth_pts[j + 1] - pth_pts[j],
                ms = cumu_rot_matrice[j - 1]
            )
            [
                for(p = init_section(init_a, init_s)) 
                    [
                        [ms[0][0], ms[0][1], ms[0][2]] * p,
                        [ms[1][0], ms[1][1], ms[1][2]] * p,
                        [ms[2][0], ms[2][1], ms[2][2]] * p
                    ]
            ];        

        sections =
            let(
                fst_section = 
                    translate_pts(local_rotate_section(0, 0, [1, 1, 1]), pth_pts[0]),
                end_i = len_path_pts - 1,
                remain_sections = [
                    for(i = 0; i < end_i; i = i + 1) 
                        translate_pts(
                            local_rotate_section(i, i * twist_step_a, [1, 1, 1] + scale_step_vt * i),
                            pth_pts[i + 1]
                        )
                ]
            ) concat([fst_section], remain_sections);

        calculated_sections =
            closed && pth_pts[0] == pth_pts[len_path_pts_minus_one] ?
                concat(sections, [sections[0]]) : // round-robin
                sections;
        
        polysections(
            calculated_sections,
            triangles = triangles
        );   

        // hook for testing
        test_path_extrude(sections);        
    }

    module euler_angle_path_extrude() {
        scale_step_vt = is_num(scale) ? 
            [(scale - 1) / len_path_pts_minus_one, (scale - 1) / len_path_pts_minus_one] : 
            [(scale[0] - 1) / len_path_pts_minus_one, (scale[1] - 1) / len_path_pts_minus_one];

        scale_step_x = scale_step_vt[0];
        scale_step_y = scale_step_vt[1];
        twist_step = twist / len_path_pts_minus_one;

        function section(p1, p2, i) = 
            let(
                length = norm(p1 - p2),
                angy_angz = __angy_angz(p1, p2),
                ay = -angy_angz[0],
                az = angy_angz[1]
            )
            [
                for(p = sh_pts) 
                    let(scaled_p = [p[0] * (1 + scale_step_x * i), p[1] * (1 + scale_step_y * i), p[2]])
                    rotate_p(
                        rotate_p(
                            rotate_p(scaled_p, twist_step * i), [90, 0, -90]
                        ) + [i == 0 ? 0 : length, 0, 0], 
                        [0, ay, az]
                    ) + p1
            ];
        
        path_extrude_inner =
            [
                for(i = 1; i < len_path_pts; i = i + 1)
                    section(pth_pts[i - 1], pth_pts[i],  i)
            ];

        calculated_sections =
            closed && pth_pts[0] == pth_pts[len_path_pts_minus_one] ?
                concat(path_extrude_inner, [path_extrude_inner[0]]) : // round-robin
                concat([section(pth_pts[0], pth_pts[1], 0)], path_extrude_inner);

        polysections(
            calculated_sections,
            triangles = triangles
        );   

        // hook for testing
        test_path_extrude(calculated_sections);
    }

    if(method == "AXIS_ANGLE") {
        axis_angle_path_extrude();
    }
    else if(method == "EULER_ANGLE") {
        euler_angle_path_extrude();
    } 
}

// override to test
module test_path_extrude(sections) {

}

/**
* bezier_smooth.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bezier_curve.html
*
**/ 


function _corner_ctrl_pts(round_d, p1, p2, p3) =
    let(
        _ya_za_1 = __angy_angz(p1, p2),
        _ya_za_2 = __angy_angz(p3, p2),
        
        dz1 = sin(_ya_za_1[0]) * round_d,
        dxy1 = cos(_ya_za_1[0]) * round_d,
        dy1 = sin(_ya_za_1[1]) * dxy1,
        dx1 = cos(_ya_za_1[1]) * dxy1,
        
        dz2 = sin(_ya_za_2[0]) * round_d,
        dxy2 = cos(_ya_za_2[0]) * round_d,
        dy2 = sin(_ya_za_2[1]) * dxy2,
        dx2 = cos(_ya_za_2[1]) * dxy2       
    )
    [
        p2 - [dx1, dy1, dz1],
        p2,
        p2 - [dx2, dy2, dz2]
    ];
    
    
function _bezier_corner(round_d, t_step, p1, p2, p3) =
    bezier_curve(t_step, _corner_ctrl_pts(round_d, p1, p2, p3));

function _recursive_bezier_smooth(pts, round_d, t_step, leng) =
    let(end_i = leng - 2)
    [
        for(i = 0; i < end_i; i = i + 1) 
            each _bezier_corner(round_d, t_step, pts[i], pts[i + 1], pts[i + 2])
    ];

    
function bezier_smooth(path_pts, round_d, t_step = 0.1, closed = false) =
    let(
        pts = len(path_pts[0]) == 3 ? path_pts : [for(p = path_pts) __to3d(p)],
        leng = len(pts),
        middle_pts = _recursive_bezier_smooth(pts, round_d, t_step, leng),
        pth_pts = closed ?
            concat(
                _recursive_bezier_smooth(
                    [pts[leng - 1], pts[0], pts[1]],
                    round_d, t_step, 3
                ),
                middle_pts,
                _recursive_bezier_smooth(
                    [pts[leng - 2], pts[leng - 1], pts[0]],
                    round_d, t_step, 3
                )  
            ) :
            concat(
                [pts[0]],
                middle_pts,
                [pts[leng - 1]]
            )
    ) 
    len(path_pts[0]) == 2 ? [for(p = pth_pts) __to2d(p)] : pth_pts;

/**
* bezier_surface.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bezier_surface.html
*
**/ 

function bezier_surface(t_step, ctrl_pts) =
    let(
        leng_ctrl_pts = len(ctrl_pts),
        pts =  [
        for(i = 0; i < leng_ctrl_pts; i = i + 1)
            bezier_curve(t_step, ctrl_pts[i])
        ],
        leng_pts0 = len(pts[0]),
        leng_pts = len(pts)
    ) 
    [for(x = 0; x < leng_pts0; x = x + 1)
        bezier_curve(
            t_step,  
            [for(y = 0; y < leng_pts; y = y + 1) pts[y][x]]
        ) 
    ];

/**
* function_grapher.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-function_grapher.html
*
**/ 


module function_grapher(points, thickness, style = "FACES", slicing = "SLASH") {

    rows = len(points);
    columns = len(points[0]);

    yi_range = [0:rows - 2];
    xi_range =  [0:columns - 2];

    // Increasing $fn will be slow when you use "LINES", "HULL_FACES" or "HULL_LINES".
    
    module faces() {
        function xy_to_index(x, y, columns) = y * columns + x; 

        top_pts = [
            for(row_pts = points)
                for(pt = row_pts)
                    pt
        ];
            
        base_pts = [
            for(pt = top_pts)
                [pt[0], pt[1], pt[2] - thickness]
        ];
        
        leng_pts = len(top_pts);
                
        top_tri_faces1 = slicing == "SLASH" ? [
            for(yi = yi_range) 
                for(xi = xi_range)
                    [
                        xy_to_index(xi, yi, columns),
                        xy_to_index(xi + 1, yi + 1, columns),
                        xy_to_index(xi + 1, yi, columns)
                    ]    
        ] : [
            for(yi = yi_range)
                for(xi = xi_range)
                    [
                        xy_to_index(xi, yi, columns),
                        xy_to_index(xi, yi + 1, columns),
                        xy_to_index(xi + 1, yi, columns)
                    ]    
        ];

        top_tri_faces2 = slicing == "SLASH" ? [
            for(yi = yi_range) 
                for(xi = xi_range)
                    [
                        xy_to_index(xi, yi, columns),
                        xy_to_index(xi, yi + 1, columns),
                        xy_to_index(xi + 1, yi + 1, columns)
                    ]    
        ] : [
            for(yi = yi_range) 
                for(xi = xi_range)
                    [
                        xy_to_index(xi, yi + 1, columns),
                        xy_to_index(xi + 1, yi + 1, columns),
                        xy_to_index(xi + 1, yi, columns)
                    ]    
        ];        

        offset_v = [leng_pts, leng_pts, leng_pts];
        base_tri_faces1 = [
            for(face = top_tri_faces1)
                __reverse(face) + offset_v
        ];

        base_tri_faces2 = [
            for(face = top_tri_faces2)
                __reverse(face) + offset_v
        ];
        
        side_faces1 = [
            for(xi = xi_range)
                let(
                    idx1 = xy_to_index(xi, 0, columns),
                    idx2 = xy_to_index(xi + 1, 0, columns)
                )
                [
                    idx1,
                    idx2,
                    idx2 + leng_pts,
                    idx1 + leng_pts
                ]
        ];

        side_faces2 = [
            for(yi = yi_range)
                let(
                    xi = columns - 1,
                    idx1 = xy_to_index(xi, yi, columns),
                    idx2 = xy_to_index(xi, yi + 1, columns)
                )
                [
                    idx1,
                    idx2,
                    idx2 + leng_pts,
                    idx1 + leng_pts
                ]
        ];                  
      
        side_faces3 = [
            for(xi = xi_range)
                let(
                    yi = rows - 1,
                    idx1 = xy_to_index(xi, yi, columns), 
                    idx2 = xy_to_index(xi + 1, yi, columns)
                )
                [
                    idx2,
                    idx1,
                    idx1 + leng_pts,
                    idx2 + leng_pts
                ]
        ];
        
        side_faces4 = [
            for(yi = yi_range)
                let(
                    idx1 = xy_to_index(0, yi, columns),
                    idx2 = xy_to_index(0, yi + 1, columns)
                )
                [
                    idx2,
                    idx1,
                    idx1 + leng_pts,
                    idx2 + leng_pts
                ]
        ];                  
        
        pts = concat(top_pts, base_pts);
        face_idxs = concat(
                top_tri_faces1, top_tri_faces2,
                base_tri_faces1, base_tri_faces2, 
                side_faces1, 
                side_faces2, 
                side_faces3, 
                side_faces4
            );

        polyhedron(
            points = pts, 
            faces = face_idxs
        );

        // hook for testing
        test_function_grapher_faces(pts, face_idxs);
    }

    module tri_to_lines(tri1, tri2) {
       polyline3d(concat(tri1, [tri1[0]]), thickness);
       polyline3d(concat(tri2, [tri2[0]]), thickness);
    }

    module tri_to_hull_lines(tri1, tri2) {
       hull_polyline3d(concat(tri1, [tri1[0]]), thickness);
       hull_polyline3d(concat(tri2, [tri2[0]]), thickness);
    }    
    
    module hull_pts(tri) {
       half_thickness = thickness / 2;
       hull() {
           translate(tri[0]) sphere(half_thickness);
           translate(tri[1]) sphere(half_thickness);
           translate(tri[2]) sphere(half_thickness);
       }    
    }
    
    module tri_to_hull_faces(tri1, tri2) {
       hull_pts(tri1);
       hull_pts(tri2);
    }    

    module tri_to_graph(tri1, tri2) {
        if(style == "LINES") {
            tri_to_lines(tri1, tri2);
        } else if(style == "HULL_FACES") {  // Warning: May be very slow!!
            tri_to_hull_faces(tri1, tri2);
        } else if(style == "HULL_LINES") {  // Warning: very very slow!!
            tri_to_hull_lines(tri1, tri2);
        }
    }
    
    if(style == "FACES") {
        faces();
    } else {
        for(yi = yi_range) {
            for(xi = xi_range) {
                if(slicing == "SLASH") {
                    tri_to_graph([
                        points[yi][xi], 
                        points[yi][xi + 1], 
                        points[yi + 1][xi + 1]
                    ], [
                        points[yi][xi], 
                        points[yi + 1][xi + 1], 
                        points[yi + 1][xi]
                    ]);
                } else {                
                    tri_to_graph([
                        points[yi][xi], 
                        points[yi][xi + 1], 
                        points[yi + 1][xi]
                    ], [
                        points[yi + 1][xi], 
                        points[yi][xi + 1], 
                        points[yi + 1][xi + 1]
                    ]);                    
                }        
            }
        }
    }
}

// override it to test
module test_function_grapher_faces(points, faces) {

}

/**
* bspline_curve.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-bspline_curve.html
*
**/

function _bspline_curve_knots(n, degree) = 
    let(end = n + degree + 1)
    [for(i = 0; i < end; i = i + 1) i];
    
function _bspline_curve_weights(n) = [for(i = 0; i < n; i = i + 1) 1];

function _bspline_curve_ts(ot, degree, knots) = 
    let(
        domain = [degree, len(knots) - 1 - degree],
        low  = knots[domain[0]],
        high = knots[domain[1]],
        t = ot * (high - low) + low,
        s = _bspline_curve_s(domain[0], domain[1], t, knots)
    )
    [t, s];
    
function _bspline_curve_s(s, end, t, knots) =
    t >= knots[s] && t <= knots[s+1] ? 
        s : _bspline_curve_s(s + 1, end, t, knots);

function _bspline_curve_alpha(i, l, t, degree, knots) = 
    (t - knots[i]) / (knots[i + degree + 1 - l] - knots[i]);

function _bspline_curve_nvi(v, i, l, t, degree, knots) =
    let(
        alpha = _bspline_curve_alpha(i, l, t, degree, knots)
    )
    [[for(j = 0; j< 4; j = j + 1) ((1 - alpha) * v[i - 1][j] + alpha * v[i][j])]];

function _bspline_curve_nvl(v, l, s, t, degree, knots, i) = 
    i == (s - degree - 1 + l) ? v :
    let(
        leng_v = len(v),
        nvi = _bspline_curve_nvi(v, i, l, t, degree, knots),
        nv = concat(
            [for(j = 0; j < i; j = j + 1) v[j]],
            nvi,
            [for(j = i + 1; j < leng_v; j = j + 1) v[j]]
        )
    )
    _bspline_curve_nvl(nv, l, s, t, degree, knots, i - 1);

function _bspline_curve_v(v, s, t, degree, knots, l = 1) = 
    l > degree + 1 ? v : 
      let(nv = _bspline_curve_nvl(v, l, s, t, degree, knots, s))
      _bspline_curve_v(nv, s, t, degree, knots, l + 1);
        
function _bspline_curve_interpolate(t, degree, points, knots, weights) =
    let(
        d = len(points[0]),
        n = len(points),
        kts = is_undef(knots) ? _bspline_curve_knots(n, degree) : knots,
        wts = is_undef(weights) ? _bspline_curve_weights(n) : weights,
        v = [
            for(i = 0; i < n; i = i + 1) 
            let(p = points[i] * wts[i])
            concat([for(j = 0; j < d; j = j + 1) p[j]], [wts[i]])
        ],
        ts = _bspline_curve_ts(t, degree, kts),
        s = ts[1],
        nv = _bspline_curve_v(v, s, ts[0], degree, kts)
    )
    [for(i = 0; i < d; i = i + 1) nv[s][i] / nv[s][d]];
    
function bspline_curve(t_step, degree, points, knots, weights) = 
    let(n = len(points))
    assert(degree >= 1, "degree cannot be less than 1 (linear)")
    assert(degree <= n - 1, "degree must be less than or equal to len(points) - 1")
    assert(is_undef(knots) || (len(knots) == n + degree + 1), "len(knots) must be equals to len(points) + degree + 1")
    [
        for(t = 0; t < 1; t = t + t_step) 
        _bspline_curve_interpolate(t, degree, points, knots, weights)
    ];    

function __nearest_multiple_of_4(n) =
    let(
        remain = n % 4
    )
    (remain / 4) > 0.5 ? n - remain + 4 : n - remain;


/**
* bend_extrude.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-bend_extrude.html
*
**/

module bend_extrude(size, thickness, angle, frags = 24) {
    x = size[0];
    y = size[1];
    frag_width = x / frags ;
    frag_angle = angle / frags;
    half_frag_width = 0.5 * frag_width;
    half_frag_angle = 0.5 * frag_angle;
    r = half_frag_width / sin(half_frag_angle);
    s =  (r - thickness) / r;
    
    module get_frag(i) {
        offsetX = i * frag_width;
        linear_extrude(thickness, scale = [s, 1]) 
            translate([-offsetX - half_frag_width, 0, 0]) 
            intersection() {
                translate([x, 0, 0]) 
                mirror([1, 0, 0]) 
                    children();
                translate([offsetX, 0, 0]) 
                    square([frag_width, y]);
            }
    }

    offsetY = -r * cos(half_frag_angle) ;

    rotate(angle - 90)
    mirror([0, 1, 0])
    mirror([0, 0, 1])
        for(i = [0 : frags - 1]) {
        rotate(i * frag_angle + half_frag_angle) 
            translate([0, offsetY, 0])
            rotate([-90, 0, 0]) 
                get_frag(i) 
                    children();  
        }
}


/**
* hollow_out.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-hollow_out.html
*
**/

module hollow_out(shell_thickness) {
    difference() {
        children();
        offset(delta = -shell_thickness) children();
    }
}

/**
* hull_polyline3d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/hull_polyline3d.html
*
**/

module hull_polyline3d(points, thickness) {
    half_thickness = thickness / 2;
    leng = len(points);
    
    module hull_line3d(index) {
        point1 = points[index - 1];
        point2 = points[index];

        hull() {
            translate(point1) 
                sphere(half_thickness);
            translate(point2) 
                sphere(half_thickness);
        }

        // hook for testing
        test_line_segment(index, point1, point2, half_thickness);        
    }

    module polyline3d_inner(index) {
        if(index < leng) {
            hull_line3d(index);
            polyline3d_inner(index + 1);
        }
    }

    polyline3d_inner(1);
}

// override it to test
module test_line_segment(index, point1, point2, radius) {

}

/**
* multi_line_text.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-multi_line_text.html
*
**/ 
module multi_line_text(lines, line_spacing = 15, size = 10, font = "Arial", halign = "left", valign = "baseline", direction = "ltr", language = "en", script = "latin"){
    to = len(lines) - 1;
    inc = line_spacing;
    offset_y = inc * to / 2;

    for (i = [0 : to]) {
        translate([0 , -i * inc + offset_y, 0]) 
            text(lines[i], size, font = font, valign = valign, halign = halign, direction = direction, language = language, script = script);
    }
}

/**
* t2d.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-t2d.html
*
**/ 

function _t2d_turtle(point, angle) = 
    [is_undef(point) ? [0, 0] : point, is_undef(angle) ? 0 : angle];

function _t2d_set_point(t, point) = [point, _t2d_get_angle(t)];

function _t2d_set_x(t, x) = [[x, _t2d_get_y(t)], _t2d_get_angle(t)];
function _t2d_set_y(t, y) = [[_t2d_get_x(t), y], _t2d_get_angle(t)];
function _t2d_set_angle(t, angle) = [_t2d_get_pt(t), angle];

function _t2d_forward(t, leng) = 
    _t2d_turtle(
        [
            _t2d_get_x(t) + leng * cos(_t2d_get_angle(t)), 
            _t2d_get_y(t) + leng * sin(_t2d_get_angle(t))
        ], 
        _t2d_get_angle(t)
    );

function _t2d_turn(t, angle) = [_t2d_get_pt(t), _t2d_get_angle(t) + angle];

function _t2d_get_x(t) = t[0][0];
function _t2d_get_y(t) = t[0][1];
function _t2d_get_pt(t) = t[0];
function _t2d_get_angle(t) = t[1];

function _t2d_get(t, cmd) =
    cmd == "angle" ? _t2d_get_angle(t) : 
    cmd == "point" ? _t2d_get_pt(t) : 
    assert(false, "unknown command");

function _t2d_set(t, point, angle) =
    !is_undef(point) ? _t2d_set_point(t, point) :
    !is_undef(angle) ? _t2d_set_angle(t, angle) :
    assert(false, "no target to set");

function _t2d_cmdline(cmd, t, arg) = 
    is_undef(arg) ? _t2d_get(t, cmd) : 
    cmd == "forward" ? _t2d_forward(t, arg) : 
    cmd == "turn" ? _t2d_turn(t, arg) :
    cmd == "point" ? _t2d_set_point(t, arg) : 
    cmd == "angle" ? _t2d_set_angle(t, arg) :  
    assert(false, "unknown command");

function _t2d_cmd(t, cmd, point, angle, leng) = 
    cmd == "forward" ? _t2d_forward(t, leng) :
    cmd == "turn" ? _t2d_turn(t, angle) :
    _t2d_get(t, cmd);

function _t2d_cmds(t, cmds, i = 0) = 
    i == len(cmds) ? t :
    let(
        cmd = cmds[i][0],
        arg = cmds[i][1]
    )
    _t2d_cmds(_t2d_cmdline(cmd, t, arg), cmds, i + 1);

function t2d(t, cmd, point, angle, leng) =
    is_undef(t) ? _t2d_turtle(point, angle) : 
    is_undef(cmd) ? _t2d_set(t, point, angle) :
    is_string(cmd) ? _t2d_cmd(t, cmd, point, angle, leng) :
                     _t2d_cmds(t, cmd);

/**
* helix.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-helix.html
*
**/ 


function helix(radius, levels, level_dist, vt_dir = "SPI_DOWN", rt_dir = "CT_CLK") = 
    let(
        is_SPI_DOWN = vt_dir == "SPI_DOWN",
        is_flt = is_num(radius),
        r1 = is_flt ? radius : radius[0],
        r2 = is_flt ? radius : radius[1],
        h = level_dist * levels,
        begin_r = is_SPI_DOWN ? r2 : r1,
        begin_h = is_SPI_DOWN ? h : 0,
        _frags = __frags(begin_r),        
        vt_d = is_SPI_DOWN ? 1 : -1,
        rt_d = rt_dir == "CT_CLK" ? 1 : -1,
        r_diff = (r1 - r2) * vt_d,
        h_step = level_dist / _frags * vt_d,
        r_step = r_diff / (levels * _frags),
        a_step = 360 / _frags * rt_d,
        end_i = _frags * levels
    )
    [
        for(i = 0; i <= end_i; i = i + 1) 
            let(r = begin_r + r_step * i, a = a_step * i)
                [r * cos(a), r * sin(a), begin_h - h_step * i]
    ];

/**
* path_scaling_sections.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-path_scaling_sections.html
*
**/


function path_scaling_sections(shape_pts, edge_path) = 
    let(
        start_point = edge_path[0],
        base_leng = norm(start_point),
        scaling_matrice = [
            for(p = edge_path) 
            let(s = norm([p[0], p[1], 0]) / base_leng)
            __m_scaling([s, s, 1])
        ],
        leng_edge_path = len(edge_path)
    )
    __reverse([
        for(i = 0; i < leng_edge_path; i = i + 1)
        [
            for(p = shape_pts) 
            let(scaled_p = scaling_matrice[i] * [p[0], p[1], edge_path[i][2], 1])
            [scaled_p[0], scaled_p[1], scaled_p[2]]
        ]
    ]);

/**
* rounded_square.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rounded_square.html
*
**/


module rounded_square(size, corner_r, center = false) {
    is_flt = is_num(size);
    x = is_flt ? size : size[0];
    y = is_flt ? size : size[1];       
    
    position = center ? [0, 0] : [x / 2, y / 2];
    points = __trapezium(
        length = x, 
        h = y, 
        round_r = corner_r
    );

    translate(position) 
        polygon(points);

    // hook for testing
    test_rounded_square(position, points);
}

// override it to test
module test_rounded_square(position, points) {
}

/**
* ring_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-ring_extrude.html
*
**/


module ring_extrude(shape_pts, radius, angle = 360, twist = 0, scale = 1.0, triangles = "SOLID") {
    if(twist == 0 && scale == 1.0) {
        rotate_extrude(angle = angle) 
        translate([radius, 0, 0]) 
            polygon(shape_pts);
    } else {
        a_step = 360 / __frags(radius);

        angles = is_num(angle) ? [0, angle] : angle;

        m = floor(angles[0] / a_step) + 1;
        n = floor(angles[1] / a_step);

        leng = radius * cos(a_step / 2);

        begin_r = leng / cos((m - 0.5) * a_step - angles[0]);
        end_r =  leng / cos((n + 0.5) * a_step - angles[1]);

        angs = concat(
            [[90, 0, angles[0]]], 
            m > n ? [] : [for(i = [m:n]) [90, 0, a_step * i]]
        );
        pts = concat(
            [__ra_to_xy(begin_r, angles[0])],
            m > n ? [] : [for(i = [m:n]) __ra_to_xy(radius, a_step * i)]
        ); 

        is_angle_frag_end = angs[len(angs) - 1][2] == angles[1];
        
        all_angles = is_angle_frag_end ? 
            angs :  
            concat(angs, [[90, 0, angles[1]]]);
            
        all_points = is_angle_frag_end ? 
            pts :
            concat(pts, [__ra_to_xy(end_r, angles[1])]);

        sections = cross_sections(shape_pts, all_points, all_angles, twist, scale);

        polysections(
            sections,
            triangles = triangles
        );

        // hook for testing
        test_ring_extrude(sections);
    }
}

// Override it to test
module test_ring_extrude(sections) {

}

/**
* shape_cyclicpolygon.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_cyclicpolygon.html
*
**/


function shape_cyclicpolygon(sides, circle_r, corner_r) =
    let(
        frag_a = 360 / sides,
        corner_a = (180 - frag_a),
        corner_circle_a = 180 - corner_a,
        half_corner_circle_a = corner_circle_a / 2,
        corner_circle_center = circle_r - corner_r / sin(corner_a / 2),
        first_corner = [
            for(
                    pt = __pie_for_rounding(
                        corner_r, 
                        -half_corner_circle_a, 
                        half_corner_circle_a, 
                        __frags(corner_r) * corner_circle_a / 360
                    )
               )
               [pt[0] + corner_circle_center, pt[1]]
        ]

    )
    concat(
        first_corner, 
        [
            for(side = 1; side < sides; side = side + 1)
                for(pt = first_corner)
                    let(
                        a = frag_a * side,
                        x = pt[0],
                        y = pt[1],
                        sina = sin(a),
                        cosa = cos(a)
                    )
                    [
                        x * cosa - y * sina,
                        x * sina + y * cosa
                    ]
        ]
    );

/**
* shape_trapezium.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_trapezium.html
*
**/


function shape_trapezium(length, h, corner_r = 0) = 
    __trapezium(
        length = length, 
        h = h, 
        round_r = corner_r
    );
    

/**
* triangulate.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-triangulate.html
*
**/

function _triangulate_in_triangle(p0, p1, p2, p) =
    let(
        v0 = p0 - p,
        v1 = p1 - p,
        v2 = p2 - p,
        c0 = cross(v0, v1),
        c1 = cross(v1, v2),
        c2 = cross(v2, v0)
    )
    (c0 > 0 && c1 > 0 && c2 > 0) || (c0 < 0 && c1 < 0 && c2 < 0);

function _triangulate_snipable(shape_pts, u, v, w, n, indices, epsilon = 0.0001) =
    let(
        a = shape_pts[indices[u]],
        b = shape_pts[indices[v]],
        c = shape_pts[indices[w]],
        ax = a[0],
        ay = a[1],
        bx = b[0],
        by = b[1],
        cx = c[0],
        cy = c[1]
    )
    epsilon > (((bx - ax) * (cy - ay)) - ((by - ay) * (cx - ax))) ? 
        false : _triangulate_snipable_sub(shape_pts, n, u, v, w, a, b, c, indices);
    
function _triangulate_snipable_sub(shape_pts, n, u, v, w, a, b, c, indices, p = 0) = 
    p == n ? true : (
        ((p == u) || (p == v) || (p == w)) ? _triangulate_snipable_sub(shape_pts, n, u, v, w, a, b, c, indices, p + 1) : (
            _triangulate_in_triangle(a, b, c, shape_pts[indices[p]]) ? 
                false : _triangulate_snipable_sub(shape_pts, n, u, v, w, a, b, c, indices, p + 1)
        )
    );

// remove the elem at idx v from indices  
function _triangulate_remove_v(indices, v, num_of_vertices) = 
    let(
        nv_minuns_one = num_of_vertices - 1
    )
    v == 0 ? [for(i = 1; i <= nv_minuns_one; i = i + 1) indices[i]] : (
        v == nv_minuns_one ? [for(i = 0; i < v; i = i + 1) indices[i]] : concat(
            [for(i = 0; i < v; i = i + 1) indices[i]], 
            [for(i = v + 1; i <= nv_minuns_one; i = i + 1) indices[i]]
        )
    );
    
function _triangulate_zero_or_value(num_of_vertices, value) = 
    num_of_vertices <= value ? 0 : value;

function _triangulate_real_triangulate_sub(shape_pts, collector, indices, v, num_of_vertices, count, epsilon) = 
    let(
        // idxes of three consecutive vertices
        u = _triangulate_zero_or_value(num_of_vertices, v),     
        vi = _triangulate_zero_or_value(num_of_vertices, u + 1), 
        w = _triangulate_zero_or_value(num_of_vertices, vi + 1) 
    )
    _triangulate_snipable(shape_pts, u, vi, w, num_of_vertices, indices, epsilon) ? 
        _triangulate_snip(shape_pts, collector, indices, u, vi, w, num_of_vertices, count, epsilon) : 
        _triangulate_real_triangulate(shape_pts, collector, indices, vi, num_of_vertices, count, epsilon);
        
function _triangulate_snip(shape_pts, collector, indices, u, v, w, num_of_vertices, count, epsilon) = 
    let(
        a = indices[u],
        b = indices[v],
        c = indices[w],
        new_nv = num_of_vertices - 1
    )
    _triangulate_real_triangulate( 
        shape_pts, 
        concat(collector, [[a, b, c]]),  
        _triangulate_remove_v(indices, v, num_of_vertices),
        v, 
        new_nv,
        2 * new_nv,
        epsilon
    );

function _triangulate_real_triangulate(shape_pts, collector, indices, v, num_of_vertices, count, epsilon) = 
    count <= 0 ? [] : (
        num_of_vertices == 2 ? 
            collector : _triangulate_real_triangulate_sub(shape_pts, collector, indices, v, num_of_vertices, count - 1,  epsilon)
    );
    
function triangulate(shape_pts,  epsilon = 0.0001) =
    let(
        num_of_vertices = len(shape_pts),
        v = num_of_vertices - 1,
        indices = [for(vi = 0; vi <= v; vi = vi + 1) vi],
        count = 2 * num_of_vertices        
    )
    num_of_vertices < 3 ? [] : _triangulate_real_triangulate(shape_pts, [], indices, v, num_of_vertices, count, epsilon);
       

/**
* along_with.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-along_with.html
*
**/ 
 

module along_with(points, angles, twist = 0, scale = 1.0, method = "AXIS_ANGLE") {
    leng_points = len(points);
    leng_points_minus_one = leng_points - 1;
    twist_step_a = twist / leng_points;

    angles_defined = !is_undef(angles);

    scale_step_vt = is_num(scale) ? 
        let(s =  (scale - 1) / leng_points_minus_one) [s, s, s] :
        [
            (scale[0] - 1) / leng_points_minus_one, 
            (scale[1] - 1) / leng_points_minus_one,
            is_undef(scale[2]) ? 0 : (scale[2] - 1) / leng_points_minus_one
        ]; 

    /* 
         Sadly, children(n) cannot be used with inner modules 
         so I have to do things in the first level. Ugly!!
    */

    // >>> begin: modules and functions for "AXIS-ANGLE"

    // get rotation matrice for sections
    identity_matrix = [
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
    ];    

    function axis_angle_local_ang_vects(j) = 
        [
            for(i = j; i > 0; i = i - 1) 
            let(
                vt0 = points[i] - points[i - 1],
                vt1 = points[i + 1] - points[i],
                a = acos((vt0 * vt1) / (norm(vt0) * norm(vt1))),
                v = cross(vt0, vt1)
            )
            [a, v]
        ];

    function axis_angle_cumulated_rot_matrice(i, rot_matrice) = 
        let(
            leng_rot_matrice = len(rot_matrice),
            leng_rot_matrice_minus_one = leng_rot_matrice - 1,
            leng_rot_matrice_minus_two = leng_rot_matrice - 2
        )
        leng_rot_matrice == 0 ? [identity_matrix] : (
            leng_rot_matrice == 1 ? [rot_matrice[0], identity_matrix] : (
                i == leng_rot_matrice_minus_two ? 
               [
                   rot_matrice[leng_rot_matrice_minus_one], 
                   rot_matrice[leng_rot_matrice_minus_two] * rot_matrice[leng_rot_matrice_minus_one]
               ] 
               : axis_angle_cumulated_rot_matrice_sub(i, rot_matrice)
            )
        );

    function axis_angle_cumulated_rot_matrice_sub(i, rot_matrice) = 
        let(
            matrice = axis_angle_cumulated_rot_matrice(i + 1, rot_matrice),
            curr_matrix = rot_matrice[i],
            prev_matrix = matrice[len(matrice) - 1]
        )
        concat(matrice, [curr_matrix * prev_matrix]);

    // align modules

    module axis_angle_align_with_pts_angles(i) {
        translate(points[i]) 
        rotate(angles[i])
        rotate(twist_step_a * i) 
        scale([1, 1, 1] + scale_step_vt * i) 
            children(0);
    }

    module axis_angle_align_with_pts_init(a, s) {
        angleyz = __angy_angz(__to3d(points[0]), __to3d(points[1]));
        rotate([0, -angleyz[0], angleyz[1]])
        rotate([90, 0, -90])
        rotate(a)
        scale(s) 
            children(0);
    }
    
    module axis_angle_align_with_pts_local_rotate(j, init_a, init_s, cumu_rot_matrice) {
        if(j == 0) {  // first child
            axis_angle_align_with_pts_init(init_a, init_s) 
                children(0);
        }
        else {
            multmatrix(cumu_rot_matrice[j - 1])
            axis_angle_align_with_pts_init(init_a, init_s) 
                children(0);
        }
    } 

    // <<< end: modules and functions for "AXIS-ANGLE"


    // >>> begin: modules and functions for "EULER-ANGLE"

    function _euler_angle_path_angles(pts, end_i) = 
        [for(i = 0; i < end_i; i = i + 1) __angy_angz(pts[i], pts[i + 1])];
            
    function euler_angle_path_angles(children) = 
       let(
           pts = len(points[0]) == 3 ? points : [for(pt = points) __to3d(pt)],
           end_i = children == 1 ? leng_points_minus_one : children - 1,
           angs = _euler_angle_path_angles(pts, end_i)
        )
       concat(
           [[0, -angs[0][0], angs[0][1]]], 
           [for(a = angs) [0, -a[0], a[1]]]
       );

    module euler_angle_align(i, angs) {
        translate(points[i]) 
        rotate(angs[i])
        rotate(angles_defined ? [0, 0, 0] : [90, 0, -90])
        rotate(twist_step_a * i) 
        scale([1, 1, 1] + scale_step_vt * i) 
            children(0);
    }

    // <<< end: modules and functions for "EULER-ANGLE"

    if(method == "AXIS_ANGLE") {
        if(angles_defined) {
            if($children == 1) { 
                for(i = [0:leng_points_minus_one]) {
                    axis_angle_align_with_pts_angles(i) children(0);
                }
            } else {
                for(i = [0:min(leng_points, $children) - 1]) {
                    axis_angle_align_with_pts_angles(i) children(i);
                }
            }
        }
        else {
            cumu_rot_matrice = axis_angle_cumulated_rot_matrice(0, [
                for(ang_vect = axis_angle_local_ang_vects(leng_points - 2)) 
                    __m_rotation(ang_vect[0], ang_vect[1])
            ]);

            translate(points[0])
            axis_angle_align_with_pts_local_rotate(0, 0, [1, 1, 1], cumu_rot_matrice)
                children(0); 

            if($children == 1) { 
                for(i = [0:leng_points - 2]) {
                    translate(points[i + 1])
                    axis_angle_align_with_pts_local_rotate(i, i * twist_step_a, [1, 1, 1] + scale_step_vt * i, cumu_rot_matrice)
                        children(0);          
                }          
            } else {
                for(i = [0:min(leng_points, $children) - 2]) {
                    translate(points[i + 1])
                    axis_angle_align_with_pts_local_rotate(i, i * twist_step_a, [1, 1, 1] + scale_step_vt * i, cumu_rot_matrice)
                        children(i + 1);   
                }
            }
        }
    }
    else if(method == "EULER_ANGLE") {
        angs = angles_defined ? angles : euler_angle_path_angles($children);
        
        if($children == 1) { 
            for(i = [0:leng_points_minus_one]) {
                euler_angle_align(i, angs) children(0);
            }
        } else {
            for(i = [0:min(leng_points, $children) - 1]) {
                euler_angle_align(i, angs) children(i);
            }
        }    

        test_along_with_angles(angs);    
    }
}

module test_along_with_angles(angles) {

}

/**
* paths2sections.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-paths2sections.html
*
**/

function paths2sections(paths) =
    let(
        leng_path = len(paths[0]),
        leng_paths = len(paths)
    )
    [
        for(i = 0; i < leng_path; i = i + 1)
            [
                for(j = 0; j < leng_paths; j = j + 1)
                    paths[j][i]
            ] 
    ];

/**
* px_line.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_line.html
*
**/ 


function _px_line_zsgn(a) = a == 0 ? a : a / abs(a);
    
// x-dominant
function _px_line_xdominant_y(y, yd, sy) = yd >= 0 ? y + sy : y;
function _px_line_xdominant_yd(yd, ax, ay) = (yd >= 0 ? yd - ax : yd) + ay;
function _px_line_xdominant_z(z, zd, sz) = zd >= 0 ? z + sz : z;
function _px_line_xdominant_zd(zd, ax, az) = (zd >= 0 ? zd - ax : zd) + az;

function _px_line_xdominant(start, end, a, s) = 
    let(
        x = start[0],
        y = start[1],
        z = start[2],
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2],        
        shrx = floor(ax / 2),
        yd = ay - shrx,
        zd = az - shrx,
        endx = end[0]
    )
    concat(
        [start], 
        _px_line_xdominant_sub(
            x + sx, 
            _px_line_xdominant_y(y, yd, sy), 
            _px_line_xdominant_z(z, zd, sz), 
            endx, 
            a, 
            s, 
            _px_line_xdominant_yd(yd, ax, ay), 
            _px_line_xdominant_zd(zd, ax, az)
        )
    );

function _px_line_xdominant_sub(x, y, z, endx, a, s, yd, zd) = 
    let(
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2]
    )
    x == endx ? [] : 
        concat([[x, y, z]], 
            _px_line_xdominant_sub(
                x + sx, 
                _px_line_xdominant_y(y, yd, sy), 
                _px_line_xdominant_z(z, zd, sz), 
                endx, 
                a, 
                s, 
                _px_line_xdominant_yd(yd, ax, ay), 
                _px_line_xdominant_zd(zd, ax, az)
            )
        );
        
// y-dominant
function _px_line_ydominant_x(x, xd, sx) = xd >= 0 ? x + sx : x;
function _px_line_ydominant_xd(xd, ax, ay) = (xd >= 0 ? xd - ay : xd) + ax;
function _px_line_ydominant_z(z, zd, sz) = zd >= 0 ? z + sz : z;
function _px_line_ydominant_zd(zd, ay, az) = (zd >= 0 ? zd - ay : zd) + az;
        
function _px_line_ydominant(start, end, a, s) = 
    let(
        x = start[0],
        y = start[1],
        z = start[2],
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2],        
        shry = floor(ay / 2),
        xd = ax - shry,
        zd = az - shry,
        endy = end[1]
    )
    concat(
        [start], 
        _px_line_ydominant_sub(
            _px_line_ydominant_x(x, xd, sx), 
            y + sy,
            _px_line_ydominant_z(z, zd, sz), 
            endy, 
            a, 
            s, 
            _px_line_ydominant_xd(xd, ax, ay), 
            _px_line_ydominant_zd(zd, ay, az)
        )
    );

function _px_line_ydominant_sub(x, y, z, endy, a, s, xd, zd) = 
    let(
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2]
    )
    y == endy ? [] : 
        concat([[x, y, z]], 
            _px_line_ydominant_sub(
                _px_line_ydominant_x(x, xd, sx), 
                y + sy,
                _px_line_ydominant_z(z, zd, sz), 
                endy, 
                a, 
                s, 
                _px_line_ydominant_xd(xd, ax, ay), 
                _px_line_ydominant_zd(zd, ay, az)
            )
        );

// z-dominant
function _px_line_zdominant_x(x, xd, sx) = xd >= 0 ? x + sx : x;
function _px_line_zdominant_xd(xd, ax, az) = (xd >= 0 ? xd - az : xd) + ax;

function _px_line_zdominant_y(y, yd, sy) = yd >= 0 ? y + sy : y;
function _px_line_zdominant_yd(yd, ay, az) = (yd >= 0 ? yd - az : yd) + ay;
        
function _px_line_zdominant(start, end, a, s) = 
    let(
        x = start[0],
        y = start[1],
        z = start[2],
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2],        
        shrz = floor(az / 2),
        xd = ax - shrz,
        yd = ay - shrz,
        endz = end[2]
    )
    concat(
        [start], 
        _px_line_zdominant_sub(
            _px_line_zdominant_x(x, xd, sx), 
            _px_line_zdominant_y(y, yd, sy), 
            z + sz,
            endz, 
            a, 
            s, 
            _px_line_zdominant_xd(xd, ax, az), 
            _px_line_zdominant_yd(yd, ay, az)
        )
    );

function _px_line_zdominant_sub(x, y, z, endz, a, s, xd, yd) = 
    let(
        ax = a[0],
        ay = a[1],
        az = a[2],
        sx = s[0],
        sy = s[1],
        sz = s[2]
    )
    z == endz ? [] : 
        concat([[x, y, z]], 
            _px_line_zdominant_sub(
                _px_line_zdominant_x(x, xd, sx), 
                _px_line_zdominant_y(y, yd, sy), 
                z + sz,
                endz, 
                a, 
                s, 
                _px_line_zdominant_xd(xd, ax, az), 
                _px_line_zdominant_yd(yd, ay, az)
            )
        );
        
function px_line(p1, p2) = 
    let(
        is_2d = len(p1) == 2,
        start_pt = is_2d ? __to3d(p1) : p1,
        end_pt = is_2d ? __to3d(p2) : p2,
        dt = end_pt - start_pt,
        ax = floor(abs(dt[0]) * 2),
        ay = floor(abs(dt[1]) * 2),
        az = floor(abs(dt[2]) * 2),
        sx = _px_line_zsgn(dt[0]),
        sy = _px_line_zsgn(dt[1]),
        sz = _px_line_zsgn(dt[2]),
        points = ax >= max(ay, az) ? _px_line_xdominant(start_pt, end_pt, [ax, ay, az], [sx, sy, sz]) : (
            ay >= max(ax, az) ? _px_line_ydominant(start_pt, end_pt, [ax, ay, az], [sx, sy, sz]) :
                _px_line_zdominant(start_pt, end_pt, [ax, ay, az], [sx, sy, sz])
        )
    )   
    is_2d ? [for(pt = points) __to2d(pt)] : points;

function __lines_from(pts, closed = false) = 
    let(
        leng = len(pts),
        endi = leng - 1
    )
    concat(
        [for(i = 0; i < endi; i = i + 1) [pts[i], pts[i + 1]]], 
        closed ? [[pts[len(pts) - 1], pts[0]]] : []
    );
    

/**
* sort.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-sort.html
*
**/ 

function _sort(lt, i) = 
    let(leng = len(lt))
    leng <= 1 ? lt : 
        let(
            pivot = lt[0],
            before = [for(j = 1; j < leng; j = j + 1) if(lt[j][i] < pivot[i]) lt[j]],
            after =  [for(j = 1; j < leng; j = j + 1) if(lt[j][i] >= pivot[i]) lt[j]]
        )
        concat(_sort(before, i), [pivot], _sort(after, i));

function sort(lt, by = "idx", idx = 0) =
    let(
        dict = [["x", 0], ["y", 1], ["z", 0], ["idx", idx]],
        i = dict[search(by, dict)[0]][1]
    )
    _sort(lt, i);

/**
* arc_shape.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-arc_path.html
*
**/ 


function arc_path(radius, angle) =
    let(
        frags = __frags(radius),
        a_step = 360 / frags,
        angles = is_num(angle) ? [0, angle] : angle,
        m = floor(angles[0] / a_step) + 1,
        n = floor(angles[1] / a_step),
        points = concat([__ra_to_xy(__edge_r_begin(radius, angles[0], a_step, m), angles[0])],
            m > n ? [] : [
                for(i = m; i <= n; i = i + 1)
                    __ra_to_xy(radius, a_step * i)
            ],
            angles[1] == a_step * n ? [] : [__ra_to_xy(__edge_r_end(radius, angles[1], a_step, n), angles[1])])
    ) points;

/**
* trim_shape.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-trim_shape.html
*
**/


function _trim_shape_any_intersection_sub(lines, line, lines_leng, i, epsilon) =
    let(
        p = __line_intersection(lines[i], line, epsilon)
    )
    (p != [] && __in_line(line, p, epsilon) && __in_line(lines[i], p, epsilon)) ? [i, p] : _trim_shape_any_intersection(lines, line, lines_leng, i + 1, epsilon);

// return [idx, [x, y]] or []
function _trim_shape_any_intersection(lines, line, lines_leng, i, epsilon) =
    i == lines_leng ? [] : _trim_shape_any_intersection_sub(lines, line, lines_leng, i, epsilon);

function _trim_sub(lines, leng, epsilon) = 
    let(
        current_line = lines[0],
        next_line = lines[1],
        lines_from_next = [for(j = 1; j < leng; j = j + 1) lines[j]],
        lines_from_next2 = [for(j = 2; j < leng; j = j + 1) lines[j]],
        current_p = current_line[0],
        leng_lines_from_next2 = len(lines_from_next2),
        inter_p = _trim_shape_any_intersection(lines_from_next2, current_line, leng_lines_from_next2, 0, epsilon)
    )
    // no intersecting pt, collect current_p and trim remain lines
    inter_p == [] ? (concat([current_p], _trim_shape_trim_lines(lines_from_next, epsilon))) : (
        // collect current_p, intersecting pt and the last pt
        (leng == 3 || (inter_p[0] == (leng_lines_from_next2 - 1))) ? [current_p, inter_p[1], lines[leng - 1]] : (
            // collect current_p, intersecting pt and trim remain lines
            concat([current_p, inter_p[1]], 
                _trim_shape_trim_lines([for(i = inter_p[0] + 1; i < leng_lines_from_next2; i = i + 1) lines_from_next2[i]], epsilon)
            )
        )
    );
    
function _trim_shape_trim_lines(lines, epsilon) = 
    let(leng = len(lines))
    leng > 2 ? _trim_sub(lines, leng, epsilon) : _trim_shape_collect_pts_from(lines, leng);

function _trim_shape_collect_pts_from(lines, leng) = 
    concat([for(line = lines) line[0]], [lines[leng - 1][1]]);

function trim_shape(shape_pts, from, to, epsilon = 0.0001) = 
    let(
        pts = [for(i = from; i <= to; i = i + 1) shape_pts[i]],
        trimmed = _trim_shape_trim_lines(__lines_from(pts), epsilon)
    )
    len(shape_pts) == len(trimmed) ? trimmed : trim_shape(trimmed, 0, len(trimmed) - 1, epsilon);


function __shape_arc(radius, angle, width, width_mode = "LINE_CROSS") =
    let(
        w_offset = width_mode == "LINE_CROSS" ? [width / 2, -width / 2] : (
            width_mode == "LINE_INWARD" ? [0, -width] : [width, 0]
        ),
        frags = __frags(radius),
        a_step = 360 / frags,
        half_a_step = a_step / 2,
        angles = is_num(angle) ? [0, angle] : angle,
        m = floor(angles[0] / a_step) + 1,
        n = floor(angles[1] / a_step),
        r_outer = radius + w_offset[0],
        r_inner = radius + w_offset[1],
        points = concat(
            // outer arc path
            [__ra_to_xy(__edge_r_begin(r_outer, angles[0], a_step, m), angles[0])],
            m > n ? [] : [
                for(i = m; i <= n; i = i + 1)  __ra_to_xy(r_outer, a_step * i)
            ],
            angles[1] == a_step * n ? [] : [__ra_to_xy(__edge_r_end(r_outer, angles[1], a_step, n), angles[1])],
            // inner arc path
            angles[1] == a_step * n ? [] : [__ra_to_xy(__edge_r_end(r_inner, angles[1], a_step, n), angles[1])],
            m > n ? [] : [
                for(i = m; i <= n; i = i + 1)
                    let(idx = (n + (m - i)))
                    __ra_to_xy(r_inner, a_step * idx)

            ],
            [__ra_to_xy(__edge_r_begin(r_inner, angles[0], a_step, m), angles[0])]        
        )
    ) points;

/**
* polyline2d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polyline2d.html
*
**/

module polyline2d(points, width, startingStyle = "CAP_SQUARE", endingStyle = "CAP_SQUARE") {
    leng_pts = len(points);

    s_styles = [startingStyle, "CAP_ROUND"];
    e_styles = ["CAP_BUTT", endingStyle];
    default_styles = ["CAP_BUTT", "CAP_ROUND"];

    module line_segment(index) {
        styles = index == 1 ? s_styles : 
                 index == leng_pts - 1 ? e_styles : 
                 default_styles;

        p1 = points[index - 1];
        p2 = points[index];
        p1Style = styles[0];
        p2Style = styles[1];
        
        line2d(points[index - 1], points[index], width, 
               p1Style = p1Style, p2Style = p2Style);

        // hook for testing
        test_line_segment(index, p1, p2, width, p1Style, p2Style);
    }

    module polyline2d_inner(index) {
        if(index < leng_pts) {
            line_segment(index);
            polyline2d_inner(index + 1);
        } 
    }

    polyline2d_inner(1);
}

// override it to test
module test_line_segment(index, point1, point2, width, p1Style, p2Style) {

}

/**
* stereographic_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-stereographic_extrude.html
*
**/

module stereographic_extrude(shadow_side_leng) {
    half_side_length = shadow_side_leng / 2;
    outer_sphere_r = half_side_length / 3;
    a = atan(sqrt(2) * half_side_length / (2 * outer_sphere_r));
    inner_sphere_r = outer_sphere_r * sin(a);
    
    intersection() { 
        translate([0, 0, outer_sphere_r]) 
        difference() {
            sphere(outer_sphere_r);
            sphere(outer_sphere_r / 2 + inner_sphere_r / 2);
            
            translate([0, 0, outer_sphere_r / 2]) 
            linear_extrude(outer_sphere_r) 
                circle(inner_sphere_r * cos(a));
        }
     
        linear_extrude(outer_sphere_r * 2, scale = 0.01) 
            children();
    }

    // hook for testing
    test_stereographic_extrude_rs(outer_sphere_r, inner_sphere_r);
}

// override for testing
module test_stereographic_extrude_rs(outer_sphere_r, inner_sphere_r) {

}

function __m_scaling_to_3_elems_scaling_vect(s) =
     let(leng = len(s))
     leng == 3 ? s : (
         leng == 2 ? [s[0], s[1], 1] : [s[0], 1, 1]
     );

function __m_scaling_to_scaling_vect(s) = is_num(s) ? [s, s, s] : __m_scaling_to_3_elems_scaling_vect(s);

function __m_scaling(s) = 
    let(v = __m_scaling_to_scaling_vect(s))
    [
        [v[0], 0, 0, 0],
        [0, v[1], 0, 0],
        [0, 0, v[2], 0],
        [0, 0, 0, 1]
    ];

function __to_3_elems_ang_vect(a) =
     let(leng = len(a))
     leng == 3 ? a : (
         leng == 2 ? [a[0], a[1], 0] :  [a[0], 0, 0]
     );

function __to_ang_vect(a) = is_num(a) ? [0, 0, a] : __to_3_elems_ang_vect(a);

/**
* shape_arc.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_arc.html
*
**/ 


function shape_arc(radius, angle, width, width_mode = "LINE_CROSS") =
    __shape_arc(radius, angle, width, width_mode);

function __ra_to_xy(r, a) = [r * cos(a), r * sin(a)];

/**
* px_polygon.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_polygon.html
*
**/ 

function px_polygon(points, filled = false) =
    filled ?
    let(
        xs = [for(pt = points) pt[0]],
        ys = [for(pt = points) pt[1]],
        max_x = max(xs),
        min_x = min(xs),
        max_y = max(ys),
        min_y = min(ys)
    )
    [
        for(y = min_y; y <= max_y; y = y + 1)
            for(x = min_x; x <= max_x; x = x + 1)
                let(pt = [x, y])
                if(in_shape(points, pt, true)) pt
    ]
    : 
    px_polyline(
        concat(points, [points[len(points) - 1], points[0]])
    );
    

/**
* line2d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-line2d.html
*
**/


module line2d(p1, p2, width, p1Style = "CAP_SQUARE", p2Style =  "CAP_SQUARE") {
    half_width = 0.5 * width;    

    atan_angle = atan2(p2[1] - p1[1], p2[0] - p1[0]);
    leng = sqrt(pow(p2[0] - p1[0], 2) + pow(p2[1] - p1[1], 2));

    frags = __nearest_multiple_of_4(__frags(half_width));
        
    module square_end(point) {
        translate(point) 
        rotate(atan_angle) 
            square(width, center = true);

        // hook for testing
        test_line2d_cap(point, "CAP_SQUARE");
    }

    module round_end(point) {
        translate(point) 
        rotate(atan_angle) 
            circle(half_width, $fn = frags);    

        // hook for testing
        test_line2d_cap(point, "CAP_ROUND");                
    }
    
    if(p1Style == "CAP_SQUARE") {
        square_end(p1);
    } else if(p1Style == "CAP_ROUND") {
        round_end(p1);
    }

    translate(p1) 
    rotate(atan_angle) 
    translate([0, -width / 2]) 
        square([leng, width]);
    
    if(p2Style == "CAP_SQUARE") {
        square_end(p2);
    } else if(p2Style == "CAP_ROUND") {
        round_end(p2);
    }

    // hook for testing
    test_line2d_line(atan_angle, leng, width, frags);
}

// override them to test
module test_line2d_cap(point, style) {
}

module test_line2d_line(angle, length, width, frags) {
}




/**
* shape_glued2circles.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_glued2circles.html
*
**/ 

function _glued2circles_pie_curve(radius, centre_dist, tangent_angle) =
    let(
        begin_ang = 90 + tangent_angle,
        shape_pts = shape_pie(radius, [-begin_ang, begin_ang]),
        leng = len(shape_pts)
    )
    [
        for(i = 1; i < leng; i = i + 1)
            shape_pts[i] + [centre_dist / 2, 0]
    ];
    
function _glued2circles_bezier(radius, centre_dist, tangent_angle, t_step, ctrl_p1) = 
    let(
        ctrl_p = rotate_p([radius * tan(tangent_angle), -radius], tangent_angle),
        ctrl_p2 = [-ctrl_p[0], ctrl_p[1]] + [centre_dist / 2, 0],
        ctrl_p3 = [-ctrl_p2[0], ctrl_p2[1]],
        ctrl_p4 = [-ctrl_p1[0], ctrl_p1[1]]            
    )
    bezier_curve(
        t_step,
        [
            ctrl_p1,
            ctrl_p2,
            ctrl_p3,
            ctrl_p4        
        ]
    );    

function _glued2circles_lower_half_curve(curve_pts, leng) =
    [
        for(i = 0; i < leng; i = i + 1)
        let(p = curve_pts[leng - 1 - i])
        if(p[0] >= 0) p
    ]; 
    
function _glued2circles_half_glued_circle(radius, centre_dist, tangent_angle, t_step) =
    let(
        pie_curve_pts = _glued2circles_pie_curve(radius, centre_dist, tangent_angle),
        curve_pts = _glued2circles_bezier(radius, centre_dist, tangent_angle, t_step, pie_curve_pts[0]),
        lower_curve_pts = _glued2circles_lower_half_curve(curve_pts, len(curve_pts)),
        leng_half_curve_pts = len(lower_curve_pts),
        upper_curve_pts = [
            for(i = 0; i < leng_half_curve_pts; i = i + 1)
                let(pt = lower_curve_pts[leng_half_curve_pts - 1 - i])
                [pt[0], -pt[1]]
        ]
    ) concat(
        lower_curve_pts,
        pie_curve_pts,        
        upper_curve_pts
    );
    
function shape_glued2circles(radius, centre_dist, tangent_angle = 30, t_step = 0.1) =
    let(
        half_glued_circles = _glued2circles_half_glued_circle(radius, centre_dist, tangent_angle, t_step),
        leng_half_glued_circles = len(half_glued_circles),
        left_half_glued_circles = [
            for(i = 0; i < leng_half_glued_circles; i = i + 1)
                let(pt = half_glued_circles[leng_half_glued_circles - 1 - i])
                [-pt[0], pt[1]]
        ]    
    ) concat(half_glued_circles, left_half_glued_circles);

/**
* m_rotation.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-m_rotation.html
*
**/


function m_rotation(a, v) = __m_rotation(a, v);

/**
* hull_polyline2d.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/hull_polyline2d.html
*
**/

module hull_polyline2d(points, width) {
    half_width = width / 2;
    leng = len(points);
    
    module hull_line2d(index) {
        point1 = points[index - 1];
        point2 = points[index];

        hull() {
            translate(point1) 
                circle(half_width);
            translate(point2) 
                circle(half_width);
        }

        // hook for testing
        test_line_segment(index, point1, point2, half_width);
    }

    module polyline2d_inner(index) {
        if(index < leng) {
            hull_line2d(index);
            polyline2d_inner(index + 1);
        }
    }

    polyline2d_inner(1);
}

// override it to test
module test_line_segment(index, point1, point2, radius) {

}

/**
* connector_peg.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-connector_peg.html
*
**/ 

module connector_peg(radius, height, spacing = 0.5, void = false, ends = false) {
    lip_r = radius * 1.2;
    r_diff = lip_r - radius;

    h = radius * 2.6; 
    h_unit = h / 7; 
    h_head = h_unit * 2;
    half_h_unit = h_unit / 2;

    total_height = is_undef(height) ? radius * 2.5 : height;
    
    module base(radius, lip_r) {   
        rotate_extrude() {
            translate([0, total_height - h_head]) 
            hull() {
                square([lip_r - r_diff, h_head]); 
                translate([0, half_h_unit]) square([lip_r, half_h_unit]);
            }
            square([radius, total_height - h_head]);                        
        }
    }

    module peg() {
        difference() {
            base(radius, lip_r);
            
            translate([0, 0, h_head])  
            linear_extrude(total_height) 
                square([r_diff * 2, lip_r * 2], center = true);
        }
    }

    module peg_void() {
        base(radius + spacing, lip_r + spacing);
        translate([0, 0, total_height]) 
        linear_extrude(spacing) 
            circle(lip_r);
    }
 
    module head() {
        if(void) {
            peg_void();
        }
        else {
            peg();
        }
    } 

    if(ends) {
        translate([0, 0, h]) {
            head();
            mirror([0, 0, 1]) head();
        }
    }
    else {
        head();
    }    
}    

/**
* rotate_p.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-rotate_p.html
*
**/ 


function _q_rotate_p_3d(p, a, v) = 
    let(
        half_a = a / 2,
        axis = v / norm(v),
        s = sin(half_a),
        x = s * axis[0],
        y = s * axis[1],
        z = s * axis[2],
        w = cos(half_a),
        
        x2 = x + x,
        y2 = y + y,
        z2 = z + z,

        xx = x * x2,
        yx = y * x2,
        yy = y * y2,
        zx = z * x2,
        zy = z * y2,
        zz = z * z2,
        wx = w * x2,
        wy = w * y2,
        wz = w * z2        
    )
    [
        [1 - yy - zz, yx - wz, zx + wy] * p,
        [yx + wz, 1 - xx - zz, zy - wx] * p,
        [zx - wy, zy + wx, 1 - xx - yy] * p
    ];

function _rotx(pt, a) = 
    a == 0 ? pt :
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0], 
        pt[1] * cosa - pt[2] * sina,
        pt[1] * sina + pt[2] * cosa
    ];

function _roty(pt, a) = 
    a == 0 ? pt :
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0] * cosa + pt[2] * sina, 
        pt[1],
        -pt[0] * sina + pt[2] * cosa, 
    ];

function _rotz(pt, a) = 
    a == 0 ? pt :
    let(cosa = cos(a), sina = sin(a))
    [
        pt[0] * cosa - pt[1] * sina,
        pt[0] * sina + pt[1] * cosa,
        pt[2]
    ];

function _rotate_p_3d(point, a) =
    _rotz(_roty(_rotx(point, a[0]), a[1]), a[2]);

function _rotate_p(p, a) =
    let(angle = __to_ang_vect(a))
    len(p) == 3 ? 
        _rotate_p_3d(p, angle) :
        __to2d(
            _rotate_p_3d(__to3d(p), angle)
        );


function _q_rotate_p(p, a, v) =
    len(p) == 3 ? 
        _q_rotate_p_3d(p, a, v) :
        __to2d(
            _q_rotate_p_3d(__to3d(p), a, v)
        );

function rotate_p(point, a, v) =
    is_undef(v) ? _rotate_p(point, a) : _q_rotate_p(point, a, v);


/**
* in_polyline.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-in_polyline.html
*
**/


function in_polyline(line_pts, pt, epsilon = 0.0001) = 
    let(
        leng = len(line_pts),
        iend = leng - 1,
        maybe_last = [for(i = 0; i < iend && !__in_line([line_pts[i], line_pts[i + 1]], pt, epsilon); i = i + 1) i][leng - 2]
    )
    is_undef(maybe_last);
    

function __edge_r_begin(orig_r, a, a_step, m) =
    let(leng = orig_r * cos(a_step / 2))
    leng / cos((m - 0.5) * a_step - a);

function __edge_r_end(orig_r, a, a_step, n) =      
    let(leng = orig_r * cos(a_step / 2))    
    leng / cos((n + 0.5) * a_step - a);

/**
* box_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-box_extrude.html
*
**/

module box_extrude(height, shell_thickness, 
                   offset_mode = "delta", chamfer = false, 
                   twist, slices, scale) {
                       
    linear_extrude(shell_thickness, scale = scale / height * shell_thickness)
    offset(delta = -shell_thickness * 0.99999, chamfer = chamfer) 
        children();
   

    linear_extrude(height, twist = twist, slices = slices, scale = scale) 
        difference() {
            children();
            if(offset_mode == "delta") {
                offset(delta = -shell_thickness, chamfer = chamfer) 
                    children(); 
            } else {
                offset(r = -shell_thickness) 
                    children(); 
            } 
        }    
}   

/**
* archimedean_spiral_extrude.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-archimedean_spiral_extrude.html
*
**/

module archimedean_spiral_extrude(shape_pts, arm_distance, init_angle, point_distance, num_of_points, 
                                  rt_dir = "CT_CLK", twist = 0, scale = 1.0, triangles = "SOLID") {
    points_angles = archimedean_spiral(
        arm_distance = arm_distance,  
        init_angle = init_angle, 
        point_distance = point_distance,
        num_of_points = num_of_points,
        rt_dir = rt_dir
    ); 

    clk_a = rt_dir == "CT_CLK" ? 0 : 180; 

    points = [for(pa = points_angles) pa[0]];
    angles = [
        for(pa = points_angles) 
             [90, 0, pa[1] + clk_a]
    ];

    sections = cross_sections(shape_pts, points, angles, twist, scale);

    polysections(
        sections,
        triangles = triangles
    );

    // testing hook
    test_archimedean_spiral_extrude(sections); 
}   

// override it to test
module test_archimedean_spiral_extrude(sections) {

}

/**
* m_translation.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-m_translation.html
*
**/

function _to_3_elems_translation_vect(v) =
     let(leng = len(v))
     leng == 3 ? v : (
         leng == 2 ? [v[0], v[1], 0] : [v[0], 0, 0]
     );

function _to_translation_vect(v) = is_num(v) ? [v, 0, 0] : _to_3_elems_translation_vect(v);

function m_translation(v) = 
    let(vt = _to_translation_vect(v))
    [
        [1, 0, 0, vt[0]],
        [0, 1, 0, vt[1]],
        [0, 0, 1, vt[2]],
        [0, 0, 0, 1]
    ];

/**
* m_scaling.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-m_scaling.html
*
**/


function m_scaling(s) = __m_scaling(s);

/**
* px_sphere.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_sphere.html
*
**/ 

function px_sphere(radius, filled = false, thickness = 1) = 
    let(range = [-radius: radius - 1])
    filled ? [
        for(z = range)
            for(y = range)        
               for(x = range)
                   let(v = [x, y, z])
                   if(norm(v) < radius) v
    ] :
    let(ishell = radius * radius - 2 * thickness * radius)
    [
        for(z = range)
            for(y = range)        
               for(x = range)
                   let(
                       v = [x, y, z],
                       leng = norm(v)
                   )
                   if(leng < radius && (leng * leng) > ishell) v    
    ];
    

/**
* joint_T.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-joint_T.html
*
**/ 

module joint_T(shaft_r, shaft_h, t_leng, thickness, spacing = 0.5, center = false) {
    ring_r = shaft_r + spacing + thickness;
    module joint_ring() {
        difference() {
            circle(ring_r);
            circle(ring_r - thickness);
        }
    }

    half_h = shaft_h / 2;
    one_third_h = shaft_h / 3;

    ring_height = one_third_h - spacing;

    translate(center ? [0, 0, -half_h] : [0, 0, 0]) {
        linear_extrude(ring_height) 
            joint_ring();

        translate([0, 0, shaft_h - ring_height]) 
        linear_extrude(ring_height) 
            joint_ring();
            
        translate([t_leng / 2, 0, half_h]) 
        linear_extrude(one_third_h, center = true)
            square([t_leng, shaft_r * 2], center = true);

        linear_extrude(shaft_h) 
            circle(shaft_r);        
    }
}

/**
* cone.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-cone.html
*
**/ 

module cone(radius, length = 0, spacing = 0.5, angle = 50, void = false, ends = false) {
    module base(r) {
        rotate_extrude() {
            if(length != 0) {
                square([r, length]);
            }
            polygon([
                [0, length], [r, length], [0, r * tan(angle) + length]
            ]);
        }

    }
    
    module head() {        
        if(void) {
            base(radius + spacing);
        }
        else {
            base(radius);
        }
    }
    
    if(ends) {
        head();
        mirror([0, 0, 1]) head();
    }
    else {
        head();
    }        
}

/**
* hexagons.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-hexagons.html
*
**/ 

module hexagons(radius, spacing, levels) {
    beginning_n = 2 * levels - 1; 
    offset_x = radius * cos(30);
    offset_y = radius + radius * sin(30);
    r_hexagon = radius - spacing / 2;
    offset_step = 2 * offset_x;
    center_offset = 2 * (offset_x - offset_x * levels);

    module hexagon() {
        rotate(30) 
            circle(r_hexagon, $fn = 6);     
    }

    function hexagons_pts(hex_datum) =
        let(
            tx = hex_datum[0][0],
            ty = hex_datum[0][1],
            n = hex_datum[1],
            offset_xs = [for(i = 0; i < n; i = i + 1) i * offset_step + center_offset] 
        )
        [
            for(x = offset_xs) [x + tx, ty]
        ];

    module line_hexagons(hex_datum) {
        tx = hex_datum[0][0];
        ty = hex_datum[0][1];
        n = hex_datum[1]; 

        offset_xs = [for(i = 0; i < n; i = i + 1) i * offset_step + center_offset];
        for(x = offset_xs) {
            p = [x + tx, ty, 0];
            translate(p) 
                hexagon();
        }
    }
    
    upper_hex_data = levels > 1 ? [
        for(i = [1:beginning_n - levels])
            let(
                x = offset_x * i,
                y = offset_y * i,
                n = beginning_n - i
            ) [[x, y], n]
    ] : [];

    lower_hex_data = levels > 1 ? [
        for(hex_datum = upper_hex_data)
        [[hex_datum[0][0], -hex_datum[0][1]], hex_datum[1]]
    ] : [];

    total_hex_data = concat(
        [
            [[0, 0], beginning_n] // first line
        ], 
        upper_hex_data, 
        lower_hex_data
    );

    pts_all_lines = [
        for(hex_datum = total_hex_data)
            hexagons_pts(hex_datum)
    ];

    for(pts_one_line = pts_all_lines) {
        for(pt = pts_one_line) {
            translate(pt) 
                hexagon();
        }
    }

    test_each_hexagon(r_hexagon, pts_all_lines);
}
 
// override it to test
module test_each_hexagon(hex_r, pts_all_lines) {

}

/**
* shape_pentagram.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-shape_ellipse.html
*
**/

function shape_pentagram(r) =
    [
        [0, 1], [-0.224514, 0.309017], 
        [-0.951057, 0.309017], [-0.363271, -0.118034], 
        [-0.587785, -0.809017], [0, -0.381966], 
        [0.587785, -0.809017], [0.363271, -0.118034], 
        [0.951057, 0.309017], [0.224514, 0.309017]
    ] * r;

/**
* split_str.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-split_str.html
*
**/ 
   
function _split_t_by(idxs, t) =
    let(leng = len(idxs))
    concat(
        [sub_str(t, 0, idxs[0])],
        [
            for(i = 0; i < leng; i = i + 1)
                sub_str(t, idxs[i] + 1, idxs[i + 1])
        ]
    );
             
function split_str(t, delimiter) = 
    len(search(delimiter, t)) == 0 ? 
        [t] : _split_t_by(search(delimiter, t, 0)[0], t);  

/**
* px_gray.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib2-px_gray.html
*
**/ 

function _px_gray_row(r_count, row_bits, width, height, center, invert, normalize) =
    let(
        half_w = width / 2,
        half_h = height / 2,
        offset_x = center ? 0 : half_w,
        offset_y = center ? -half_h : 0,
        level = invert ? 0 : 255,
        nmal = normalize ? 255 : 1
    ) 
    [
        for(i = 0; i < width; i = i + 1) 
            if(row_bits[i] != level) 
                [
                    [i - half_w + offset_x, r_count + offset_y], 
                    invert ? row_bits[i] / nmal : (255 - row_bits[i]) / nmal
                ]
    ];

function px_gray(levels, center = false, invert = false, normalize = false) = 
    let(
        width = len(levels[0]),
        height = len(levels),
        offset_i = height / 2
    )
    [
        for(i = height - 1; i > -1; i = i - 1) 
        let(row = _px_gray_row(height - i - 1, levels[i], width, height, center, invert, normalize))
        if(row != []) each row
    ];

/**
* torus_knot.scad
*
* @copyright Justin Lin, 2019
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-torus_knot.html
*
**/

function torus_knot(p, q, phi_step) = 
    let(tau = PI * 2)
    [
        for(phi = 0; phi < tau; phi = phi + phi_step)
        let(
            degree = phi * 180 / PI,
            r = cos(q * degree) + 2,
            x = r * cos(p * degree),
            y = r * sin(p * degree),
            z = -sin(q * degree)
        )
        [x, y, z]
    ];

