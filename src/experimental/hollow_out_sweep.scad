use <util/rand.scad>;
use <line3d.scad>;
use <hull_polyline3d.scad>;
use <experimental/tri_bisectors.scad>;

// style: LINES or HULL_LINES
module hollow_out_sweep(sections, thickness, closed = false, style = "LINES") {
    function rects(sects) = 
        let(
            sects_leng = len(sects),
            shape_pt_leng = len(sects[0])
        )
        [
            for(i = [0:sects_leng - 2])
                let(
                    sect1 = sects[i],
                    sect2 = sects[i + 1]
                )
                for(j = [0:shape_pt_leng - 1])
                    let(k = (j + 1) % shape_pt_leng)
                    [sect1[j], sect1[k], sect2[k], sect2[j]]
        ];
        
    function rand_tris(rect) =
        let(
            i = ceil(rand() * 10) % 2
        )
        i == 0 ?
            [[rect[0], rect[1], rect[2]], [rect[0], rect[2], rect[3]]] :
            [[rect[1], rect[2], rect[3]], [rect[1], rect[3], rect[0]]];        
    
    sects = closed ? concat(sections, [sections[0]]) : sections;
    lines = [
        for(rect = rects(sects)) 
            for(tri = rand_tris(rect)) 
                each tri_bisectors(tri) 
    ];

    if(style == "LINES") {
        for(line = lines) {
            line3d(
                p1 = line[0], 
                p2 = line[1],
                thickness = thickness, 
                p1Style = "CAP_SPHERE", 
                p2Style = "CAP_SPHERE"
            );
        }
    }   
    else if(style == "HULL_LINES") { 
        for(line = lines) {
            hull_polyline3d(line, thickness = thickness);
        }
    }
}