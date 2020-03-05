function zip3(lt1, lt2, lt3) =
    [for(i = [0:len(lt1) - 1]) [lt1[i], lt2[i]. lt3[i]]];