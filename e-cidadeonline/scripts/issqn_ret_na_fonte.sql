select issqnret.*
  from (
        select z01_numcgm, z01_nome, q20_inscr, q20_planilha, q20_numpre, sum( q21_valor ) as q21_valor
          from issplan
         inner join issplanit on q21_planilha = q20_planilha
         inner join cgm on z01_numcgm = q20_numcgm
         where q20_ano = 2006
           and q20_mes = 1
        group by z01_numcgm, z01_nome, q20_inscr, q20_planilha, q20_numpre
      ) as issqnret
  left join arrecad on k00_numpre = q20_numpre
order by q20_planilha

