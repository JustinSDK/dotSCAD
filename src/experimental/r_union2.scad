use <__comm__/__frags.scad>

module r_union2(radius = 1) {
	module _r_union2(r = 1) {
	    frags = __frags(r);
		a_step = 90 / frags;
		rx = is_list(r) ? r[1] : r;
		ry = is_list(r) ? r[0] : r;
		
		for(a = [0:a_step:a_step * (frags - 1)]) {
			hull() {
				intersection() {
					offset(rx - sin(a) * rx) 
					    children(0);
					offset(ry - cos(a) * ry) 
					    children(1);
				}
				intersection() {
					offset(rx - sin(a + a_step) * rx) 
					    children(0);
					offset(ry - cos(a + a_step) * ry) 
					    children(1);
				}
			}
		}
		
		children(0);
		children(1);
	}
	
    if($children == 0) {
	    // nope
	}
	else if($children == 1) {
	    children(0);
	}
	else if($children == 2) {
	    _r_union2(radius) {
			children(0);
			children(1);
		};
	}
	// OpenSCAD have to enumerate children explicitly.
    // Currently, this module allow 10 children.
	else if($children == 3) {
	    r_union2(radius) {
			_r_union2(radius) {
				children(0);
				children(1);
			};
			children(2);
		}
	}
	else if($children == 4) {
	    r_union2(radius) {
			_r_union2(radius) {
				children(0);
				children(1);
			};
			children(2);
			children(3);
		}
	}
	else if($children == 5) {
	    r_union2(radius) {
			_r_union2(radius) {
				children(0);
				children(1);
			};
			children(2);
			children(3);
			children(4);
		}
	}
	else if($children == 6) {
	    r_union2(radius) {
			_r_union2(radius) {
				children(0);
				children(1);
			};
			children(2);
			children(3);
			children(4);
			children(5);
		}
	}
	else if($children == 7) {
	    r_union2(radius) {
			_r_union2(radius) {
				children(0);
				children(1);
			};
			children(2);
			children(3);
			children(4);
			children(5);
			children(6);
		}
	}
	else if($children == 8) {
	    r_union2(radius) {
			_r_union2(radius) {
				children(0);
				children(1);
			};
			children(2);
			children(3);
			children(4);
			children(5);
			children(6);
			children(7);
		}
	}
	else if($children == 9) {
	    r_union2(radius) {
			_r_union2(radius) {
				children(0);
				children(1);
			};
			children(2);
			children(3);
			children(4);
			children(5);
			children(6);
			children(7);
			children(8);
		}
	}
	else if($children == 10) {
	    r_union2(radius) {
			_r_union2(radius) {
				children(0);
				children(1);
			};
			children(2);
			children(3);
			children(4);
			children(5);
			children(6);
			children(7);
			children(8);
			children(9);
		}
	}
}