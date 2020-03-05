function zip2(lt1, lt2) =
    [for(i = [0:len(lt1) - 1]) [lt1[i], lt2[i]]];