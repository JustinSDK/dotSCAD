function _m_cumulate(matrice, i) = 
    i == len(matrice) - 2 ?
        matrice[i] * matrice[i + 1] :
        matrice[i] * _m_cumulate(matrice, i + 1);

function _m_cumulate_impl(matrice) = 
    len(matrice) == 1 ? matrice[0] : _m_cumulate(matrice, 0);
    