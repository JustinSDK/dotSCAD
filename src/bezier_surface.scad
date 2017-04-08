function bezier_surface(t_step, ctrl_pts) =
    let(pts =  [
        for(i = [0:len(ctrl_pts) - 1]) 
            bezier_curve(t_step, ctrl_pts[i])
    ]) 
    [for(x = [0:len(pts[0]) - 1]) 
        bezier_curve(t_step,  
                [for(y = [0:len(pts) - 1]) pts[y][x]]
        ) 
    ];