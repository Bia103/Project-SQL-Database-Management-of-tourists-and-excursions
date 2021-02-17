CREATE TABLE TURIST_BFU (
    id_turist int,
    Nume varchar(50),
    Prenume varchar(50),
    Varsta int
);

ALTER TABLE TURIST_BFU
ADD PRIMARY KEY (id_turist);

INSERT INTO TURIST_BFU (id_turist, Nume, Prenume, Varsta)
VALUES (1, 'Ionescu', 'Ionel', 50);

SELECT *
FROM TURIST_BFU;

COMMIT;

INSERT INTO TURIST_BFU (id_turist, Nume, Prenume, Varsta)
VALUES (2, 'Marin', 'Ionela', 50);

CREATE TABLE GHID_BFU (
    id_ghid int primary key,
    Nume varchar(50),
    Prenume varchar(50),
    Salariu int
);


CREATE TABLE AGENTIE_BFU (
    id_agentie int primary key,
    Nume varchar(50),
    Data_infintarii date
);

CREATE TABLE LOCATIE_BFU (
    id_locatie int primary key,
    Nume varchar(50),
    Taxa_Statiune int
);

CREATE TABLE EXCURSIE_BFU (
    id_excursie int PRIMARY KEY,
    id_locatie int,
    Pret int,
    Locuri int,
    id_agentie int,
    Data_inceperii date,
    Data_terminarii date,
    id_ghid int,
    FOREIGN KEY(id_agentie) REFERENCES AGENTIE_BFU(id_agentie),
    FOREIGN KEY(id_locatie) REFERENCES LOCATIE_BFU(id_locatie),
    FOREIGN KEY(id_ghid) REFERENCES GHID_BFU(id_ghid)
);

CREATE TABLE ACHIZITIE_BFU(
    id_tur int,
    id_locatie int,
    FOREIGN KEY(id_tur) REFERENCES TURIST_BFU(id_turist),
    FOREIGN KEY(id_locatie) REFERENCES EXCURSIE_BFU(id_excursie),
    data date
);
alter table ACHIZITIE_BFU add primary key (id_tur,id_locatie);

INSERT INTO TURIST_BFU (id_turist, Nume, Prenume, Varsta)
VALUES (3, 'Enescu', 'George', 102);
INSERT INTO TURIST_BFU (id_turist, Nume, Prenume, Varsta)
VALUES (4, 'Ivan', 'Cristina', 20);
INSERT INTO TURIST_BFU (id_turist, Nume, Prenume, Varsta)
VALUES (5, 'Ignat', 'Marius', 30);
INSERT INTO TURIST_BFU (id_turist, Nume, Prenume, Varsta)
VALUES (6, 'Gasai', 'Yuno', 17);
INSERT INTO TURIST_BFU (id_turist, Nume, Prenume, Varsta)
VALUES (7, 'Natsuki', 'Subaru', 18);


INSERT INTO GHID_BFU (id_ghid, Nume, Prenume, Salariu)
VALUES (61, 'Hori', 'Iroh', 3800);
INSERT INTO GHID_BFU (id_ghid, Nume, Prenume, Salariu)
VALUES (62, 'Hori', 'Azula', 1800);
INSERT INTO GHID_BFU (id_ghid, Nume, Prenume, Salariu)
VALUES (63, 'Popescu', 'Eliza', 2800);

SELECT *
FROM GHID_BFU;

ALTER TABLE GHID_BFU
ADD ID_GHID_COORDONATOR int;

UPDATE GHID_BFU
SET ID_GHID_COORDONATOR=61
WHERE id_ghid > 61;

COMMIT;


INSERT INTO AGENTIE_BFU (id_agentie, Nume, Data_infintarii)
VALUES (41, 'Calatoria de vis', TO_DATE('17/12/2015', 'DD/MM/YYYY'));

INSERT INTO AGENTIE_BFU (id_agentie, Nume, Data_infintarii)
VALUES (42, 'Croaziera ideala', TO_DATE('01/01/2010', 'DD/MM/YYYY'));

INSERT INTO AGENTIE_BFU (id_agentie, Nume, Data_infintarii)
VALUES (43, 'TheEntireWorld', TO_DATE('17/07/1999', 'DD/MM/YYYY'));

INSERT INTO AGENTIE_BFU (id_agentie, Nume, Data_infintarii)
VALUES (44, 'Travel', TO_DATE('19/03/2015', 'DD/MM/YYYY'));

SELECT * 
FROM AGENTIE_BFU;

INSERT INTO Locatie_BFU (id_locatie, Nume, Taxa_statiune)
VALUES (31,'Sinaia', 50);

INSERT INTO Locatie_BFU (id_locatie, Nume, Taxa_statiune)
VALUES (32,'Busteni', 30);

INSERT INTO Locatie_BFU (id_locatie, Nume, Taxa_statiune)
VALUES (33,'Cluj', 10);

INSERT INTO Locatie_BFU (id_locatie, Nume, Taxa_statiune)
VALUES (34,'Sibiu', 20);


SELECT *
FROM GHID_BFU;



COMMIT;

ALTER TABLE EXCURSIE_BFU
MODIFY id_locatie int NOT NULL;

ALTER TABLE EXCURSIE_BFU
MODIFY id_ghid int NOT NULL;
ALTER TABLE EXCURSIE_BFU
MODIFY id_agentie int NOT NULL;

INSERT INTO EXCURSIE_BFU (id_excursie, id_locatie, pret, locuri,id_agentie,data_inceperii, data_terminarii,id_ghid)
VALUES (21, 31, 2000, 38,42,'17/12/2020','20/12/2020',61);

INSERT INTO EXCURSIE_BFU (id_excursie, id_locatie, pret, locuri,id_agentie,data_inceperii, data_terminarii,id_ghid)
VALUES (22, 33, 1000, 10,44,'10/03/2021','20/03/2021',62);

INSERT INTO EXCURSIE_BFU (id_excursie, id_locatie, pret, locuri,id_agentie,data_inceperii, data_terminarii,id_ghid)
VALUES (23, 32, 1800, 8,42,'19/07/2020','25/07/2020',62);

INSERT INTO EXCURSIE_BFU (id_excursie, id_locatie, pret, locuri,id_agentie,data_inceperii, data_terminarii,id_ghid)
VALUES (24, 34, 1200, 32,43,'12/11/2020','12/12/2020',63);

INSERT INTO EXCURSIE_BFU (id_excursie, id_locatie, pret, locuri,id_agentie,data_inceperii, data_terminarii,id_ghid)
VALUES (25, 32, 100, 9,41,'19/12/2020','20/12/2020',61);



COMMIT;

DROP TABLE ACHIZITIE_BFU;

CREATE TABLE ACHIZITIE_BFU(
    id_tur int,
    id_ex int,
    FOREIGN KEY(id_tur) REFERENCES TURIST_BFU(id_turist),
    FOREIGN KEY(id_ex) REFERENCES EXCURSIE_BFU(id_excursie),
    data date
);
alter table ACHIZITIE_BFU add primary key (id_tur,id_ex);

INSERT INTO ACHIZITIE_BFU (id_tur,id_ex,data)
VALUES (1,21,'20/06/2020');

INSERT INTO ACHIZITIE_BFU (id_tur,id_ex,data)
VALUES (1,22,'21/04/2020');

INSERT INTO ACHIZITIE_BFU (id_tur,id_ex,data)
VALUES (2,23,'29/05/2020');

INSERT INTO ACHIZITIE_BFU (id_tur,id_ex,data)
VALUES (2,24,'05/06/2019');

INSERT INTO ACHIZITIE_BFU (id_tur,id_ex,data)
VALUES (3,21,'26/03/2020');

INSERT INTO ACHIZITIE_BFU (id_tur,id_ex,data)
VALUES (3,22,'11/01/2020');

INSERT INTO ACHIZITIE_BFU (id_tur,id_ex,data)
VALUES (4,22,'25/02/2020');

INSERT INTO ACHIZITIE_BFU (id_tur,id_ex,data)
VALUES (5,25,'16/02/2019');

INSERT INTO ACHIZITIE_BFU (id_tur,id_ex,data)
VALUES (6,24,'15/12/2019');

INSERT INTO ACHIZITIE_BFU (id_tur,id_ex,data)
VALUES (7,25,'07/06/2020');

INSERT INTO ACHIZITIE_BFU (id_tur,id_ex,data)
VALUES (2,25,'03/06/2020');

COMMIT;