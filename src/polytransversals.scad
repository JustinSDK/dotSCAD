/**
* polytransversals.scad
*
* Crosscutting a polyline at different points gets several transversals.
* This module can operate reversely. It uses transversals to construct a polyline.
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-polytransversals.html
*
**/

module polytransversals(transversals) {
    module two_transversals(trans1, trans2) {
        leng_trans2 = len(trans2);
        polygon(concat(
            trans1, 
            [for(i = [0:leng_trans2 - 1]) trans2[leng_trans2 - 1 - i]]
        ));
    }
    
    for(i = [0:len(transversals) - 2]) {
        two_transversals(transversals[i], transversals[i + 1]);
    }
}