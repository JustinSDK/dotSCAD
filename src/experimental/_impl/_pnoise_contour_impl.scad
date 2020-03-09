use <experimental/pnoise2.scad>;

INFINITY = 1e200 * 1e200;

function _pnoise_contour_step_sub(x, y, current_noise, seed, step_leng, step_angle, heading, min_delta, maybe_heading, close_noise, maybe_x, maybe_y, theta) =
    theta >= heading + 90 ? [maybe_x, maybe_y, maybe_heading] :
    let(
        nx = x + step_leng * cos(theta),
        ny = y + step_leng * sin(theta),
        new_noise = pnoise2(nx, ny, seed),
        delta = abs(new_noise - current_noise)        
    )
    delta < min_delta ? 
        _pnoise_contour_step_sub(x, y, current_noise, seed, step_leng, step_angle, heading, delta, theta, new_noise, nx, ny, theta + step_angle) :
        _pnoise_contour_step_sub(x, y, current_noise, seed, step_leng, step_angle, heading, min_delta, maybe_heading, close_noise, maybe_x, maybe_y, theta + step_angle);

function _pnoise_contour_step(x, y, heading, noise, seed, step_leng, step_angle) = 
    _pnoise_contour_step_sub(
        x, y, 
        is_undef(noise) ? pnoise2(x, y, seed) : noise,
        seed, step_leng, step_angle, heading, INFINITY, heading, -1, -1, -1, heading - 90
    );

function _pnoise_contour(x, y, heading, noise, seed, steps, step_leng, step_angle, i = 0) =
    i == steps ? [[x, y]] :
    let(
        xyh = _pnoise_contour_step(x, y, heading, noise, seed, step_leng, step_angle)
    )
    concat([[x, y]], _pnoise_contour(xyh[0], xyh[1], xyh[2], noise, seed, steps, step_leng, step_angle, i + 1));
