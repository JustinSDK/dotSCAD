module cone(radius, length = 0, spacing = 0.5, angle = 50, void = false, ends = false) {
    module base(r) {
        rotate_extrude() {
            if(length != 0) {
                square([r, length]);
            }
            polygon([
                [0, length], [r, length], [0, r * tan(angle) + length]
            ]);
        }

    }
    
    module head() {        
        if(void) {
            base(radius + spacing);
        }
        else {
            base(radius);
        }
    }
    
    if(ends) {
        head();
        mirror([0, 0, 1]) head();
    }
    else {
        head();
    }        
}