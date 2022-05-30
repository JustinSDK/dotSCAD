use <surface/sf_thicken.scad>;

Z0 = [0, 0];
NL = 50;
DIV = 4.0;
PW = 100;
step = .5;
cw = 1.5;
cc = [-0.75, 0];

thickness = 2;

function pow2(z) = [z.x ^ 2 - z.y ^ 2, 2 * z.x * z.y];

function znxt(c) =  
    let(
        slt = [
            for(n = 0, z = pow2(Z0) + c, s = z * z; 
            n < NL && s <= DIV; n = n + 1, z = pow2(z) + c, s = z * z)
            s
        ],
        leng = len(slt)
    )
    //leng == NL ? 0 : 
    leng == 0 ? c * c : slt[leng - 1];

left = -PW * 0.9;
right = PW * 1.25;
pts = [
    for(py = 0; py <= PW; py = py + step) 
    let(y = cw / PW * py + cc.y)
    [
        for(px = left; px <= right; px = px + step) 
        let(x = cw / PW * px + cc.x, v = znxt([x, y]))
        [px, py, v]
    ]
];

intersection() {
    union() {
    sf_thicken(pts, thickness);
    mirror([0, 1, 0])
        sf_thicken(pts, thickness);
    }

linear_extrude(thickness * 10, center = true)
translate([(left + right) / 2, 0] + cc)
scale([1, 0.95 * 2 * PW / (right - left)])
    circle((right - left) / 2, $fn = 48);
}