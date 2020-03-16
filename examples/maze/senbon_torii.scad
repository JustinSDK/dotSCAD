use <experimental/mz_hamiltonian.scad>;

rows = 2;
columns = 2;
start = [0, 0];
width = .5;
height = .05;
test_torii = "FALSE"; // [TRUE, FALSE]

if(test_torii == "TRUE") {
    rotate([90, 0, 0])
        torii_symbol();
}
else {
    senbon_torii(
        rows = rows, 
        columns = columns,
        start = start,
        width = width,
        height = height
    ) {
        torii_symbol();
        top_symbol();
    };
}

module senbon_torii(rows, columns, start, width, height) {
    line = mz_hamiltonian(rows, columns, start);
    leng = len(line);
    min_h = 0.1;

    // first torii
    fst = line[0];
    snd = line[1];
    
    translate([fst[0], fst[1], min_h])
    rotate([90, 0, atan2(snd[0] - fst[0], snd[1] - fst[1])]) 
        children(0);     
               
    module middle_torii(i) {
        p1 = line[i];
        p2 = line[i + 1];
        md = (p1 + p2) / 2;
        h = i * height + min_h; 

        a1 = atan2(p2[0] - p1[0], p2[1] - p1[1]);
        
        translate([md[0], md[1], h + height / 2]) 
        rotate([90, 0, a1]) 
            children(0);       
 
        // road
        hull() {
            translate(p1) 
            linear_extrude(h)
                square(width, center = true);      

            translate(p2) 
            linear_extrude((i + 1) * height + min_h)
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
        h = i * height + min_h; 
        
        a1 = atan2(p2[0] - p1[0], p2[1] - p1[1]);
        a2 = atan2(p1[0] - p0[0], p1[1] - p0[1]);
        translate([p1[0], p1[1], h])
        rotate([90, 0, a1 + (a1 - a2) / 2])     
            children(0); 
    }
    
    // top
    lst = line[leng - 1];
    pre_lst = line[leng - 2];
    la = atan2(lst[0] - pre_lst[0], lst[1] - pre_lst[1]);
    
    translate([lst[0], lst[1], (leng - 1) * height + min_h])
    rotate([90, 0, la]) 
        children(1);     
}

module torii_symbol() {
    // design your own symbol
    linear_extrude(.1, center = true) 
    scale(1.25) {
        difference() {
            union() {
                translate([-0.025, 0.10])
                    text("⛩", font = "Segoe UI Emoji", size = 0.5 * 0.7, halign = "center");
                
                translate([0, 0.455])   
                    square([.46, 0.05], center = true);
                
                translate([0, 0.3])   
                    square([.15, 0.07], center = true);     
                    
                translate([0, 0.3715]) 
                    square([0.35, 0.075], center = true);
            }

        translate([0, 0.34])   
            square([0.35 / 5.5, 0.07], center = true);
        }
        
        
        translate([.201, 0.262])
        scale([1, 0.75])
            circle(.05, $fn = 3);

        mirror([1, 0, 0])
        translate([.201, 0.262])
        scale([1, 0.75])
            circle(.05, $fn = 3);        
    }      
}

module top_symbol() {
    // design your own symbol
    translate([-0.01295, .13]) {
        linear_extrude(.2, center = true)     
        scale([0.975, 1.5])
        hull()
            text("🏔", font = "Segoe UI Emoji", size = 0.45 * 0.7, halign = "center"); 
            
        scale([0.975, 1.75])
        linear_extrude(.25, center = true)           
            text("🏔", font = "Segoe UI Emoji", size = 0.45 * 0.7, halign = "center");  
    }
}