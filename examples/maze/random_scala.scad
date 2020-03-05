use <experimental/mz_hamiltonian.scad>;

module random_scala(rows, columns, start, width, height) {
    line = mz_hamiltonian(rows, columns, start);
    leng = len(line);
    
    for(i = [0:leng - 1]) {
        p1 = line[i];
        translate(p1)
        linear_extrude(height * i * 2 + height)
            square(width + 0.01, center = true);
            
        p2 = line[(i + 1) % leng];
        
        translate(p1 + (p2 - p1) / 2)        
        linear_extrude(height * (2 * i + 1) + height)
            square(width + 0.01, center = true);
    }
}

random_scala(
    rows = 2, 
    columns = 3,
    start = [0, 0],
    width = .5,
    height = .25
);