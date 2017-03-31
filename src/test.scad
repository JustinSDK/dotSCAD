	include <line2d.scad>;
    include <turtle2d.scad>;

	module turtle_spiral(t_before, side_leng, d_step, min_leng, angle, width) {
	    $fn = 24;
	    if(side_leng > min_leng) {
	        t_after = turtle2d("forward", turtle2d("turn", t_before, angle), side_leng);
	
	        line2d(
	            turtle2d("pt", t_before),
	            turtle2d("pt", t_after),
	            width,
	            p1Style = "CAP_ROUND", 
	            p2Style =  "CAP_ROUND"
	        );
	        
	        
	        turtle_spiral(t_after, side_leng - d_step, d_step, min_leng, angle, width);
	    }
	
	}
	
	side_leng = 50;
	d_step = 1;
	min_leng = 1;
	angle = 90;
	width = 1;
	
	turtle_spiral(
	    turtle2d("create", 0, 0, 0), 
	    side_leng, 
	    d_step, 
	    min_leng, 
	    angle, 
	    width
	);