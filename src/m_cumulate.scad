include <__private__/__m_multiply.scad>;

function _m_cumulate(matrice, i) = 
    i == len(matrice) - 2 ?
        __m_multiply(matrice[i], matrice[i + 1]) :
        __m_multiply(matrice[i], _m_cumulate(matrice, i + 1));

function m_cumulate(matrice) = 
    len(matrice) == 1 ? matrice[0] : _m_cumulate(matrice, 0);
    
