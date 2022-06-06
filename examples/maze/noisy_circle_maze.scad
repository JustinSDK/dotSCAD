use <polyline_join.scad>
use <util/rand.scad>
use <maze/mz_square.scad>
use <maze/mz_squarewalls.scad>
use <ptf/ptf_circle.scad>
use <noise/nz_perlin2.scad>

module noisy_circle_maze(r_cells, cell_width, wall_thickness, origin_offset, noisy_factor) {
    double_r_cells = r_cells * 2;
    cells = mz_square(double_r_cells, double_r_cells);

    width = double_r_cells * cell_width;
    walls = mz_squarewalls(cells, cell_width);
    
    half_width =  width / 2;
    rect_size = is_undef(origin_offset) ? [width, width] : [width, width] - origin_offset * 2;

    noisy_f = is_undef(noisy_factor) ? 1 : noisy_factor;
    half_wall_thickness = wall_thickness / 2;
    seed = rand(0, 256);
    for(wall = walls, i = [0:len(wall) - 2]) {
        p0 = ptf_circle(rect_size, wall[i]);
        p1 = ptf_circle(rect_size, wall[i + 1]);
        pn00 = nz_perlin2(p0[0], p0[1], seed) * noisy_f;
        pn01 = nz_perlin2(p0[0] + seed, p0[1] + seed, seed) * noisy_f;
        pn10 = nz_perlin2(p1[0], p1[1], seed) * noisy_f;
        pn11 = nz_perlin2(p1[0] + seed, p1[1] + seed, seed) * noisy_f;
        polyline_join([p0 + [pn00, pn01], p1 + [pn10, pn11]])
            circle(half_wall_thickness);
    } 
}

noisy_circle_maze(
    r_cells = 8, 
    cell_width = 5, 
    wall_thickness = 2,
    noisy_factor = 2
);