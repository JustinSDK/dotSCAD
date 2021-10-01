module polyline_hull(points) {
    leng = len(points);
    
    module hull_line(index) {
        hull() {
            translate(points[index - 1]) 
                children();
            translate(points[index]) 
                children();
        }
    }

    if($children == 1) {
        for(i = [1:leng - 1]) {
            hull_line(i)
                children();
        }
    }
    else {
        for(i = [1:leng - 1]) {
            hull_line(i)
                children(i);
        }
    }
}