module polyline2d(points, width, startingStyle = CAP_SQUARE, endingStyle = CAP_SQUARE, round_fn = 24) {
    module line_segment(index) {
	    styles = index == 1 ? [startingStyle, CAP_ROUND] : (
		    index == len(points) - 1 ? [CAP_ROUND, endingStyle] : [
			    CAP_ROUND, CAP_ROUND
			]
		);
		
		line2d(points[index - 1], points[index], width, 
			   p1Style = styles[0], p2Style = styles[1], 
			   round_fn = round_fn);
	}

    module polyline2d_inner(points, index) {
        if(index < len(points)) {
		    line_segment(index);
			polyline2d_inner(points, index + 1);
        } 
    }

    polyline2d_inner(points, 1);
}