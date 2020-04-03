use <util/rand.scad>;
use <noise/_impl/_pnoise1_impl.scad>;

function nz_perlin1(x, seed) = _pnoise1_impl(x, seed % 256);