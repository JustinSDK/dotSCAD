module polyline_hull(points) {
    leng = len(points);
    
    module hull_line(index) {
        hull() {
            translate(points[index]) 
                children();
            translate(points[index + 1]) 
                children();
        }
    }

    if($children == 1) {
        for(i = [0:leng - 2]) {
            hull_line(i)
                children();
        }
    }
    else {
        for(i = [0:min(leng, $children) - 2]) {
            hull_line(i)
                children(i);
        }
    }
}