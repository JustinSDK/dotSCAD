/**
* log.scad
*
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-log.html
*
**/

/*
   The accepted values are "OFF" (-1), "INFO" (20), 
   "WARNING" (30), "ERROR" (40) or positive integers.
*/
$log_level = "INFO";

module log(level = "INFO", level_color) {
    default_level_ints = [
        ["OFF", -1],
        ["INFO", 20], 
        ["WARNING", 30],
        ["ERROR", 40]
    ];
    
    default_level_colors = [
        ["INFO", "green"], 
        ["WARNING", "orange"],
        ["ERROR", "red"]
    ];    

    /*
        The built-in lookup function require integer keys. 
        I overwrite it so that using string keys is ok.
    */
    function lookup(key, mappings, i = 0) = 
        i == len(mappings) ? key : (
            key == mappings[i][0] ? 
                mappings[i][1] :
                lookup(key, mappings, i + 1)
        );

    if($log_level != "OFF") {            
        argu_level = lookup(level, default_level_ints);
        golbal_level = lookup(
            $log_level == undef ? "INFO" : $log_level,
            default_level_ints
        );

        if(argu_level >= golbal_level) {
            c = level_color == undef ? lookup(level, default_level_colors) : level_color;
            lv = str(len(level) == undef ? "LEVEL " : "", level);
            
            // level text
            echo(
                str( 
                    "<b>",
                        "<span style='color:", c, "'>", 
                            lv, 
                        "</span>", 
                    "</b>"
                )
            );
            
            // echo 
            for(i = [0:$children - 1]) {
                children(i);
            }
        }    
    } 
}