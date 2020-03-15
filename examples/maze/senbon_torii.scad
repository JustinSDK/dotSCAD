use <experimental/mz_hamiltonian.scad>;

module senbon_torii(rows, columns, start, width, height) {
    line = mz_hamiltonian(rows, columns, start);
    leng = len(line);

    // first torii
    fst = line[0];
    snd = line[1];
    
    translate(fst)
    rotate([90, 0, atan2(snd[0] - fst[0], snd[1] - fst[1])]) 
    translate([0, .175])
        children(0);     
               
    module middle_torii(i) {
        p1 = line[i];
        p2 = line[i + 1];
        md = (p1 + p2) / 2;
        h = i * height + 0.1; 

        a1 = atan2(p2[0] - p1[0], p2[1] - p1[1]);
        
        translate([md[0], md[1], h]) 
        rotate([90, 0, a1]) 
        translate([0, .1])       
            children(0);       
 
        // road
        hull() {
            translate(p1) 
            linear_extrude(h)
                square(width, center = true);      

            translate(p2) 
            linear_extrude((i + 1) * height + 0.1)
                square(width, center = true);     
        }      
    }    
    
    // second torii
    middle_torii(0) 
        children(0);

    // middle torris               
    for(i = [1:leng - 2]) {
        middle_torii(i) 
            children(0);
            
        p0 = line[i - 1];
        p1 = line[i];
        p2 = line[i + 1];
        h = i * height + 0.1; 
        
        a1 = atan2(p2[0] - p1[0], p2[1] - p1[1]);
        a2 = atan2(p1[0] - p0[0], p1[1] - p0[1]);
        translate([p1[0], p1[1], h - width * 0.233333])
        rotate([90, 0, a1 + (a1 - a2) / 2]) 
        translate([0, .2])        
            children(0); 
    }
    
    // top
    lst = line[leng - 1];
    pre_lst = line[leng - 2];
    la = atan2(lst[0] - pre_lst[0], lst[1] - pre_lst[1]);
    
    translate([lst[0], lst[1], (leng - 1) * height])
    rotate([90, 0, la]) 
    translate([0, .175])
        children(1);     
}

module torii_symbol() {
    linear_extrude(.1, center = true)         
    translate([-0.025, 0.025])
        text("⛩", font = "Segoe UI Emoji", size = 0.5 * 0.7, halign = "center");
}

module top_symbol() {
    translate([-0.005, .05])
    linear_extrude(.3, center = true)     
    scale([0.9, 1.5])
        text("🏔", font = "Segoe UI Emoji", size = 0.45 * 0.7, halign = "center");  
}

senbon_torii(
    rows = 2, 
    columns = 3,
    start = [0, 0],
    width = .5,
    height = .05
) {
    torii_symbol();
    top_symbol();
};