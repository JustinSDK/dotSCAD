use <util/rand.scad>;
use <experimental/_impl/_pnoise2_impl.scad>;

function pnoise2(x, y, seed) = _pnoise2(x, y, seed % 256);