/**
* loft.scad
*
* @copyright Justin Lin, 2020
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-loft.html
*
**/

use <sweep.scad>
use <util/lerp.scad>
   
module loft(sections, slices = 1) {
    function gcd(m, n) = n == 0 ? m : gcd(n, m % n);
    function lcm(m, n) = m * n / gcd(m, n);

    function interpolate(sect, leng, n) = 
        n <= 1 ? sect :
        let(amts = [each [1:n-1]] / n)
        [
            for(i = 0; i < leng; i = i + 1)
            let(
                p1 = sect[i],
                p2 = sect[(i + 1) % leng]
            )
            each [p1, each [for(amt = amts) lerp(p1, p2, amt)]]
        ];
        
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

        leng_sect1 = len(sect1);
        leng_sect2 = len(sect2);
        lcm_n = lcm(leng_sect1, leng_sect2);
        new_sect1 = interpolate(sect1, leng_sect1, lcm_n / leng_sect1);
        new_sect2 = interpolate(sect2, leng_sect2, lcm_n / leng_sect2);
        
        sweep([new_sect1, each inter_sects(new_sect1, new_sect2, lcm_n, slices), new_sect2]);
    }
        
    for(i = [0:len(sections) - 2]) {
        _loft(sections[i], sections[i + 1], slices);
    }
}