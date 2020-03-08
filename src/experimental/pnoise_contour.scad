use <experimental/_impl/_pnoise_contour_impl.scad>;
use <experimental/pnoise2.scad>;

function pnoise_contour(x, y, noise, seed = 1, steps = 50, step_leng = 0.2, step_angle = 12) = 
    _pnoise_contour(
        x, 
        y, 
        seed % 360,
        noise, 
        seed, 
        steps, 
        step_leng, 
        step_angle
    );