# Gestiunea-unui-magazin-de-produse-cosmetice
 <h1 align="center">💄 Bază de Date – Magazin Produse Cosmetice</h1>

<p align="center">
  Sistem pentru gestionarea unui magazin de produse cosmetice 🛍️  
  Include administrarea produselor, clienților, comenzilor și stocurilor.
</p>

---

## 📌 Descriere Generală

Această bază de date este proiectată pentru a gestiona eficient activitățile unui magazin de produse cosmetice, incluzând:

- 🧴 Produse
- 👥 Clienți
- 👨‍💼 Angajați
- 🚚 Furnizori
- 📦 Comenzi
- 📄 Facturi
- 🏬 Depozit (stocuri)

---

## 🧴 Tabela: PRODUSE

| Atribut            | Tip de Date        | Descriere                  |
|--------------------|------------------|---------------------------|
| id_produs          | Numeric (PK)     | Identificator unic produs |
| denumire_produs    | VARCHAR(40)      | Numele produsului         |
| descriere_produs   | VARCHAR(100)     | Descriere produs          |
| data_expirarii     | DATE             | Data expirării            |

---

## 👨‍💼 Tabela: ANGAJATI

| Atribut          | Tip de Date        | Descriere                  |
|------------------|------------------|---------------------------|
| id_angajat       | Numeric (PK)     | ID angajat                |
| nume_angajat     | VARCHAR(40)      | Nume                      |
| prenume_angajat  | VARCHAR(40)      | Prenume                   |
| adresa           | VARCHAR(100)     | Adresă                    |
| telefon          | Numeric(12)      | Telefon                   |
| data_angajarii   | DATE             | Data angajării            |
| salariul         | Numeric(4)       | Salariu                   |
| id_functie       | Numeric (FK)     | Legătură cu FUNCTII       |
| comision         | Numeric          | Comision                  |

---

## 👥 Tabela: CLIENTI

| Atribut          | Tip de Date   | Descriere            |
|------------------|--------------|---------------------|
| id_client        | Numeric (PK) | ID client           |
| nume_client      | VARCHAR(40)  | Nume                |
| prenume_client   | VARCHAR(30)  | Prenume             |
| data_nasterii    | DATE         | Data nașterii       |
| telefon          | Numeric      | Telefon             |
| adresa           | VARCHAR(100) | Adresă              |
| email            | VARCHAR(30)  | Email               |

---

## 📦 Tabela: COMENZI

| Atribut        | Tip de Date   | Descriere                |
|----------------|--------------|-------------------------|
| id_comanda     | Numeric (PK) | ID comandă              |
| id_client      | Numeric (FK) | Client                  |
| data_comanda   | DATE         | Data comenzii           |
| id_angajat     | Numeric (FK) | Angajat responsabil     |
| metoda_plata   | VARCHAR(20)  | Metodă plată            |
| stare_comanda  | VARCHAR(20)  | Status comandă          |

---

## 🏬 Tabela: DEPOZIT

| Atribut        | Tip de Date   | Descriere                |
|----------------|--------------|-------------------------|
| numar_depozit  | Numeric (PK) | ID depozit              |
| id_produs      | Numeric (FK) | Produs                  |
| id_furnizor    | Numeric (FK) | Furnizor                |
| cantitate      | Numeric      | Cantitate disponibilă   |

---

## 🧾 Tabela: DETALII_COMENZI

| Atribut     | Tip de Date   | Descriere        |
|-------------|--------------|------------------|
| id_produs   | Numeric (FK) | Produs           |
| id_comanda  | Numeric (FK) | Comandă          |
| pret        | Numeric      | Preț             |
| cantitate   | Numeric      | Cantitate        |

---

## 📄 Tabela: FACTURI

| Atribut        | Tip de Date   | Descriere      |
|----------------|--------------|---------------|
| numar_factura  | Numeric (PK) | Număr factură |
| data_factura   | DATE         | Data facturii |
| id_furnizor    | Numeric (FK) | Furnizor      |

---

## 🧑‍💼 Tabela: FUNCTII

| Atribut         | Tip de Date   | Descriere          |
|-----------------|--------------|-------------------|
| id_functie      | Numeric (PK) | ID funcție        |
| den_functie     | VARCHAR(40)  | Denumire funcție  |
| salariul_minim  | Numeric      | Salariu minim     |
| salariul_maxim  | Numeric      | Salariu maxim     |

---

## 🚚 Tabela: FURNIZORI

| Atribut              | Tip de Date   | Descriere        |
|----------------------|--------------|------------------|
| id_furnizor          | Numeric (PK) | ID furnizor      |
| denumire_furnizor    | VARCHAR(100) | Nume furnizor    |
| adresa               | VARCHAR(100) | Adresă           |
| cantitate            | Numeric      | Cantitate livrată|

---

## 🔗 Relații între tabele

- CLIENTI → COMENZI (1:N)
- ANGAJATI → COMENZI (1:N)
- PRODUSE → DETALII_COMENZI (1:N)
- COMENZI → DETALII_COMENZI (1:N)
- PRODUSE → DEPOZIT (1:N)
- FURNIZORI → DEPOZIT (1:N)
- FURNIZORI → FACTURI (1:N)
- FUNCTII → ANGAJATI (1:N)

---

## 🚀 Scop

Această bază de date permite:
- Gestionarea eficientă a stocurilor 📊  
- Urmărirea comenzilor 📦  
- Administrarea relațiilor cu clienții 👥  
- Evidența angajaților și funcțiilor 👨‍💼  

---

<p align="center">
  💡 Proiect realizat pentru studiu și practică în baze de date
</p>
