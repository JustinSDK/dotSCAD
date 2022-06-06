// The math of the shells: https://www.youtube.com/watch?v=pKHWzmxw_NI

use <surface/sf_thickenT.scad>

alpha = 85; 
beta = 5;
phi = 0;
omega = 0;
mu = 1;
a = 2;
b = 3;

theta_s = -2400;
theta_step = 20;
theta_e = 720;

s_s = -150;
s_step = 20;
s_e = 90;

thickness = 1.5;

seashell();

module seashell() {
    e = 2.7182818284590452;
    real_e = e * 0.3615;     // avoid inf
	pow_a = a ^ 2 / 100;
	pow_b = b ^ 2 / 100;

	function cot(degree) = 1 / tan(degree);

	function radius(theta) = 
		real_e ^ (theta * cot(alpha));

	function x(theta, s) = 
		let(r = radius(theta))
		r * (    
			(cos(theta + omega) * cos(s + phi) - sin(mu) * sin(theta + omega) * sin(s + phi)) / 
			sqrt((cos(s) ^ 2) / pow_a + (sin(s) ^ 2) / pow_b)
			 + sin(beta) * cos(theta)
		);

	function y(theta, s) = 
		let(r = radius(theta))
		r * (    
			(sin(mu) * cos(theta + omega) * sin(s + phi) + sin(theta + omega) * cos(s + phi)) / 
			sqrt((cos(s) ^ 2) / pow_a + (sin(s) ^ 2) / pow_b)
			+ sin(beta) * sin(theta)
		);

	function z(theta, s) = 
		let(r = radius(theta))
		r * (    
			(cos(mu) * sin(s + phi)) / 
			sqrt((cos(s) ^ 2) / pow_a + (sin(s) ^ 2) / pow_b)
			- cos(beta)
		);

	points = [
		for(s = [s_s:s_step:s_e], theta = [theta_s:theta_step:theta_e])
		[x(theta, s), y(theta, s), z(theta, s)]
	];

	slen = floor((s_e - s_s) / s_step);
	thetalen = floor((theta_e - theta_s) / theta_step);

	c = thetalen + 1;
	triangles = [
		for(s = [0:slen - 1], theta = [0:thetalen - 1])
		each [
			[theta + s * c, theta + 1 + s * c, theta + (s + 1) * c], 
			[theta + 1 + s * c, theta + 1 + (s + 1) * c, theta + (s + 1) * c]
		]
	];

	sf_thickenT(points, thickness, triangles);
}
