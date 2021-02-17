-- Furculesteanu Bianca grupa 241
-- Cererea 1: Sa se afiseze cat plateste in medie fiecare turist pentru a merge intr-o excursie si pretul cel mai mic si cel mai mare pe care acesta trebuie sa-l plateasca

SELECT t.id_turist, AVG(e.pret) medie, MAX(e.pret) pret_maxim,MIN(e.pret) pret_minim
FROM TURIST_BFU t RIGHT JOIN ACHIZITIE_BFU ac on(t.id_turist = ac.id_tur) LEFT JOIN EXCURSIE_BFU e ON (ac.id_ex = e.id_excursie) 
GROUP BY t.id_turist
ORDER BY t.id_turist asc;

--Cererea 2: Sa se afiseze toti turistii care si-au achizitionat vacanta in 2019

SELECT *
FROM TURIST_BFU t RIGHT JOIN ACHIZITIE_BFU ac on (t.id_turist = ac.id_tur)
WHERE EXTRACT(year FROM ac.data) = 2019;

--Cererea 3: Se se afiseze toti turistii care merg in excursii cu un ghid al carui nume este hori
WITH temporaryTable  as
    (SELECT *
    FROM TURIST_BFU t RIGHT JOIN ACHIZITIE_BFU ac on(t.id_turist = ac.id_tur) LEFT JOIN EXCURSIE_BFU e ON (ac.id_ex = e.id_excursie))
SELECT DISTINCT(x.NUME ||' '||x.prenume) Nume_Prenume
FROM temporaryTable x FULL JOIN GHID_BFU y ON(x.id_ghid = y.id_ghid)
WHERE UPPER(y.nume) = 'HORI'
;

--Cererea 4: Afisati toti turistii care se duc in excursie in locatia cu id-ul 32
WITH informatii  as
    (SELECT *
    FROM TURIST_BFU t RIGHT JOIN ACHIZITIE_BFU ac on(t.id_turist = ac.id_tur) LEFT JOIN EXCURSIE_BFU e ON (ac.id_ex = e.id_excursie))
SELECT id_turist
FROM informatii
MINUS

SELECT id_turist
FROM (SELECT id_turist, id_locatie
FROM (SELECT DISTINCT id_turist FROM informatii) t1,
 (SELECT id_locatie FROM EXCURSIE_BFU WHERE id_locatie = 32) t2
MINUS
SELECT id_turist, id_locatie FROM informatii) t3;

--Cererea 5: Afisarea tuturor turistilor care merg in toate excursiile din locatia cu id-ul 32

WITH informatii  as
    (SELECT *
    FROM TURIST_BFU t RIGHT JOIN ACHIZITIE_BFU ac on(t.id_turist = ac.id_tur) LEFT JOIN EXCURSIE_BFU e ON (ac.id_ex = e.id_excursie))
SELECT id_turist
FROM informatii
WHERE id_locatie IN (SELECT e.id_locatie
                    FROM excursie_BFU e
                    WHERE id_locatie=32)
GROUP BY id_turist
HAVING COUNT(id_locatie)= (SELECT COUNT(*)
                           FROM excursie_BFU
                           WHERE id_locatie =32);

--Cererea 6: Sa se afiseze numele locatiilor unde se tine o excursie

SELECT id_excursie, DECODE(id_locatie, 31, 'Sinaia', 32, 'Busteni', 33, 'Cluj', 34 ,'Sibiu', 'Tara de nicaieri') Locatie
FROM EXCURSIE_BFU;

--Cererea 7: Sa se afiseze din ce categorie de varsta face parte un turist

SELECT nume , prenume,
CASE WHEN Varsta < 18 THEN 'Copil'
WHEN Varsta > 17 AND VARSTA < 40 THEN 'Tanar adult'
WHEN VARSTA > 39 AND VARSTA < 60 THEN 'Adult'
ELSE 'Senior'
END AS Categorie_Varsta
FROM TURIST_BFU;

-- Cererea 8: Sa se afiseze cate luni sunt intre data in care s-a infiintat o agentie si data in care se va efectua prima excursie
SELECT MONTHS_BETWEEN 
   (data_inceperii,
    data_infintarii ) "Months"
    FROM DUAL, excursie_bfu e JOIN agentie_BFU a on(e.id_agentie=a.id_agentie);



-- Cererea 9:
select * from ghid_bfu
start with ID_GHID_COORDONATOR is null
connect by prior id_ghid = ID_GHID_COORDONATOR;

-- Cererea 10: Numarul de oameni care participa la o excursie

SELECT e.id_excursie, count(t.id_turist)
FROM TURIST_BFU t RIGHT JOIN ACHIZITIE_BFU ac on(t.id_turist = ac.id_tur) LEFT JOIN EXCURSIE_BFU e ON (ac.id_ex = e.id_excursie) 
GROUP BY e.id_excursie
ORDER BY e.id_excursie desc;

-- Cererea 11: Cele mai scumpe 2 excursii

SELECT *
FROM (SELECT * FROM EXCURSIE_BFU ORDER BY pret desc)
WHERE rownum < 3;

-- Cererea 12: Afisati toate persoanele care merg in excursii

SELECT nume
FROM turist_bfu

UNION
SELECT nume
FROM ghid_bfu;

-- Cererea 13: Sa se majoreze salariul ghizilor cu 10% * numarul de turisti ce participa la o excursie organizata de ei

SELECT  g.id_ghid,  g.salariu + count(t.id_turist)* g.salariu salariu_majorat
FROM TURIST_BFU t RIGHT JOIN ACHIZITIE_BFU ac on(t.id_turist = ac.id_tur) LEFT JOIN EXCURSIE_BFU e ON (ac.id_ex = e.id_excursie)  LEFT JOIN GHID_BFU g on (e.id_ghid = g.id_ghid)
GROUP BY g.id_ghid, g.salariu
ORDER BY g.id_ghid desc;

-- Cererea 14: Sa se selecteze tate excursiile in care participa persoane cu numele ce incepe cu I
SELECT  *
FROM TURIST_BFU t RIGHT JOIN ACHIZITIE_BFU ac on(t.id_turist = ac.id_tur) LEFT JOIN EXCURSIE_BFU e ON (ac.id_ex = e.id_excursie)
WHERE t.id_turist in(
                    SELECT id_turist
                    FROM turist_BFU
                    WHERE LOWER(turist_BFU.nume) LIKE 'i%'
);

-- Cererea 15: Selectati toate coloanele ce privesc turistii care au numele si prenumele incepanf cu aceiasi litera

SELECT *
FROM turist_bfu
WHERE UPPER(nume) LIKE '&&p_litera%'
AND UPPER(prenume) LIKE '&p_litera%';





