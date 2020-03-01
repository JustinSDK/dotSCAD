use <experimental/gcd.scad>;

function lcm(m, n) = m * n / gcd(m, n);