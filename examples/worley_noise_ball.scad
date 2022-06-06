use <noise/nz_worley3s.scad>
use <sweep.scad>

radius = 25;
a_step = 5;
tile_w = 10;
dist = "euclidean"; // [euclidean, manhattan, chebyshev, "border"] 
noise_style = "CELL_R";    // [CELL_R, NOISE]
noise_factor = 1;
seed = rands(0, 255, 1)[0];

module worley_noise_ball() {
    theta_tau_lt = [ 
        for(tau = [-90:a_step:90])
            [for(theta = 360; theta >= 0; theta = theta - a_step)
                [theta, tau]]
    ];

    function to_xyz(polar) = 
        let(
            r = polar[0],
            theta = polar[1],
            tau = polar[2],
            z = r * sin(tau),
            r2 = r * cos(tau),
            x = r2 * cos(theta),
            y = r2 * sin(theta)
        )
        [x, y, z];
        

    cells = [
        for(row = theta_tau_lt)
            nz_worley3s(
                [for(theta_tau = row) to_xyz([radius, theta_tau[0], theta_tau[1]])], 
                seed, 
                tile_w, 
                dist
            )
    ];

    sections = [
        for(ri = [0:len(theta_tau_lt) - 1])
        [
            for(ci = [0:len(theta_tau_lt[0]) - 1])
            let(
                theta_tau = theta_tau_lt[ri][ci],
                off_r = noise_style == "CELL_R" ? norm([cells[ri][ci][0], cells[ri][ci][1], cells[ri][ci][2]]) : cells[ri][ci][3],
                nr = radius + off_r * noise_factor
            )
            to_xyz([nr, theta_tau[0], theta_tau[1]])
        ]
    ];

    sweep(sections);
}

worley_noise_ball();