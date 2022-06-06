use <surface/sf_solidify.scad>
use <util/sum.scad>

Z0 = [0, 0];
NL = 50;
DIV = 4.0;
PW = 100;
step = .5;
cw = 1.5;
cc = [-0.75, 0];

thickness = 4;

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
    leng == NL ? sum(slt) / (thickness * 2) : 
    leng == 0 ? c * c : sum(slt) / leng * thickness;

left = -PW * 0.84;
right = PW * 1.18;
top = PW * 0.9;
pts = [
    for(py = -top; py <= top; py = py + step) 
    let(y = cw / PW * py + cc.y)
    [
        for(px = left; px <= right; px = px + step) 
        let(x = cw / PW * px + cc.x)
        [px, py, znxt([x, y])]
    ]
];

b_pts = [
    for(py = -top; py <= top; py = py + step) 
    [
        for(px = left; px <= right; px = px + step) 
        [px, py, -thickness]
    ]
];

sf_solidify(pts, b_pts);