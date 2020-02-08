use <line2d.scad>;
use <arc.scad>;
use <util/rand.scad>;

number_of_circles = 15;
minimum_radius = 3;
gap_distance = 3;
line_width = 1.5;

module euler_maze(n, r, d, width = 1) {
    function angle(r, d) = acos(
        (2 * pow(r, 2) - pow(d, 2)) / (2 * pow(r, 2))
    );


    module oneGapCircle(r, d, gap_angle1, gap_angle2, width = 1) {
        arc(radius = r, angle = [gap_angle2, gap_angle1 + 360], width = width);
    }

    module twoGapsCircle(r, d, gap_angle, gap_angle1_begin, gap_angle2_begin, width = 1) {
        arc(radius = r, angle = [gap_angle1_begin + gap_angle, gap_angle2_begin], width = width);
        arc(radius = r, angle = [gap_angle2_begin + gap_angle, gap_angle1_begin + 360], width = width);  
    }

    module euler_circles(n, inner_r, pre_gap_angle, pre_gap_angle_offset) {
        outer_r = inner_r + r;
        gap_angle = angle(outer_r, d);
        gap_angle_offset = pre_gap_angle_offset + pre_gap_angle / 2 - gap_angle / 2;  
            
        p1 = [inner_r * cos(pre_gap_angle_offset), inner_r * sin(pre_gap_angle_offset)];
        p2 = [outer_r * cos(gap_angle_offset), outer_r * sin(gap_angle_offset)];
        
        p3 = [inner_r * cos(pre_gap_angle + pre_gap_angle_offset), inner_r * sin(pre_gap_angle + pre_gap_angle_offset)];
        p4 = [outer_r * cos(gap_angle_offset + gap_angle), outer_r * sin(gap_angle_offset + gap_angle)]; 

        line2d(p1, p2, width = width, p1Style = "CAP_ROUND", p2Style = "CAP_ROUND");
        line2d(p3, p4, width = width, p1Style = "CAP_ROUND", p2Style = "CAP_ROUND");  
                   
        if(n != 0) {
            rand_a = rand(15, 180);
            angle_between_gap = rand_a - gap_angle;         
            twoGapsCircle(outer_r, d, 
                gap_angle,
                gap_angle_offset,
                gap_angle_offset + gap_angle + angle_between_gap,
                width = width);
            euler_circles(n - 1, outer_r, gap_angle, gap_angle_offset + rand_a);            
        } else {
            oneGapCircle(outer_r, d, gap_angle_offset, gap_angle_offset + gap_angle, width = width);  
        }
    }
    
    gap_angle = angle(r, d);
    
    oneGapCircle(r, d, 0, gap_angle, width = width);
    euler_circles(n - 2, r, gap_angle, 0);
}

euler_maze(
    number_of_circles, 
    minimum_radius, 
    gap_distance, 
    line_width, 
    $fn = 96
);

