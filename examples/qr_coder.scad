use <part/connector_peg.scad>

t = "1000 followers"; 
head_size = 30;
qr_thickness = 1.5;  

peg_radius = 2.5;
spacing = 0.5;  

min_error_correction_level = "medium"; // [low, medium, quartile, high]
mask = 3; // [0:7]
encoding = "byte"; // [num, alphanum, byte]

qr_coder();

module qr_coder() {
    color("black") 
    rotate([0, 180, 0]) 
    translate([0, 0, -qr_thickness - head_size]) 
    linear_extrude(qr_thickness) 
    mirror([1, 0, 0]) 
        qrcode(t, head_size * 0.9, encoding, min_error_correction_level, mask, center = true); 

    cube_character(head_size);
}

module cube_character(head_size) {
    $fn = 48;
    
    module head() {
        half_head_size = head_size / 2;
        difference() {
            linear_extrude(head_size) 
                square(head_size, center = true);
            
            translate([0, -half_head_size, half_head_size])
            rotate([-90, 0, 0]) 
                connector_peg(peg_radius, spacing = spacing, void = true);         
        }            
    }
    
    module body() {
        body_size = head_size * 0.75;
        half_body_size = body_size / 2;
        
        module peg_void() {
            translate([half_body_size + 1, head_size * 0.2, half_body_size])
            rotate([0, -90, 0]) 
                connector_peg(peg_radius, spacing = spacing, void = true);   
        }
        
        difference() {
             linear_extrude(body_size) 
             union() {
                square(body_size, center = true);
                // feet
                translate([0, -head_size * 0.4, 0]) 
                difference() {
                    square(head_size * 0.65, center = true);
                    square([head_size * 0.05, head_size * 0.65], center = true);
                }
            }                        
                
            // holes
            translate([0, half_body_size + 1, half_body_size])
            rotate([90, 0, 0]) 
                connector_peg(peg_radius, spacing = spacing, void = true);   
                    
            peg_void();   
            mirror([1, 0, 0]) peg_void();                               
        }
         
        // hands
        hand_size = [head_size * 0.275, head_size * 0.625];
        hand_offsetx = body_size + 2;
        
        module hand() {
             translate([half_body_size / 2, 0, 0]) 
             rotate([0, -90, 0]) 
             translate([hand_size[0] / 2, 0, 0]) {
                linear_extrude(half_body_size)
                    square(hand_size, center = true);
                    
                translate([head_size * 0.1375, head_size * 0.1375, half_body_size / 2]) 
                rotate([0, 90, 0]) 
                    connector_peg(peg_radius, spacing = spacing);   
            }
        }
                 
        translate([-body_size, 0]) hand();
        translate([body_size, 0]) hand();    
    }
    
   head();
    
   translate([0, -head_size, 0]) 
        body();
        
    translate([0, head_size * 0.75]) 
        connector_peg(peg_radius, spacing = spacing, ends = true);   
}

// refactored from https://www.thingiverse.com/thing:258542
module qrcode(t, size, encoding = "byte", min_ec = "medium", mask = 3, center = false) {
    module px(x, y) {
        translate([x,y]) square([1.01, 1.01]);
    }
    
    module draw_encoded_string(encoded_string, version, mask) {
        for(bit=[0:len(encoded_string)-1]) {
            draw(encoded_string, version, bit, position(bit,version), mask);
        }
    }

    module draw(t, version, bit, xy, mask) {
        _draw(t, version, bit, floor(xy/1000), xy%1000, mask);
    }

    module _draw(t, version, bit, x, y, mask) {
        if(xor(t[bit]=="1",mask(x,y,mask))) {
            px(x, y);
        }
    }

    module draw_alignment_patterns(version) {
        if(version > 1) {
            if(version < 7) {
                offset = 8+4*version;
                alignment_pattern(offset, offset);
            } else if(version < 14) {
                for(i=[0:2]) {
                    for(j=[0:2]) {
                        if((i!=0 && j!=0) || i==1 || j==1) {
                            alignment_pattern(2*i*(version+1)+4, 2*j*(version+1)+4);
                        }
                    }
                }
            }
        }        
    }

    module position_pattern() {
        difference() {
            square([7.01,7.01]);
            translate(v=[1,1])
                square([5.01,5.01]);
        }
        translate(v=[2,2])
            square([3.01,3.01]);
    }

    module alignment_pattern(x, y) {
        translate(v=[x, y]) {
            difference() {
                square([5.01,5.01]);
                translate(v=[1,1])
                square([3.01,3.01]);
            }
            px(2, 2);
        }
    }

    module format_pattern(sequence, version) {
        for(i=[0:5]) {
            if(sequence[14-i]=="1") {
                px(i, 8);
                px(8, 16+4*version-i);
            }
        }
        for(i=[6:7]) {
            if(sequence[14-i]=="1") {
                px(i+1, 8);
                px(8, 16+4*version-i);
            }
        }
        for(i=[8]) {
            if(sequence[14-i]=="1") {
                px(8, 15-i);
                px(2+4*version+i, 8);
            }
        }
        for(i=[9:14]) {
            if(sequence[14-i]=="1") {
                px(8, 14-i);
                px(2+4*version+i, 8);
            }
        }
    }

    module timing_pattern(version) {
        for(i=[0:2*version]) {
            px(2*i+8, 6);
            px(6, 2*i+8);
        }
    }

    function substring(t,start,end,output="") = start==end ? output : str(t[start],substring(t,start+1,end,output));

    function encode(t, ec, version) = str(encode_data(pad_data(t, ec, version), ec, version), encode_error(pad_data(t, ec, version), ec, version), padding_bits(ec, version));

    function encode_error(s, ec, v) = encode_error_data(error_data(s, ec, v), ec, v);

    version_table = [
        [[17,[[19,7]],1],[14,[[16,10]],1],[11,[[13,13]],1],[7,[[9,17]],1],0],
        [[32,[[34,10]],1],[26,[[28,16]],1],[20,[[22,22]],1],[14,[[16,28]],1],7],
        [[53,[[55,15]],1],[42,[[44,26]],1],[32,[[17,18],[17,18]],1],[24,[[13,22],[13,22]],2],7],
        [[78,[[80,20]],1],[62,[[32,18],[32,18]],2],[46,[[24,26],[24,26]],2],[34,[[9,16],[9,16],[9,16],[9,16]],4],7],
        [[106,[[108,26]],1],[84,[[43,24],[43,24]],2],[60,[[15,18],[15,18],[16,18],[16,18]],4],[44,[[11,22],[11,22],[12,22],[12,22]],4],7],
        [[134,[[68,18],[68,18]],2],[106,[[27,16],[27,16],[27,16],[27,16]],4],[74,[[19,24],[19,24],[19,24],[19,24]],4],[58,[[15,28],[15,28],[15,28],[15,28]],4],7]
    ];
    function encode_error_data(t, ec, version, pos=0, byte=0, block=0) =
        version_table[version-1][ec][1][block][1]>byte ? str(bits(hex_to_int(t[pos])*16+hex_to_int(t[pos+1])), encode_error_data(t, ec, version, _next_epos(version, ec, pos, byte, block), _next_ebyte(version, ec, pos, byte, block), _next_eblock(version, ec, pos, byte, block))) : "";
    function _next_epos(v,ec,p,y,b) = b<len(version_table[v-1][ec][1])-1 ? p+2*version_table[v-1][ec][1][b][1] :
        y<version_table[v-1][ec][1][0][1]-1 ? 2*(y+1) :
        y<version_table[v-1][ec][1][b][1]-1 ? 2*(version_table[v-1][ec][2]*version_table[v-1][ec][1][0][1]+y+1) : 2*(y+1);
    function _next_ebyte(v,ec,p,y,b) = b<len(version_table[v-1][ec][1])-1 ? y : y+1;
    function _next_eblock(v,ec,p,y,b) = b<len(version_table[v-1][ec][1])-1 ? b+1 :
        y<version_table[v-1][ec][1][0][1]-1 ? 0 :
        y<version_table[v-1][ec][1][b][1]-1 ? version_table[v-1][ec][2] : 0;

    function error_data(s, ec, v, b=0) = b<len(version_table[v-1][ec][1]) ? str(error_block(substring(s,0,2*version_table[v-1][ec][1][b][0]), ec, v, b),error_data(substring(s,2*version_table[v-1][ec][1][b][1],len(s)), ec, v, b+1)) : "";

    error_formula = ["","","001901","","","0071A4A6770A","0074008605B00F","0057E59295EE6615","00AFEED0F9D7FCC41C","","00FB432E3D7646405E202D","","","004A98B06456646A6882DACE8C4E","00C7F99B30BE7CDA89D857CF3B165B","0008B73D5BCA25333A3AED8C7C056369","0078686B6D66A14C035BBF93A9C2E178","002B8BCE4E2BEF7BCED69318639627F3A388","00D7EA9E5EB86176AA4FBB9894FCB305626099","","00113C4F323DA31ABBCAB4DDE153EF9CA4D4D4BCBE","","00D2ABF7F25DE60E6DDD35C84A08AC6250DB86A069A5E7","","00E5798730D375FB7E9FB4A998C0E2E4DA6F0075E85760E315","","00AD7D9E0267B6761191C96F1CA535A115F58E0D6630E39991DA46","","00A8DFC868E0EA6CB46EBEC393CD1BE8C9152BF5572AC3D477F225097B","","0029AD9198D81FB3B632306E56EF60DE7D2AADE2C1E0829C25FBD8EE28C0B4","","0A066ABEF9A70443D18A8A20F27B591B78B9509C2645AB3C1CDE5034FEB9DCF1","","006F4D925E1A156C13695E71C1568CA37D3A9EE5EFDA673846723DB781A70D623E8133","","00C8B76210AC1FF6EA3C987300A79871F8EE6B123FDA2557D269B1784A79C475FB71E91E2F083B744FA1FC6280CD80A1F739A338EB6A351ABBAEE268AA07AF23B57258292FA37D864814E835230F","","","","","","00FA67DDE6191289E700033AF2DDBF6E54E608BC6A60930F838B2265DF2765D5C7EDFEC97BABA2C2753260","","00BE073D7947F64537A8BC59F3BF19487B09910EF701EE2C4E8F3EE07E767244A334C2D993CCA92582716649B5","","00705E5870FDE0CA73BB6359053671812C3A1087D8A9D3240104603CF14968EA08F9F577AE34199DE02BCADF13520F","","00E419C482D3923C18FB5A2766F03DB23F2E7B7312DD6F87A0B6CD6BCE5F9678B85B15F79C8CEEBF0B5EE35432A327226C","","00E87D9DA1A409762ED163CBC12303D16FC3F2CBE12E0D20A07ED182A0F2D7F24B4D2ABD2071417C45E472EBAF7CAAD7E885CD","","00743256BA32DCFB59C02E567F7C13B8E997D7160E3B9125F2CB86FE59BE5E3B417C7164E9EB79164C566127F2C8DC6521EFFE7433","","00B71AC957D2DD71152E412D32EEB8F9E1663AD1DA6DA51A5FB8C034F523FEEEAFAC4F7B197A2B786CD75080C9EB08993B651FC64C1F9C","","006A786B9DA4D87074025BF8A324C9CAE50690FE9B87D0AAD10C8B7F8EB6F9B1AEBE1C0A55EFB8657C98CE6017A33D1BC4F7979ACACF143D0A","","0052741AF7421B3E6BFCB6C8B9EB37FBF2D2909AEDB08DC0F898F9CE55FD8E41A57D17181E7AF0D60681DA1D917F86CEF5751D293F9F8EE97D947B","","006B8C1A0C098DF3C5E2C5DB2DD365DB781CB57F0664F702CDC63973DB656DA0522526EE31A0D179560B7C1EB55419C2574166BEDC461BD110590721F0","","0041CA716247DFF876D65E007A251702E43A790769874EF376464CDF594832466FC211D47EB523DD75EB0BE595937BD5287306C8641AF6B6DA7FD724BA6E6A","","002D33AF09079E9F3144775C7BB1CCBBFEC84E8D95771A7F35A05DC7D41D18919CD096DAD104D85B2FB8922F8CC3C37DF2EE3F636C8CE6F21FCC0BB2F3D99CD5E7","","000576DEB48888A2332E750DD751118BF7C5AB5FAD4189B2446F5F652948D6A9C55F072C9A4D6FEC28798F3F5750FDF07ED94D22E86A32A8524C92436AAB19845D2D69","","00F79FDF21E05D4D465AA020FE2B965465BECD85343CCAA5DCCB975D540F54FDADA059E334C7615FE734B1297D89F1A6E17602362052D7AFC62BEEEB1B65B87F030508A3EE"];
    function error_block(s, ec, v, b) = encode_eb(pad_eb(s,version_table[v-1][ec][1][b][1]),error_formula[version_table[v-1][ec][1][b][1]]);

    function pad_eb(s,count) = count<=0 ? s : pad_eb(str(s,"00"),count-1);

    function encode_eb(s,f) = len(s)<=len(f)-2 ? s : encode_eb(substring(_encode_eb(s,f,log_a(hex_to_int(s[0])*16+hex_to_int(s[1]))),2,len(s)),f);

    function _encode_eb(s,f,s0,p=0) = p==len(f) ? substring(s,p,len(s)) :
        str(int_to_hex(bitwise_xor(pow_a(((hex_to_int(f[p])*16+hex_to_int(f[p+1]))+s0)%255),hex_to_int(s[p])*16+hex_to_int(s[p+1]))),_encode_eb(s,f,s0,p+2));

    coefficients = [1,2,4,8,16,32,64,128,29,58,116,232,205,135,19,38,76,152,45,90,180,117,234,201,143,3,6,12,24,48,96,192,157,39,78,156,37,74,148,53,106,212,181,119,238,193,159,35,70,140,5,10,20,40,80,160,93,186,105,210,185,111,222,161,95,190,97,194,153,47,94,188,101,202,137,15,30,60,120,240,253,231,211,187,107,214,177,127,254,225,223,163,91,182,113,226,217,175,67,134,17,34,68,136,13,26,52,104,208,189,103,206,129,31,62,124,248,237,199,147,59,118,236,197,151,51,102,204,133,23,46,92,184,109,218,169,79,158,33,66,132,21,42,84,168,77,154,41,82,164,85,170,73,146,57,114,228,213,183,115,230,209,191,99,198,145,63,126,252,229,215,179,123,246,241,255,227,219,171,75,150,49,98,196,149,55,110,220,165,87,174,65,130,25,50,100,200,141,7,14,28,56,112,224,221,167,83,166,81,162,89,178,121,242,249,239,195,155,43,86,172,69,138,9,18,36,72,144,61,122,244,245,247,243,251,235,203,139,11,22,44,88,176,125,250,233,207,131,27,54,108,216,173,71,142];
    function pow_a(x) = coefficients[x];

    inv_coef = [255,0,1,25,2,50,26,198,3,223,51,238,27,104,199,75,4,100,224,14,52,141,239,129,28,193,105,248,200,8,76,113,5,138,101,47,225,36,15,33,53,147,142,218,240,18,130,69,29,181,194,125,106,39,249,185,201,154,9,120,77,228,114,166,6,191,139,98,102,221,48,253,226,152,37,179,16,145,34,136,54,208,148,206,143,150,219,189,241,210,19,92,131,56,70,64,30,66,182,163,195,72,126,110,107,58,40,84,250,133,186,61,202,94,155,159,10,21,121,43,78,212,229,172,115,243,167,87,7,112,192,247,140,128,99,13,103,74,222,237,49,197,254,24,227,165,153,119,38,184,180,124,17,68,146,217,35,32,137,46,55,63,209,91,149,188,207,205,144,135,151,178,220,252,190,97,242,86,211,171,20,42,93,158,132,60,57,83,71,109,65,162,31,45,67,216,183,123,164,118,196,23,73,236,127,12,111,246,108,161,59,82,41,157,85,170,251,96,134,177,187,204,62,90,203,89,95,176,156,169,160,81,11,245,22,235,122,117,44,215,79,174,213,233,230,231,173,232,116,214,244,234,168,80,88,175];        
    function log_a(x) = inv_coef[x];

    function encode_data(t, ec, version, pos=0, byte=0, block=0) =
        version_table[version-1][ec][1][block][0]>byte ? str(bits(hex_to_int(t[pos])*16+hex_to_int(t[pos+1])), encode_data(t, ec, version, _next_dpos(version, ec, pos, byte, block), _next_dbyte(version, ec, pos, byte, block), _next_dblock(version, ec, pos, byte, block))) : "";
    function _next_dpos(v,ec,p,y,b) = b<len(version_table[v-1][ec][1])-1 ? p+2*version_table[v-1][ec][1][b][0] :
        y<version_table[v-1][ec][1][0][0]-1 ? 2*(y+1) :
        y<version_table[v-1][ec][1][b][0]-1 ? 2*(version_table[v-1][ec][2]*version_table[v-1][ec][1][0][0]+y+1) : 2*(y+1);
    function _next_dbyte(v,ec,p,y,b) = b<len(version_table[v-1][ec][1])-1 ? y : y+1;
    function _next_dblock(v,ec,p,y,b) = b<len(version_table[v-1][ec][1])-1 ? b+1 :
        y<version_table[v-1][ec][1][0][0]-1 ? 0 :
        y<version_table[v-1][ec][1][b][0]-1 ? version_table[v-1][ec][2] : 0;

    function padding_bits(ec, v, b=0) = b<version_table[v-1][4] ? str("0",padding_bits(ec,v,b+1)) : "";

    function pad_data(t, ec, v, pad_string="") = len(t)+len(pad_string)>2*version_table[v-1][ec][0]+2+floor((v+20)/30) ? str(t,pad_string) :
        len(pad_string)%4 == 0 ? pad_data(t, ec, v, str(pad_string,"EC")) :
        pad_data(t, ec, v, str(pad_string,"11"));

    function bits(char, bit=0) = bit<7 ? str(_bit(char,bit),bits(char - (_bit(char,bit) * pow(2,7-bit)),bit+1)) : _bit(char,bit);
    function _bit(char, bit) = char>=pow(2,7-bit) ? 1 : 0;

    function hex_bits(chars) = bits(hex_to_int(chars[0])*16+hex_to_int(chars[1]));
    function hex_to_int(char) = search(char,"0123456789ABCDEF")[0];

    function int(char) = (search(char," !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~€‚ƒ„…†‡ˆ‰Š‹ŒŽ‘’“”•–—˜™š›œžŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ \t\n\r")[0]+32) % 256;
    function ec_to_int(ec) = ec=="low" ? 0 :
                                    ec=="medium" ? 1 :
                                    ec=="quartile" ? 2 : 3;

    function format_sequence(ec,mask) = ["101010000010010","101000100100101","101111001111100","101101101001011","100010111111001","100000011001110","100111110010111","100101010100000","111011111000100","111001011110011","111110110101010","111100010011101","110011000101111","110001100011000","110110001000001","110100101110110","001011010001001","001001110111110","001110011100111","001100111010000","000011101100010","000001001010101","000110100001100","000100000111011","011010101011111","011000001101000","011111100110001","011101000000110","010010010110100","010000110000011","010111011011010","010101111101101"][bitwise_xor(ec,1)*8+mask];

    function version(t, encoding, ec, v=1) = len(t)<=version_table[v-1][ec][0] ? v : version(t, encoding, ec, v+1);

    function ec(s,ec,v) = ec<4 && len(s)<=version_table[v-1][ec][0] ? ec(s,ec+1,v) : ec-1;

    function xor(a, b) = (a||b)&& !(a&&b);

    function bitwise_xor(a, b) = (a==0 && b==0) ? 0 : 2*bitwise_xor(floor(a/2), floor(b/2))+(xor(a%2==1,b%2==1)?1:0);

    function mask(x, y, m) = m==0 ? mask0(x,y) :
                                    m==1 ? mask1(x,y) :
                                    m==2 ? mask2(x,y) :
                                    m==3 ? mask3(x,y) :
                                    m==4 ? mask4(x,y) :
                                    m==5 ? mask5(x,y) :
                                    m==6 ? mask6(x,y) :
                                    mask7(x,y);
    function mask0(x,y) = (x+y)%2 == 0;
    function mask1(x,y) = x%2 == 0;
    function mask2(x,y) = y%3 == 0;
    function mask3(x,y) = (x+y)%3 == 0;
    function mask4(x,y) = (floor(x/2)+floor(y/3))%2 == 0;
    function mask5(x,y) = (x*y)%2 + (x*y)%3 == 0;
    function mask6(x,y) = ((x*y)%2 + (x*y)%3)%2 == 0;
    function mask7(x,y) = ((x+y)%2 + (x*y)%3)%2 == 0;

    function position(bit, version) = _position(bit,4*version+16,4*version+16,version,-1);
    function reserved(x,y,v) = x==6 || y==6 || 
                (x<9 && y<9) || (x<9 && y>4*v+8) || (x>4*v+8 && y<9) || 
                (v>6 && x>4*v+5 && y<6) || (v>6 && y>4*v+5 && x<6) || 
                (v>1 && x>=4*v+8 && x<=4*v+12 && y>=4*v+8 && y<=4*v+12) ||
                (v>=7 && v<=13 && ((x>=2*v+6 && x<=2*v+10 && y%(2*v+2)>=4 && y%(2*v+2)<=8) || (y>=2*v+6 && y<=2*v+10 && x%(2*v+2)>=4 && x%(2*v+2)<=8)));
    function _position(b,x,y,v,d) = b==0 && !reserved(x,y,v) ? 1000*x+y :
        reserved(x,y,v) ? _next_pos(b,x,y,v,d) : _next_pos(b-1,x,y,v,d);
    function _next_pos(b,x,y,v,d) = (y == 6) || ((y>6 && y%2 == 0) || (y<6 && y%2 == 1)) ? _position(b,x,y-1,v,d) :
         (d<0 && x == 0) || (d>0 && x == 4*v+16) ? _position(b,x,y-1,v,-d) :
        _position(b,x+d,y+1,v,d);

    function str_to_hex(t,char=0) = char==len(t) ? "" : str("0123456789ABCDEF"[floor(int(t[char])/16)],"0123456789ABCDEF"[int(t[char])%16],str_to_hex(t,char+1));

    function int_to_hex(i) = str("0123456789ABCDEF"[floor(i/16)],"0123456789ABCDEF"[i%16]);        

    version = version(t, encoding, ec_to_int(min_ec));
    dist_between_position_pattern = 10 + 4 * version;
    
    ec=ec(t,ec_to_int(min_ec),version);
    
    encoded_string = version<10 ? encode(str("4",int_to_hex(len(t)),str_to_hex(t),"0"), ec, version) : encode(str("4",int_to_hex(floor(len(t)/256)),int_to_hex(len(t)%256),str_to_hex(t),"0"), ec, version);
    
    qr_size = dist_between_position_pattern + 7;
    half_qr_size = qr_size / 2;
    
    s_factor = is_undef(size) ? 1 : size / qr_size;
    scaled_size = s_factor * qr_size;
    half_scaled_size = scaled_size / 2;

    // QR Code
    translate(center ? [-half_scaled_size, -half_scaled_size] : [0, 0]) scale(s_factor) {
        position_pattern();
        
        translate(v = [dist_between_position_pattern, 0])
            position_pattern();
        
        translate(v=[0, dist_between_position_pattern])
            position_pattern();
        
        px(9+4*version, 8);
        
        format_pattern(format_sequence(ec,mask), version);
        timing_pattern(version);
        draw_alignment_patterns(version);
        draw_encoded_string(encoded_string, version, mask);
    }
}