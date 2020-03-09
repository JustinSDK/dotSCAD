use <util/rand.scad>;
use <experimental/_impl/_pnoise3_impl.scad>;

function pnoise3(x, y, z, seed) = _pnoise3(x, y, z, seed % 256);