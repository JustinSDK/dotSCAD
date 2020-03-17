use <experimental/lcm.scad>;
use <sweep.scad>;
   
module loft(sections, slices = 1) {
    function inter_pts(p1, p2, n) =
        let(
            v = p2 - p1,
            dx = v[0] / n,
            dy = v[1] / n,
            dz = v[2] / n
        )
        [for(i = [1:n - 1]) p1 + [dx, dy, dz] * i];

    function _interpolate(sect, leng, n, i = 0) = 
        i == leng ? [] :
        let(
            p1 = sect[i],
            p2 = sect[(i + 1) % leng]
        )
        concat(
            [p1], 
            inter_pts(p1, p2, n),
            _interpolate(sect, leng, n, i + 1)
        );

    function interpolate(sect, n) = 
        n <= 1 ? sect : _interpolate(sect, len(sect), n);
        
    module _loft(sect1, sect2, slices) {
        function inter_sects(s1, s2, s_leng, slices) = 
            slices == 1 ? [] : 
                let(
                    dps = [
                        for(i = [0:lcm_n - 1])
                        (s2[i] - s1[i]) / slices
                    ]
                )
                [for(i = [1:slices - 1]) s1 + dps * i];

        lcm_n = lcm(len(sect1), len(sect2));
        new_sect1 = interpolate(sect1, lcm_n / len(sect1));
        new_sect2 = interpolate(sect2, lcm_n / len(sect2));
        
        sweep(
            concat(
                [new_sect1],
                inter_sects(new_sect1, new_sect2, lcm_n, slices),
                [new_sect2]
            )
        );
    }
        
    for(i = [0:len(sections) - 2]) {
        _loft(sections[i], sections[i + 1], slices);
    }
}