DROP TABLE proiect_produse CASCADE CONSTRAINTS;
DROP TABLE proiect_clienti CASCADE CONSTRAINTS;
DROP TABLE proiect_facturi CASCADE CONSTRAINTS;
DROP TABLE proiect_functii CASCADE CONSTRAINTS;
DROP TABLE proiect_comenzi CASCADE CONSTRAINTS;
DROP TABLE proiect_furnizori CASCADE CONSTRAINTS;
DROP TABLE proiect_depozit CASCADE CONSTRAINTS;
DROP TABLE proiect_detalii_comenzi CASCADE CONSTRAINTS;
DROP TABLE proiect_angajati CASCADE CONSTRAINTS;

prompt
prompt Creating table proiect_produse
prompt ======================
prompt

CREATE TABLE proiect_produse(
Id_produs NUMBER(10) PRIMARY KEY,
Denumire_produs VARCHAR2(40) NOT NULL, 
Descriere_produs VARCHAR2(100),
Data_expirarii DATE
);

prompt
prompt Creating table proiect_clienti
prompt ======================
prompt

CREATE TABLE proiect_clienti(
Id_client NUMBER(10) PRIMARY KEY,
Nume_client VARCHAR2(40) NOT NULL,
Prenume_client VARCHAR2(30),
Data_nasterii DATE,
Telefon NUMBER(11),
Adresa VARCHAR2(40),
Email VARCHAR2(30) UNIQUE
);
ALTER TABLE proiect_clienti
MODIFY (Adresa VARCHAR2(100)); 

prompt
prompt Creating table proiect_functii
prompt ======================
prompt

CREATE TABLE proiect_functii(
Id_functie NUMBER(10) PRIMARY KEY,
Den_functie VARCHAR2(40) NOT NULL,
Salariul_minim NUMBER(4),
Salariul_maxim NUMBER(4)
);

prompt
prompt Creating table proiect_angajati
prompt ======================
prompt

CREATE TABLE proiect_angajati(
Id_angajat NUMBER(10) PRIMARY KEY,
Nume_angajat VARCHAR2(40) NOT NULL,
Prenume_angajat VARCHAR2(40),
Adresa VARCHAR2(30),
Telefon NUMBER(12),
Data_angajarii DATE,
Salariul NUMBER(4),
Id_functie NUMBER(10),
CONSTRAINT fk_angajat_functie FOREIGN KEY (Id_functie) REFERENCES proiect_functii (Id_functie)
);
ALTER TABLE proiect_angajati ADD (Comision NUMBER(3));
ALTER TABLE proiect_angajati
MODIFY (Adresa VARCHAR2(100)); 

prompt
prompt Creating table proiect_comenzi
prompt ======================
prompt

CREATE TABLE proiect_comenzi(
Id_comanda NUMBER(10) PRIMARY KEY,
Id_client NUMBER(10),
Data_comanda DATE,
Id_angajat NUMBER(10),
Metoda_plata VARCHAR2(20),
Stare_comanda VARCHAR2(20),
CONSTRAINT fk_comanda_angajat FOREIGN KEY (Id_angajat) REFERENCES proiect_angajati (Id_angajat),
CONSTRAINT fk_comanda_client FOREIGN KEY (Id_client) REFERENCES proiect_clienti (Id_client)
); 

prompt
prompt Creating table proiect_furnizori
prompt ======================
prompt

CREATE TABLE proiect_furnizori(
Id_furnizor NUMBER(10) PRIMARY KEY,
Denumire_furnizor VARCHAR2(30) NOT NULL,
Adresa VARCHAR2(30),
Cantitate NUMBER(3)
);
ALTER TABLE proiect_furnizori
MODIFY (Denumire_furnizor VARCHAR2(100));
ALTER TABLE proiect_furnizori
MODIFY (Adresa VARCHAR2(100)); 

prompt
prompt Creating table proiect_facturi
prompt ======================
prompt

CREATE TABLE proiect_facturi(
Numar_factura NUMBER(10) PRIMARY KEY,
Data_factura DATE,
Id_furnizor NUMBER(10),
CONSTRAINT fk_factura_furnizor FOREIGN KEY (Id_furnizor) REFERENCES proiect_furnizori (Id_furnizor)
); 

prompt
prompt Creating table proiect_detalii_comenzi
prompt ======================
prompt

CREATE TABLE proiect_detalii_comenzi(
Id_produs NUMBER(10),
Id_comanda NUMBER(10),
Pret NUMBER(4),
Cantitate NUMBER(4),
CONSTRAINT fk_detalii_comanda_produs FOREIGN KEY (Id_produs) REFERENCES proiect_produse (Id_produs),
CONSTRAINT fk_detalii_comanda_ FOREIGN KEY (Id_comanda) REFERENCES proiect_comenzi (Id_comanda)
);
ALTER TABLE proiect_detalii_comenzi
ADD CONSTRAINT pk_detalii_comanda PRIMARY KEY (Id_comanda, Id_produs);
ALTER TABLE proiect_detalii_comenzi
ADD CONSTRAINT Pret_NN
CHECK('Pret' IS NOT NULL); 

prompt
prompt Creating table proiect_depozit
prompt ======================
prompt

CREATE TABLE proiect_depozit(
Numar_depozit NUMBER(10) PRIMARY KEY,
Id_produs NUMBER(10),
Id_furnizor NUMBER(10),
Cantitate NUMBER(3),
CONSTRAINT fk_depozit_produs FOREIGN KEY (Id_produs) REFERENCES proiect_produse (Id_produs),
CONSTRAINT fk_depozit_furnizor FOREIGN KEY (Id_furnizor) REFERENCES proiect_furnizori (Id_furnizor)
); 

prompt Loading proiect_functii...

INSERT INTO proiect_functii (Id_functie, Den_functie, Salariul_minim,Salariul_maxim) 
VALUES ('1','Manager General', '6000','7000');
INSERT INTO proiect_functii (Id_functie, Den_functie, Salariul_minim,Salariul_maxim) 
VALUES ('2','Consultant de Vanzari', '4000','4500');
INSERT INTO proiect_functii (Id_functie, Den_functie, Salariul_minim,Salariul_maxim) 
VALUES ('3','Responsabil de Inventar', '4000','4300');
INSERT INTO proiect_functii (Id_functie, Den_functie, Salariul_minim,Salariul_maxim) 
VALUES ('4','Responsabil Marketing', '4600','5000');
INSERT INTO proiect_functii (Id_functie, Den_functie, Salariul_minim,Salariul_maxim) 
VALUES ('5','Casier', '4900','5300');
INSERT INTO proiect_functii (Id_functie, Den_functie, Salariul_minim,Salariul_maxim) 
VALUES ('6','Make-up Artist', '3000','3300');
INSERT INTO proiect_functii (Id_functie, Den_functie, Salariul_minim,Salariul_maxim) 
VALUES ('7','Responsabil Relatii cu Clientii', '4000','4200');
INSERT INTO proiect_functii (Id_functie, Den_functie, Salariul_minim,Salariul_maxim) 
VALUES ('8','Coordonator de Merchandising', '4700','5000');
INSERT INTO proiect_functii (Id_functie, Den_functie, Salariul_minim,Salariul_maxim) 
VALUES ('9','Specialist in Produse', '4900','5200');
INSERT INTO proiect_functii (Id_functie, Den_functie, Salariul_minim,Salariul_maxim) 
VALUES ('10','Administrator Platforma Online', '4400','4900');

prompt 10 records loaded
prompt Loading proiect_clienti...

INSERT INTO proiect_clienti (Id_client, Nume_client, Prenume_client, Data_nasterii, Telefon, Adresa, Email) 
VALUES ('1', 'Neagu', 'Raluca', to_date('15-03-1991', 'dd-mm-yyyy'), '0798887345', 'Str. Grivitei nr. 112, Sector 1, Bucuresti', 'neaguraluca@gmail.com'); 
INSERT INTO proiect_clienti (Id_client, Nume_client, Prenume_client, Data_nasterii, Telefon, Adresa, Email) 
VALUES ('2', 'Mihai', 'Radu', to_date('28-07-1992', 'dd-mm-yyyy'), '0721345678', 'Str. Basarabia nr. 75, Sector 2, Bucuresti', 'mihairadu@gmail.com'); 
INSERT INTO proiect_clienti (Id_client, Nume_client, Prenume_client, Data_nasterii, Telefon, Adresa, Email) 
VALUES ('3', 'Stanciu', 'Ana', to_date('01-07-2000', 'dd-mm-yyyy'), '0743567890', 'Str. Dealul Spirii nr. 45, Sector 5, Bucuresti', 'stanciuana@gmail.com'); 
INSERT INTO proiect_clienti (Id_client, Nume_client, Prenume_client, Data_nasterii, Telefon, Adresa, Email) 
VALUES ('4', 'Gheorghe', 'Adriana', to_date('20-12-1989', 'dd-mm-yyyy'), '0765123456', 'Str. Mosilor nr. 120, Sector 2, Bucuresti', 'gheorgheadriana@gmail.com'); 
INSERT INTO proiect_clienti (Id_client, Nume_client, Prenume_client, Data_nasterii, Telefon, Adresa, Email) 
VALUES ('5', 'Popa', 'Diana', to_date('09-04-1991', 'dd-mm-yyyy'), '0774789012', 'Str. Dristor nr. 34, Sector 3, Bucuresti', 'popadiana@gmail.com'); 
INSERT INTO proiect_clienti (Id_client, Nume_client, Prenume_client, Data_nasterii, Telefon, Adresa, Email) 
VALUES ('6', 'Marin', 'Alex', to_date('10-10-1990', 'dd-mm-yyyy'), '0732456789', 'Sos. Colentina nr. 290, Sector 2, Bucuresti', 'marinalex@gmail.com'); 
INSERT INTO proiect_clienti (Id_client, Nume_client, Prenume_client, Data_nasterii, Telefon, Adresa, Email) 
VALUES ('7', 'Ionescu', 'Mihaela', to_date('01-07-2018', 'dd-mm-yyyy'), '0789012345', 'Str. Pajurei nr. 58, Sector 1, Bucuresti', 'ionescumihaela@gmail.com'); 
INSERT INTO proiect_clienti (Id_client, Nume_client, Prenume_client, Data_nasterii, Telefon, Adresa, Email) 
VALUES ('8', 'Preda', 'Cosmina', to_date('16-03-2001', 'dd-mm-yyyy'), '0723678901', 'Str. Tineretului nr. 88, Sector 4, Bucuresti', 'predacosmina@gmail.com'); 
INSERT INTO proiect_clienti (Id_client, Nume_client, Prenume_client, Data_nasterii, Telefon, Adresa, Email) 
VALUES ('9', 'Munteanu', 'Larisa', to_date('23-08-2002', 'dd-mm-yyyy'), '0756234567', 'Str. Prelungirea Ghencea nr. 20, Sector 6, Bucuresti', 'munteanularisa@gmail.com'); 
INSERT INTO proiect_clienti (Id_client, Nume_client, Prenume_client, Data_nasterii, Telefon, Adresa, Email) 
VALUES ('10', 'Dinu', 'Bianca', to_date('22-04-1994', 'dd-mm-yyyy'), '0745890123', 'Str. Virtutii nr. 42, Sector 6, Bucuresti', 'dinubianca@gmail.com');

prompt 10 records loaded
prompt Loading proiect_produse...

INSERT INTO proiect_produse (Id_produs, Denumire_produs, Descriere_produs, Data_expirarii)
VALUES ('1', 'MAC Studio Fix Fluid Foundation', 'Fond de ten lichid cu acoperire completa si SPF 15', to_date('2025-08-12', 'yyyy-mm-dd'));
INSERT INTO proiect_produse (Id_produs, Denumire_produs, Descriere_produs, Data_expirarii)
VALUES ('2', 'NYX Soft Matte Lip Cream', 'Ruj lichid cu efect mat si textura catifelata', to_date('2025-12-10', 'yyyy-mm-dd'));
INSERT INTO proiect_produse (Id_produs, Denumire_produs, Descriere_produs, Data_expirarii)
VALUES ('3', 'Maybelline Fit Me Foundation', 'Fond de ten lichid cu acoperire naturala si SPF 18', to_date('2025-08-10', 'yyyy-mm-dd'));
INSERT INTO proiect_produse (Id_produs, Denumire_produs, Descriere_produs, Data_expirarii)
VALUES ('4', 'Catrice True Skin Concealer', 'Fond de ten lichid cu aspect mat', to_date('2025-10-10', 'yyyy-mm-dd'));
INSERT INTO proiect_produse (Id_produs, Denumire_produs, Descriere_produs, Data_expirarii)
VALUES ('5', 'Revolution Highlighter Reloaded', 'Iluminator compact, nuanta "Golden Lights"', to_date('2027-02-12', 'yyyy-mm-dd'));
INSERT INTO proiect_produse (Id_produs, Denumire_produs, Descriere_produs, Data_expirarii)
VALUES ('6', 'NYX Butter Gloss', 'Gloss de buze cu textura cremoasa, nuanta "Creme Brulee"', to_date('2026-07-01', 'yyyy-mm-dd'));
INSERT INTO proiect_produse (Id_produs, Denumire_produs, Descriere_produs, Data_expirarii)
VALUES ('7', 'NYX Epic Ink Liner', 'Tus lichid cu aplicator pensula, rezistent la apa', to_date('2026-05-10', 'yyyy-mm-dd'));
INSERT INTO proiect_produse (Id_produs, Denumire_produs, Descriere_produs, Data_expirarii)
VALUES ('8', 'Maybelline Superstay Powder', 'Pudra compacta rezistenta la transfer', to_date('2026-04-15', 'yyyy-mm-dd'));
INSERT INTO proiect_produse (Id_produs, Denumire_produs, Descriere_produs, Data_expirarii)
VALUES ('9', 'NYX Jumbo Eye Pencil', 'Creion de ochi multifunctional, nuanta "Milk"', to_date('2025-08-05', 'yyyy-mm-dd'));
INSERT INTO proiect_produse (Id_produs, Denumire_produs, Descriere_produs, Data_expirarii)
VALUES ('10', 'Revolution Reloaded Eyeshadow Palette', 'Paleta de farduri cu 15 nuante', to_date('2026-03-25', 'yyyy-mm-dd'));
INSERT INTO proiect_produse (Id_produs, Denumire_produs, Descriere_produs, Data_expirarii)
VALUES ('11', 'Sephora Cream Lip Stain', 'Ruj lichid rezistent, nuanta „Always Red”', to_date('2026-04-30', 'yyyy-mm-dd'));
INSERT INTO proiect_produse (Id_produs, Denumire_produs, Descriere_produs, Data_expirarii)
VALUES ('12', 'MAC Powder Kiss Lipstick', 'Ruj cu finish mat, nuanta „Devoted to Chili”', to_date('2025-12-05', 'yyyy-mm-dd'));
INSERT INTO proiect_produse (Id_produs, Denumire_produs, Descriere_produs, Data_expirarii)
VALUES ('13', 'Urban Decay Naked Heat Eyeshadow Palette', 'Paleta de farduri in tonuri calde', to_date('2026-02-22', 'yyyy-mm-dd'));
INSERT INTO proiect_produse (Id_produs, Denumire_produs, Descriere_produs, Data_expirarii)
VALUES ('14', 'Revlon Photoready Insta-Fix Stick', 'Fond de ten stick pentru aplicare rapida, nuanta „Medium Beige”', to_date('2026-05-15', 'yyyy-mm-dd'));
INSERT INTO proiect_produse (Id_produs, Denumire_produs, Descriere_produs, Data_expirarii)
VALUES ('15', 'Essence 8h Matte Liquid Lipstick', 'Ruj lichid mat cu rezistenta indelungata', to_date('2026-01-05', 'yyyy-mm-dd'));
INSERT INTO proiect_produse (Id_produs, Denumire_produs, Descriere_produs, Data_expirarii)
VALUES ('16', 'L Oréal Paris Infaillible Lipstick', 'Ruj lichid rezistent, nuanta rosu intens', to_date('2026-01-29', 'yyyy-mm-dd'));

prompt 16 records loaded
prompt Loading proiect_furnizori...

INSERT INTO proiect_furnizori (Id_furnizor, Denumire_furnizor, Adresa, Cantitate)
VALUES ('1', 'NYX Cosmetics Supply', 'Str. Aviatorilor 25, Bucuresti', '120');
INSERT INTO proiect_furnizori (Id_furnizor, Denumire_furnizor, Adresa, Cantitate)
VALUES ('2', 'MAC Supply Hub', 'Str. Mihai Bravu 22, Bucuresti', '110');
INSERT INTO proiect_furnizori (Id_furnizor, Denumire_furnizor, Adresa, Cantitate)
VALUES ('3', 'Revolution Beauty Export', 'Str. Colentina 78, Bucuresti', '150');
INSERT INTO proiect_furnizori (Id_furnizor, Denumire_furnizor, Adresa, Cantitate)
VALUES ('4', 'Sephora Central Warehouse', 'Bd. Tineretului 15, Bucuresti', '170');
INSERT INTO proiect_furnizori (Id_furnizor, Denumire_furnizor, Adresa, Cantitate)
VALUES ('5', 'Essence Europe Distribution', 'Sos. Pantelimon 300, Bucuresti', '120');
INSERT INTO proiect_furnizori (Id_furnizor, Denumire_furnizor, Adresa, Cantitate)
VALUES ('6', 'Maybelline Global Supply', 'Bd. Basarabia 120, Bucuresti', '200');
INSERT INTO proiect_furnizori (Id_furnizor, Denumire_furnizor, Adresa, Cantitate)
VALUES ('7', 'Catrice Beauty Hub', 'Str. Virtutii 88, Bucuresti', '400');
INSERT INTO proiect_furnizori (Id_furnizor, Denumire_furnizor, Adresa, Cantitate)
VALUES ('8', 'Revlon Distribution Network', 'Str. Dristor 35, Bucuresti', '130');
INSERT INTO proiect_furnizori (Id_furnizor, Denumire_furnizor, Adresa, Cantitate)
VALUES ('9', 'Urban Decay Logistics', 'Str. Grivitei 44, Bucuresti', '100');
INSERT INTO proiect_furnizori (Id_furnizor, Denumire_furnizor, Adresa, Cantitate)
VALUES ('10', 'L Oréal Distribution', 'Bd. Unirii 50, Bucuresti', '180');

prompt 10 records loaded
prompt Loading proiect_depozit...

INSERT INTO proiect_depozit (Numar_depozit, Id_produs, Id_furnizor, Cantitate) 
VALUES ('1', '2', '6', '100');
INSERT INTO proiect_depozit (Numar_depozit, Id_produs, Id_furnizor, Cantitate) 
VALUES ('2', '8', '6', '100');
INSERT INTO proiect_depozit (Numar_depozit, Id_produs, Id_furnizor, Cantitate) 
VALUES ('3', '7', '1', '70');
INSERT INTO proiect_depozit (Numar_depozit, Id_produs, Id_furnizor, Cantitate) 
VALUES ('4', '11', '4', '40');
INSERT INTO proiect_depozit (Numar_depozit, Id_produs, Id_furnizor, Cantitate) 
VALUES ('5', '16', '10', '180');
INSERT INTO proiect_depozit (Numar_depozit, Id_produs, Id_furnizor, Cantitate) 
VALUES ('6', '14', '8', '130');
INSERT INTO proiect_depozit (Numar_depozit, Id_produs, Id_furnizor, Cantitate) 
VALUES ('7', '15', '5', '120');
INSERT INTO proiect_depozit (Numar_depozit, Id_produs, Id_furnizor, Cantitate) 
VALUES ('8', '12', '2', '110');
INSERT INTO proiect_depozit (Numar_depozit, Id_produs, Id_furnizor, Cantitate) 
VALUES ('9', '4', '7', '900');
INSERT INTO proiect_depozit (Numar_depozit, Id_produs, Id_furnizor, Cantitate) 
VALUES ('10', '5', '3', '45');

prompt 10 records loaded
prompt Loading proiect_angajati...

INSERT INTO proiect_angajati (Id_angajat, Nume_angajat, Prenume_angajat, Adresa, Telefon, Data_angajarii, Salariul, Comision, Id_functie) 
VALUES ('1', 'Popescu','Alis','B-dul Unirii nr. 23, Sector 3, Bucuresti','0734567234', to_date('02-06-2018', 'dd-mm-yyyy'),'6500','10','1');
INSERT INTO proiect_angajati (Id_angajat, Nume_angajat, Prenume_angajat, Adresa, Telefon, Data_angajarii, Salariul, Comision, Id_functie) 
VALUES ('2', 'Popescu','Andrada','B-dul Unirii nr. 23, Sector 3, Bucuresti','0734605890', to_date('10-08-2018', 'dd-mm-yyyy'),'4700','0','4');
INSERT INTO proiect_angajati (Id_angajat, Nume_angajat, Prenume_angajat, Adresa, Telefon, Data_angajarii, Salariul, Comision, Id_functie) 
VALUES ('3', 'Andrei','Daria','Str. Aviatorilor nr. 68, Sector 1, Bucuresti','0756295234', to_date('20-09-2018', 'dd-mm-yyyy'),'4200','0','3');
INSERT INTO proiect_angajati (Id_angajat, Nume_angajat, Prenume_angajat, Adresa, Telefon, Data_angajarii, Salariul, Comision, Id_functie) 
VALUES ('4', 'Voicu','Alexandru','Calea Rahovei nr. 110, Sector 5, Bucuresti','0762389012', to_date('02-03-2019', 'dd-mm-yyyy'),'4700','3','10');
INSERT INTO proiect_angajati (Id_angajat, Nume_angajat, Prenume_angajat, Adresa, Telefon, Data_angajarii, Salariul, Comision, Id_functie) 
VALUES ('5', 'Popiliu','Alexa','Str. Izvor nr. 45, Sector 5, Bucuresti','0721098567', to_date('01-03-2019', 'dd-mm-yyyy'),'4200','0','2');
INSERT INTO proiect_angajati (Id_angajat, Nume_angajat, Prenume_angajat, Adresa, Telefon, Data_angajarii, Salariul, Comision, Id_functie) 
VALUES ('6', 'Dima','Mihai','Str. Vasile Lascar nr. 98, Sector 2, Bucuresti','0724561970', to_date('08-06-2020', 'dd-mm-yyyy'),'4700','5','8');
INSERT INTO proiect_angajati (Id_angajat, Nume_angajat, Prenume_angajat, Adresa, Telefon, Data_angajarii, Salariul, Comision, Id_functie) 
VALUES ('7', 'Minea','Alina','Sos. Pantelimon nr. 301, Sector 2, Bucuresti','0746098097', to_date('01-04-2021', 'dd-mm-yyyy'),'4200','10','7');
INSERT INTO proiect_angajati (Id_angajat, Nume_angajat, Prenume_angajat, Adresa, Telefon, Data_angajarii, Salariul, Comision, Id_functie) 
VALUES ('8', 'Croitoru','Adina','Str. Drumul Taberei nr. 210, Sector 6, Bucuresti','0746098091', to_date('27-11-2020', 'dd-mm-yyyy'),'3300','12','6');
INSERT INTO proiect_angajati (Id_angajat, Nume_angajat, Prenume_angajat, Adresa, Telefon, Data_angajarii, Salariul, Comision, Id_functie) 
VALUES ('9', 'Vasile','Sara','Str. Mihai Eminescu nr. 12, Sector 1, Bucuresti','0720765432', to_date('01-07-2018', 'dd-mm-yyyy'),'5300','20','5');
INSERT INTO proiect_angajati (Id_angajat, Nume_angajat, Prenume_angajat, Adresa, Telefon, Data_angajarii, Salariul, Comision, Id_functie) 
VALUES ('10', 'Voiculescu','Stefania','Str. Lacramioarei nr. 15, Sector 2, Bucuresti','0745012321', to_date('02-02-2020', 'dd-mm-yyyy'),'5000','0','9');

prompt 10 records loaded

prompt Loading proiect_comenzi...

INSERT INTO proiect_comenzi (Id_comanda, Id_client, Data_comanda, Id_angajat, Metoda_plata, Stare_comanda)
VALUES ('1', '10', to_date('12-12-2023', 'dd-mm-yyyy'), '9', 'card', 'in curs'); 
INSERT INTO proiect_comenzi (Id_comanda, Id_client, Data_comanda, Id_angajat, Metoda_plata, Stare_comanda)
VALUES ('2', '2', to_date('10-12-2023', 'dd-mm-yyyy'), '9', 'card', 'livrat'); 
INSERT INTO proiect_comenzi (Id_comanda, Id_client, Data_comanda, Id_angajat, Metoda_plata, Stare_comanda)
VALUES ('3', '2', to_date('02-07-2022', 'dd-mm-yyyy'), '9', 'card', 'livrat'); 
INSERT INTO proiect_comenzi (Id_comanda, Id_client, Data_comanda, Id_angajat, Metoda_plata, Stare_comanda)
VALUES ('4', '5', to_date('20-12-2023', 'dd-mm-yyyy'), '9', 'cash', 'in curs'); 
INSERT INTO proiect_comenzi (Id_comanda, Id_client, Data_comanda, Id_angajat, Metoda_plata, Stare_comanda)
VALUES ('5', '4', to_date('29-11-2023', 'dd-mm-yyyy'), '9', 'card', 'in curs'); 
INSERT INTO proiect_comenzi (Id_comanda, Id_client, Data_comanda, Id_angajat, Metoda_plata, Stare_comanda)
VALUES ('6', '8', to_date('03-08-2021', 'dd-mm-yyyy'), '9', 'card', 'livrat'); 
INSERT INTO proiect_comenzi (Id_comanda, Id_client, Data_comanda, Id_angajat, Metoda_plata, Stare_comanda)
VALUES ('7', '3', to_date('20-10-2023', 'dd-mm-yyyy'), '9', 'cash', 'livrat'); 
INSERT INTO proiect_comenzi (Id_comanda, Id_client, Data_comanda, Id_angajat, Metoda_plata, Stare_comanda)
VALUES ('8', '1', to_date('28-06-2022', 'dd-mm-yyyy'), '9', 'cash', 'livrat'); 
INSERT INTO proiect_comenzi (Id_comanda, Id_client, Data_comanda, Id_angajat, Metoda_plata, Stare_comanda)
VALUES ('9', '9', to_date('09-12-2023', 'dd-mm-yyyy'), '9', 'card', 'in curs'); 
INSERT INTO proiect_comenzi (Id_comanda, Id_client, Data_comanda, Id_angajat, Metoda_plata, Stare_comanda)
VALUES ('10', '9', to_date('19-08-2023', 'dd-mm-yyyy'), '9', 'card', 'livrat');

prompt 10 records loaded
prompt Loading proiect_facturi...

INSERT INTO proiect_facturi (Numar_factura, Data_factura, Id_furnizor) 
VALUES ('1', to_date('11-02-2022', 'dd-mm-yyyy'), '6');
INSERT INTO proiect_facturi (Numar_factura, Data_factura, Id_furnizor) 
VALUES ('2', to_date('23-09-2023', 'dd-mm-yyyy'), '4');
INSERT INTO proiect_facturi (Numar_factura, Data_factura, Id_furnizor) 
VALUES ('3', to_date('02-05-2023', 'dd-mm-yyyy'), '10');
INSERT INTO proiect_facturi (Numar_factura, Data_factura, Id_furnizor) 
VALUES ('4', to_date('19-11-2022', 'dd-mm-yyyy'), '8');
INSERT INTO proiect_facturi (Numar_factura, Data_factura, Id_furnizor) 
VALUES ('5', to_date('26-02-2023', 'dd-mm-yyyy'), '2');
INSERT INTO proiect_facturi (Numar_factura, Data_factura, Id_furnizor) 
VALUES ('6', to_date('21-07-2023', 'dd-mm-yyyy'), '1');
INSERT INTO proiect_facturi (Numar_factura, Data_factura, Id_furnizor) 
VALUES ('7', to_date('06-06-2023', 'dd-mm-yyyy'), '9');
INSERT INTO proiect_facturi (Numar_factura, Data_factura, Id_furnizor) 
VALUES ('8', to_date('17-08-2023', 'dd-mm-yyyy'), '7');
INSERT INTO proiect_facturi (Numar_factura, Data_factura, Id_furnizor) 
VALUES ('9', to_date('25-04-2022', 'dd-mm-yyyy'), '5');
INSERT INTO proiect_facturi (Numar_factura, Data_factura, Id_furnizor) 
VALUES ('10', to_date('10-09-2022', 'dd-mm-yyyy'), '3');

prompt 10 records loaded
prompt Loading proiect_detalii_comenzi...

INSERT INTO proiect_detalii_comenzi (Id_produs, Id_comanda, Pret, Cantitate)
VALUES ('11', '1', '70', '2');
INSERT INTO proiect_detalii_comenzi (Id_produs, Id_comanda, Pret, Cantitate)
VALUES ('8', '2', '58', '4');
INSERT INTO proiect_detalii_comenzi (Id_produs, Id_comanda, Pret, Cantitate)
VALUES ('2', '3', '42', '5');
INSERT INTO proiect_detalii_comenzi (Id_produs, Id_comanda, Pret, Cantitate)
VALUES ('9', '4', '36', '1');
INSERT INTO proiect_detalii_comenzi (Id_produs, Id_comanda, Pret, Cantitate)
VALUES ('1', '5', '33', '2');
INSERT INTO proiect_detalii_comenzi (Id_produs, Id_comanda, Pret, Cantitate)
VALUES ('10', '6', '27', '7');
INSERT INTO proiect_detalii_comenzi (Id_produs, Id_comanda, Pret, Cantitate)
VALUES ('7', '7', '43', '1');
INSERT INTO proiect_detalii_comenzi (Id_produs, Id_comanda, Pret, Cantitate)
VALUES ('7', '8', '43', '2');
INSERT INTO proiect_detalii_comenzi (Id_produs, Id_comanda, Pret, Cantitate)
VALUES ('12', '9', '102', '2');
INSERT INTO proiect_detalii_comenzi (Id_produs, Id_comanda, Pret, Cantitate)
VALUES ('4', '10', '20', '4');

prompt 10 records loaded
prompt Done

prompt
prompt PL/SQL blocks
prompt ======================
prompt

--1.    Sa se construiasca un bloc PL/SQL care sa verifice starea unei comenzi plasate de catre clienti.
SET SERVEROUTPUT ON
DECLARE
    v_id proiect_comenzi.id_comanda%TYPE := &id;
    v_stare proiect_comenzi.stare_comanda%TYPE;
BEGIN
    SELECT stare_comanda 
    INTO v_stare
    FROM proiect_comenzi
    WHERE id_comanda = v_id;
    
    IF v_stare = 'in curs' THEN
        DBMS_OUTPUT.PUT_LINE('Comanda ' || v_id || ' este in procesare.');
    ELSIF v_stare = 'livrat' THEN
        DBMS_OUTPUT.PUT_LINE('Comanda ' || v_id || ' a fost livrata.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Comanda ' || v_id || ' are stare necunoscuta.');
    END IF;
END;
/

--2.     Sa se construiasca un bloc PL/SQL care sa parcurga clientii care au id-uri de la 1 la 10, folosind structura FOR-LOOP.
DECLARE
    v_prenume proiect_clienti.prenume_client%TYPE;
    v_data proiect_clienti.data_nasterii%TYPE;
BEGIN
   FOR i IN 1..10 LOOP
    SELECT prenume_client, data_nasterii
    INTO v_prenume, v_data
    FROM proiect_clienti
    WHERE id_client = i;
    
    DBMS_OUTPUT.PUT_LINE(i || ' ' || v_prenume || ' ' || v_data);
    END LOOP;
END;
/

--3.    Sa se construiasca un bloc PL/SQL care sa parcurga toti angajatii, afisand numele, salariul si vechimea, folosind structura LOOP-EXIT WHEN.
DECLARE
    v_nume proiect_angajati.nume_angajat%TYPE;
    v_sal proiect_angajati.salariul%TYPE;
    v_vechime NUMBER(4,2);
    i NUMBER := 1;
    v_min NUMBER;
    v_max NUMBER;
BEGIN
    SELECT MIN(id_angajat), MAX(id_angajat)
    INTO v_min, v_max
    FROM proiect_angajati;
    i := v_min;
    LOOP
        SELECT nume_angajat, salariul, (SYSDATE - data_angajarii)/365
        INTO v_nume, v_sal, v_vechime
        FROM proiect_angajati
        WHERE id_angajat = i;

        DBMS_OUTPUT.PUT_LINE(i || ' ' || v_nume || ' ' || v_sal || ' ' || v_vechime);
    i := i + 1;
    EXIT WHEN i > v_max;
    END LOOP;
END;
/

--4.    Sa se construiasca un bloc PL/SQL care sa afiseze produsele si data expirarii pentru produsele cu id-ul intre 1 si 10, folosind structura WHILE-LOOP.
DECLARE
    v_denumire proiect_produse.denumire_produs%TYPE;
    v_data proiect_produse.data_expirarii%TYPE;
    i proiect_produse.id_produs%TYPE := 1;
BEGIN
   WHILE i <= 10 LOOP
    SELECT denumire_produs, data_expirarii
    INTO v_denumire, v_data
    FROM proiect_produse
    WHERE id_produs = i;
    
    DBMS_OUTPUT.PUT_LINE('Produsul ' || v_denumire || ' expira la data de ' ||v_data);
    i := i + 1;
    END LOOP;
END;
/

--5.    Sa se construiasca un bloc PL/SQL prin care sa se afiseze primele 5 produse cu cel mai mare pret.
DECLARE
  CURSOR c IS
    SELECT denumire_produs, pret
    FROM proiect_produse JOIN proiect_detalii_comenzi USING (id_produs)
    ORDER BY pret DESC
    FETCH FIRST 5 ROWS ONLY; 
  v c%ROWTYPE;
BEGIN
  OPEN c;
  LOOP
    FETCH c INTO v;
    EXIT WHEN c%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v.denumire_produs || ' ' || v.pret);
  END LOOP;
  CLOSE c;
END;
/

--6.     Sa se construiasca un bloc PL/SQL prin care sa se afiseze pentru fiecare client numele complet, numarul de telefon si valoarea comenzii ordonata descrescator.
DECLARE
    CURSOR c IS SELECT c.nume_client || ' ' || c.prenume_client AS nume_complet, c.telefon, co.id_comanda, SUM(dc.pret * dc.cantitate) AS valoare
                FROM proiect_clienti c, proiect_detalii_comenzi dc, proiect_comenzi co
                WHERE c.id_client = co.id_client AND dc.id_comanda = co.id_comanda
                GROUP BY c.nume_client, c.prenume_client, c.telefon, co.id_comanda
                ORDER BY valoare DESC;
BEGIN
    FOR v IN c LOOP
        DBMS_OUTPUT.PUT_LINE(v.nume_complet || ' ' || v.telefon || ' ' || v.valoare);
    END LOOP;
END;
/

--7.    Sa se construiasca un bloc PL/SQL prin care sa se afiseze numele complet si numarul de comenzi intermediate de angajati.
DECLARE
    CURSOR c IS SELECT nume_angajat || ' ' || prenume_angajat AS nume_complet, salariul, COUNT(id_comanda) numar
                FROM proiect_comenzi JOIN proiect_angajati USING (id_angajat)
                GROUP BY nume_angajat, prenume_angajat, salariul;
    v c%ROWTYPE;
BEGIN
    OPEN c;
    LOOP
        FETCH c INTO v;
        EXIT WHEN c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v.nume_complet ||' '|| v.numar);
    END LOOP;
    CLOSE c; 
END;
/

--8.    Sa se construiasca un bloc PL/SQL prin care sa se afiseze toate produsele din comenzi, pretul si cantitatea acestora.
DECLARE
    id proiect_detalii_comenzi.id_comanda%TYPE := &id;
    CURSOR c IS SELECT proiect_detalii_comenzi.id_comanda, proiect_produse.denumire_produs, proiect_detalii_comenzi.pret, proiect_detalii_comenzi.cantitate
                FROM proiect_produse JOIN proiect_detalii_comenzi USING (id_produs) 
                WHERE proiect_detalii_comenzi.id_comanda = id;
BEGIN
   FOR v IN c LOOP
        DBMS_OUTPUT.PUT_LINE(v.id_comanda || ' ' || v.denumire_produs || ' ' || v.pret || ' ' || v.cantitate);
    END LOOP;
END;
/

--9.    Sa se construiasca un bloc PL/SQL, folosind un cursor explicit cu parametri pentru a afisa comenzile unui client, data efectuarii comenzii, cat si metoda de plata.
DECLARE
  CURSOR c(p_id_client NUMBER) IS
    SELECT id_comanda, nume_client || ' ' || prenume_client AS nume_complet, data_comanda, metoda_plata
    FROM proiect_comenzi JOIN proiect_clienti USING (id_client)
    WHERE id_client = p_id_client;
  v c%ROWTYPE;
  v_id_client NUMBER := 8; 
BEGIN
  OPEN c(v_id_client);
  LOOP
    FETCH c INTO v;
    EXIT WHEN c%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Nume client: ' || v.nume_complet || ' | nr comanda: ' || v.id_comanda || ' | data: ' || v.data_comanda || ' | metoda plata: ' || v.metoda_plata);
  END LOOP;
  CLOSE c;
END;
/

--10.   Sa se creeze un bloc PL/SQL care sa afiseze descrierea unui produs al carui id este introdus de la tastatura.
--      -daca interogarea nu returneaza nicio valoare, sa se trateze exceptia cu o rutina de tratare corespunzatoare si sa se afiseze mesajul “Produsul nu exista”
--      -sa se trateze orice alta exceptie cu o rutina de tratare corespunzatoare si sa se afiseze mesajul “Eroare”
DECLARE
    v_id proiect_produse.id_produs%TYPE := &a;
    v_descriere proiect_produse.descriere_produs%TYPE;
BEGIN
    SELECT descriere_produs
    INTO v_descriere
    FROM proiect_produse
    WHERE id_produs = v_id;
 
    DBMS_OUTPUT.PUT_LINE('Descrierea produsului ' || v_id || ': ' || v_descriere);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Produsul nu exista');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare');
END;
/

--11.   Sa se creeze un bloc PL/SQL care sa verifice daca o comanda poate fi plasata si in cazul in care stocul este disponibil, sa se afiseze id-ul produsului si cantitatea comandata
--      -id-ul produsului si cantitatea comandata vor fi introduse de la tastatura
--      -in cazul in care produsul nu exista, se va trata exceptia corespunzatoare, iar daca stocul este insufficient, se va invoca o exceptie tratata printr-un mesaj corespunzator
DECLARE
    v_id_produs proiect_produse.id_produs%TYPE := &id;
    v_stoc proiect_depozit.cantitate%TYPE;
    v_cantitate_comandata NUMBER := &cant;
    stoc_insuficient EXCEPTION;
BEGIN
    SELECT cantitate 
    INTO v_stoc
    FROM proiect_depozit
    WHERE id_produs = v_id_produs;
    
    IF v_stoc < v_cantitate_comandata THEN
        RAISE stoc_insuficient;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Comanda a fost procesata cu succes. ' || 'Produsul comandat ' || v_id_produs || ' | cantitatea ' || v_cantitate_comandata);
EXCEPTION
    WHEN stoc_insuficient THEN
        DBMS_OUTPUT.PUT_LINE('Stoc insuficient pentru produsul ' || v_id_produs);
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Produsul nu a fost gasit');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare');
END;
/

--12.   Sa se creeze un bloc PL/SQL care sa modifice salariul unui angajat al carui id este citit de la tastatura.

DECLARE
    v_id proiect_angajati.id_angajat%TYPE := &id;
    angajat_inexistent EXCEPTION;
BEGIN
    UPDATE proiect_angajati
    SET salariul = salariul + comision/100 * salariul
    WHERE id_angajat = v_id;

    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Salariul angajatului ' || v_id || ' a fost actualizat');
    ELSE
        RAISE angajat_inexistent;
    END IF;
EXCEPTION
   WHEN angajat_inexistent THEN 
    DBMS_OUTPUT.PUT_LINE('Angajatul nu exista');
END;
/

--13.   Sa se creeze un bloc PL/SQL care sa mareasca cu 20% salariul unui angajat a carui functie este citita de la tastatura si sa se afiseze numele complet, functia si salariul angajatului respectiv.
DECLARE
    v_id proiect_functii.id_functie%TYPE := &id;
    v_nume VARCHAR2(100);
    v_functie proiect_functii.den_functie%TYPE;
    v_sal proiect_angajati.salariul%TYPE;
    nu_exista_functia EXCEPTION;
BEGIN
    UPDATE proiect_angajati
    SET salariul = salariul + salariul * 0.2
    WHERE id_functie = v_id;
    
    SELECT nume_angajat || ' ' || prenume_angajat AS nume_complet, den_functie, salariul
    INTO v_nume, v_functie, v_sal
    FROM proiect_angajati JOIN proiect_functii USING (id_functie)
    WHERE id_functie = v_id;
    
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE(v_nume || ' ' || v_functie || ' ' || v_sal);
    ELSE
        RAISE nu_exista_functia;
    END IF;
EXCEPTION
   WHEN nu_exista_functia THEN 
    DBMS_OUTPUT.PUT_LINE('Functia nu exista');
END;
/

--14.   Construiti procedura Detalii_client care sa afiseze informatii despre client si comenzile plasate de catre acesta.
CREATE OR REPLACE PROCEDURE Detalii_client(p_id_client IN NUMBER) IS
    v_nume VARCHAR2(100);
    v_email VARCHAR2(50);
    v_telefon VARCHAR2(20);

    CURSOR c IS SELECT id_comanda, data_comanda, stare_comanda
                FROM proiect_comenzi
                WHERE id_client = p_id_client;
BEGIN
    SELECT nume_client || ' ' || prenume_client, email, telefon
    INTO v_nume, v_email, v_telefon
    FROM proiect_clienti
    WHERE id_client = p_id_client;

    DBMS_OUTPUT.PUT_LINE('Client: ' || v_nume);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_email || ' | Telefon: ' || v_telefon);
    DBMS_OUTPUT.PUT_LINE('Comenzile plasate ale clientului:');

    FOR v IN c LOOP
        DBMS_OUTPUT.PUT_LINE(' - Comanda ID: ' || v.id_comanda ||', Data: ' || TO_CHAR(v.data_comanda, 'DD-MM-YYYY') ||', Status: ' || v.stare_comanda);
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Clientul nu a fost gasit.');
END;
/

--apel
BEGIN
    Detalii_client(8);
END;
/

--15.   Construiti procedura furnizori_produse care sa afiseze cate produse sunt asigurate de fiecare furnizor.
CREATE OR REPLACE PROCEDURE furnizori_produse IS
    CURSOR c IS SELECT id_furnizor, denumire_furnizor
                FROM proiect_furnizori;

    v_nr_produse NUMBER;
BEGIN
    FOR v IN c LOOP
        SELECT COUNT(*) INTO v_nr_produse
        FROM proiect_depozit
        WHERE id_furnizor = v.id_furnizor;

        DBMS_OUTPUT.PUT_LINE('Furnizor: ' || v.denumire_furnizor || ' - ' || v_nr_produse || ' produse');
    END LOOP;
END;
/

BEGIN
    furnizori_produse;
END;
/

--16.   Construiti procedura actualizeaza_stocuri care sa afiseze stocurile actualizate dupa vanzare.
CREATE OR REPLACE PROCEDURE actualizeaza_stocuri IS
    CURSOR c IS SELECT id_produs, cantitate FROM proiect_detalii_comenzi;
BEGIN
    FOR v IN c LOOP
        UPDATE proiect_depozit
        SET cantitate = cantitate - v.cantitate
        WHERE id_produs = v.id_produs;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Stocurile au fost actualizate.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Eroare la actualizare stocuri: ' || SQLERRM);
END;
/

--apel
BEGIN
    actualizeaza_stocuri;
END;
/

--17.   Construiti procedura produse_stoc_limita care sa afiseze produsele al caror stoc este mai mic decat limita impusa.
CREATE OR REPLACE PROCEDURE produse_stoc_limita (p_limita IN NUMBER) IS
    CURSOR c IS SELECT id_produs, denumire_produs, cantitate
                        FROM proiect_produse JOIN proiect_depozit USING (id_produs)
                        WHERE cantitate < p_limita;

    v_count NUMBER := 0;
BEGIN
    FOR p IN c LOOP
        DBMS_OUTPUT.PUT_LINE('Produs: ' || p.denumire_produs || ' | Stoc: ' || p.cantitate);
        v_count := v_count + 1;
    END LOOP;

    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Toate produsele au stoc suficient.');
    END IF;
END;
/

BEGIN
    produse_stoc_limita(100);
END;
/

--18.   Creati functia Calcul_vechime care sa returneze vechimea angajatului al carui id este dat ca parametru de intrare. Tratati cazul in care angajatul indicat nu exista.
CREATE OR REPLACE FUNCTION Calcul_vechime (p_id proiect_angajati.id_angajat%TYPE)
RETURN NUMBER
AS
    v_vechime NUMBER;
BEGIN
    SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, data_angajarii) / 12)
    INTO v_vechime
    FROM proiect_angajati
    WHERE id_angajat = p_id;
    RETURN v_vechime;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN NULL;
END;
/

--apel
DECLARE
    vechime NUMBER;
BEGIN 
    vechime := Calcul_vechime(7);
    IF vechime IS NULL
    THEN DBMS_OUTPUT.PUT_LINE('Angajatul nu exista');
    ELSE DBMS_OUTPUT.PUT_LINE(vechime);
    END IF;
    DBMS_OUTPUT.PUT_LINE(vechime);
END;
/

--19.   Creati functia numar_comenzi_client care sa returneze numarul de comenzi plasate de un client al carui id este dat ca parametru de intrare. Tratati cazul in care clientul nu exista.
CREATE OR REPLACE FUNCTION numar_comenzi_client (p_id proiect_clienti.id_client%TYPE)
RETURN NUMBER
AS
    v_nr NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_nr
    FROM proiect_comenzi
    WHERE id_client = p_id;
    
    RETURN v_nr;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN NULL;
END;
/

DECLARE
    numar_comenzi NUMBER;
BEGIN 
    numar_comenzi := numar_comenzi_client(2);
    IF numar_comenzi IS NULL
    THEN DBMS_OUTPUT.PUT_LINE('Clientul nu exista');
    ELSE DBMS_OUTPUT.PUT_LINE(numar_comenzi);
    END IF;
    DBMS_OUTPUT.PUT_LINE('Clientul a plasat ' || numar_comenzi || ' comenzi.');
END;
/

--20.   Creati o functie care sa returneze salariul anual al unui angajat al carui id este dat ca parametru de intrare.
CREATE OR REPLACE FUNCTION salariul_anual (p_id proiect_angajati.id_angajat%TYPE)
RETURN NUMBER
AS
    v_sal NUMBER;
BEGIN
    SELECT salariul * 12 + salariul * comision * 12
    INTO v_sal
    FROM proiect_angajati
    WHERE id_angajat = p_id;
    
    RETURN v_sal;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN NULL;
END;
/

DECLARE
    salariu NUMBER;
BEGIN 
    salariu := salariul_anual(3);
    IF salariu IS NULL
    THEN DBMS_OUTPUT.PUT_LINE('Angajatul nu exista');
    ELSE DBMS_OUTPUT.PUT_LINE(salariu);
    END IF;
    DBMS_OUTPUT.PUT_LINE('Salariul anual al angajatului este ' || salariu);
END;
/

--21.   Creati o functie care sa returneze valoarea totala a unei comenzi (id-ul comenzii este dat ca parametru de intrare).
CREATE OR REPLACE FUNCTION valoare_comanda (p_id proiect_detalii_comenzi.id_comanda%TYPE)
RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    SELECT SUM(cantitate * pret)
    INTO v_total
    FROM proiect_detalii_comenzi
    WHERE id_comanda = p_id;
    RETURN v_total;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN NULL;
END;
/

DECLARE
    total NUMBER;
BEGIN 
    total := valoare_comanda(9);
    IF total IS NULL
    THEN DBMS_OUTPUT.PUT_LINE('Comanda nu exista');
    ELSE DBMS_OUTPUT.PUT_LINE('Totalul comenzii este ' || total);
    END IF;
END;
/

--22.   Sa se creeze un trigger prin intermediul caruia sa se impiedice atribuirea unui salariu negativ.
CREATE OR REPLACE TRIGGER sal_ang
BEFORE INSERT OR UPDATE OF salariul ON proiect_angajati
FOR EACH ROW
BEGIN
   IF :NEW.salariul <= 0 THEN
       RAISE_APPLICATION_ERROR(-20000, 'Salariul trebuie sa fie pozitiv'); 
    END IF;
END;
/

INSERT INTO proiect_angajati (Id_angajat, Nume_angajat, Prenume_angajat, Adresa, Telefon, Data_angajarii, Salariul, Comision, Id_functie) 
VALUES ('11', 'Dima','Angela','Str. Mihai Eminescu nr. 6, Bucuresti','0720766721', to_date('01-11-2018', 'dd-mm-yyyy'),'5300','10','10');

--23.   Sa se creeze un trigger care sa verifice inaintea plasarii unei noi comenzi daca stocul din depozit al unui produs acopera cantitatea comandata.
CREATE OR REPLACE TRIGGER detalii_stoc_produs
BEFORE INSERT OR UPDATE ON proiect_detalii_comenzi
FOR EACH ROW
DECLARE
    v_stoc proiect_depozit.cantitate%TYPE;
BEGIN
    SELECT cantitate INTO v_stoc
    FROM proiect_depozit
    WHERE id_produs = :NEW.id_produs;
    
    IF :NEW.cantitate > v_stoc THEN
        RAISE_APPLICATION_ERROR(-20006, 'Cantitatea comandata depaseste stocul disponbil');
    END IF;
END;
/

INSERT INTO proiect_detalii_comenzi
VALUES('11', '1', '12', '100');

--24.   Sa se creeze un trigger care verifica daca email-ul unui angajat nou introdus se afla deja in baza de date sau daca acesta a fost introdus la completarea informatiilor de catre client, fiind un camp obligatoriu.
CREATE OR REPLACE TRIGGER clienti_email
BEFORE INSERT OR UPDATE OF email ON proiect_clienti
FOR EACH ROW
DECLARE
    v_nr NUMBER;
BEGIN
    IF :NEW.email IS NULL THEN
        RAISE_APPLICATION_ERROR(-20010,'Email obligatoriu!');
    END IF;

    SELECT COUNT(*)
    INTO v_nr
    FROM proiect_clienti
    WHERE email = :NEW.email
      AND id_client <> NVL(:NEW.id_client, -1);

    IF v_nr > 0 THEN
        RAISE_APPLICATION_ERROR(-20011,'Email deja existent! Incercati alt email');
    END IF;
END;
/
INSERT INTO proiect_clienti (Id_client, Nume_client, Prenume_client, Data_nasterii, Telefon, Adresa, Email) 
VALUES ('11', 'Neagu', 'Romina', to_date('15-07-1998', 'dd-mm-yyyy'), '0797567345', 'Str. Grivitei nr. 12, Bucuresti', 'neaguromina@gmail.com');


