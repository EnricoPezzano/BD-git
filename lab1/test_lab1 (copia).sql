

--Abbiamo lavorato insieme su tutte le 4 parti del codice, terminando in data 27/03/2021


-----------------------------------------------(1)----------------------------------------------------

CREATE SCHEMA corsi;
set search_path to corsi;

CREATE TABLE corsi.professori
(
Id numeric(5) NOT NULL Primary KEY,
Cognome VARCHAR(20) NOT NULL,
Nome VARCHAR(20) NOT NULL,
Stipendio NUMERIC(8,2) DEFAULT 15000,
InCongedo BOOLEAN DEFAULT false
);

INSERT INTO corsi.professori values(12345, 'Pesce', 'Marco', 16000, false);
INSERT INTO corsi.professori values(23456, 'Iannuzzi', 'Federica', 30000.12, false);
INSERT INTO corsi.professori values(34567, 'Lavarello', 'Barbara', 50000, true);
INSERT INTO corsi.professori values(45678, 'Tarantino', 'Quentin', 3.14, false);
INSERT INTO corsi.professori values(56789, 'Kusturica', 'Emir', 900.78, true);
INSERT INTO corsi.professori values(98700, 'Pinco', 'Panco', 1, true);
INSERT INTO corsi.professori values(98765, 'Lampa', 'Dina', 15000, false);

-----------------------------------------------(2)----------------------------------------------------

insert into corsi.professori values(12345,'scaletta','danieletto',1, true);
--ERROR: ERRORE:  un valore chiave duplicato viola il vincolo univoco "professori_pkey"
--DETAIL:  La chiave (id)=(12345) esiste già.

insert into corsi.professori values(12348,null,'danieletto',44, false);
--ERROR: ERRORE:  valori null nella colonna "cognome" violano il vincolo non-null
--DETAIL:  La riga in errore contiene (12348, null, danieletto, 44.00).

CREATE TABLE corsi.corso --corsi.corsi?
(
    Id CHAR(10)  NOT NULL PRIMARY KEY,
    CorsoDiLaurea VARCHAR(30),
    Nome VARCHAR(35) NOT NULL,
    Professore NUMERIC(5,0),
    Attivato BOOLEAN DEFAULT false,
    FOREIGN KEY (Professore) REFERENCES Corsi.Professori (Id)
);

insert into corsi.corso values(1234554321,'Smid','Probabilità',null,false);
insert into corsi.corso values(1234567890,'Informatica','Programmazione1',12345,false);
insert into corsi.corso values(2345678901,'Smid','Probabilità',23456,false);
insert into corsi.corso values(3456789012,'Matematica','Analisi Fourier',34567,false);
insert into corsi.corso values(4567890123,'Informatica','Algebra e Logica',45678,false);
insert into corsi.corso values(5678901234,'Matematica','Calcolo numerico',12345,false);


-----------------------------------------------(3)----------------------------------------------------


CREATE TABLE Corsi.Studenti
(
    Matricola SERIAL PRIMARY KEY, --NOT NULL
    Cognome VARCHAR(20)  NOT NULL,
    Nome VARCHAR(20)  NOT NULL,
    CorsoDiLaurea VARCHAR(30),
    Iscrizione NUMERIC(8) NOT NULL,
    Relatore NUMERIC(5),
    FOREIGN KEY (Relatore) REFERENCES Corsi.Professori (Id)
);

INSERT INTO Corsi.Studenti values(default,'Pietra', 'pietro', 'SMID', 20102011, null);
INSERT INTO Corsi.Studenti values(default,'Lampa', 'Dario', 'informatica', 20142015, 23456);
INSERT INTO Corsi.Studenti values(default,'Pietrasanta', 'Arianna', 'matematica', 20172018, 98700);
INSERT INTO Corsi.Studenti values(default,'Pezzano', 'Enrico', 'informatica', 20192020, null);
INSERT INTO Corsi.Studenti values(default,'Scala', 'Daniele', 'informatica', 20192020, null);


-----------------------------------------------(4)----------------------------------------------------

ALTER TABLE Corsi.corso
ADD MutuaDa CHAR(10);

ALTER TABLE Corsi.corso
ADD FOREIGN KEY (MutuaDa) REFERENCES Corsi.corso(Id);

Insert Into corsi.corso values('abcdefghij', 'informatica', 'basi di dati', '98765',true, null);
Insert Into corsi.corso values('abcdefghik', 'smid', 'basi di dati', '98765',true, 'abcdefghij');

ALTER TABLE professori
ALTER COLUMN stipendio DECIMAL(9,2);

INSERT INTO corsi.corso values(68, 'informatica', 'tcs', NULL, NULL);
INSERT INTO corsi.corso values(69, 'informatica', 'tcs', NULL, NULL);

alter table corso
add unique (nome , corsodilaurea);
-- ERROR: ERRORE:  creazione dell'indice univoco "corso_nome_corsodilaurea_key" fallita
-- DETAIL:  La chiave (nome, corsodilaurea)=(Probabilità, Smid) è duplicata.

delete from corso
where id = '69' or id= '1234554321';
alter table corso
add unique (nome , corsodilaurea);

ALTER TABLE professori
DROP COLUMN incongedo;

ALTER TABLE professori
ADD CHECK (stipendio>0 and stipendio<10000000);

insert into corsi.professori values(12345,'scaletta','danieletto',1);
--ERROR: ERRORE:  un valore chiave duplicato viola il vincolo univoco "professori_pkey"
--DETAIL:  La chiave (id)=(12345) esiste già.
