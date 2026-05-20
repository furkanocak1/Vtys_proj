-- ==========================================================
-- OtogaleriDB — Database Schema
-- TBL331 Veritabanı Yönetim Sistemleri / 2025-2026 Bahar
-- ==========================================================

DROP DATABASE IF EXISTS OtogaleriDB;
CREATE DATABASE OtogaleriDB CHARACTER SET utf8mb4 COLLATE utf8mb4_turkish_ci;
USE OtogaleriDB;

-- ---------- 1. Markalar ----------
CREATE TABLE Markalar (
    MarkaID INT AUTO_INCREMENT PRIMARY KEY,
    MarkaAdi VARCHAR(50) NOT NULL UNIQUE
);

-- ---------- 2. Subeler ----------
CREATE TABLE Subeler (
    SubeID INT AUTO_INCREMENT PRIMARY KEY,
    SubeAdi VARCHAR(100) NOT NULL,
    Sehir VARCHAR(50) NOT NULL
);

-- ---------- 3. Musteriler ----------
CREATE TABLE Musteriler (
    MusteriID INT AUTO_INCREMENT PRIMARY KEY,
    AdSoyad VARCHAR(100) NOT NULL,
    TCKimlik VARCHAR(11) NOT NULL UNIQUE,
    Telefon VARCHAR(20) NOT NULL,
    MusteriTipi VARCHAR(15) NOT NULL DEFAULT 'Bireysel',
    CONSTRAINT chk_MusteriTipi CHECK (MusteriTipi IN ('Bireysel', 'Kurumsal'))
);

-- ---------- 4. Personeller ----------
CREATE TABLE Personeller (
    PersonelID INT AUTO_INCREMENT PRIMARY KEY,
    SubeID INT NOT NULL,
    AdSoyad VARCHAR(100) NOT NULL,
    Eposta VARCHAR(100) NOT NULL UNIQUE,
    IseGirisTarihi DATE NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_Personel_Sube FOREIGN KEY (SubeID) REFERENCES Subeler(SubeID) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ---------- 5. Araclar ----------
CREATE TABLE Araclar (
    AracID INT AUTO_INCREMENT PRIMARY KEY,
    SubeID INT NOT NULL,
    MarkaID INT NOT NULL,
    Model VARCHAR(50) NOT NULL,
    SasiNo VARCHAR(17) NOT NULL UNIQUE,
    Yil INT NOT NULL,
    Fiyat DECIMAL(12, 2) NOT NULL,
    Durum VARCHAR(15) NOT NULL DEFAULT 'Satışta',
    CONSTRAINT fk_Arac_Sube FOREIGN KEY (SubeID) REFERENCES Subeler(SubeID) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_Arac_Marka FOREIGN KEY (MarkaID) REFERENCES Markalar(MarkaID) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_Arac_Yil CHECK (Yil >= 2000),
    CONSTRAINT chk_Arac_Fiyat CHECK (Fiyat > 0),
    CONSTRAINT chk_Arac_Durum CHECK (Durum IN ('Satışta', 'Satıldı', 'Rezerve'))
);

-- ---------- 6. TestSurusleri ----------
CREATE TABLE TestSurusleri (
    TestID INT AUTO_INCREMENT PRIMARY KEY,
    AracID INT NOT NULL,
    MusteriID INT NOT NULL,
    PersonelID INT NOT NULL,
    Tarih DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Notlar TEXT,
    CONSTRAINT fk_Test_Arac FOREIGN KEY (AracID) REFERENCES Araclar(AracID) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_Test_Musteri FOREIGN KEY (MusteriID) REFERENCES Musteriler(MusteriID) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_Test_Personel FOREIGN KEY (PersonelID) REFERENCES Personeller(PersonelID) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ---------- 7. Satislar ----------
CREATE TABLE Satislar (
    SatisID INT AUTO_INCREMENT PRIMARY KEY,
    AracID INT NOT NULL UNIQUE,
    PersonelID INT NOT NULL,
    MusteriID INT NOT NULL,
    SatisFiyati DECIMAL(12, 2) NOT NULL,
    SatisTarihi DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_Satis_Arac FOREIGN KEY (AracID) REFERENCES Araclar(AracID) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_Satis_Personel FOREIGN KEY (PersonelID) REFERENCES Personeller(PersonelID) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_Satis_Musteri FOREIGN KEY (MusteriID) REFERENCES Musteriler(MusteriID) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_Satis_Fiyat CHECK (SatisFiyati > 0)
);
