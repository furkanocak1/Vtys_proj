USE OtogaleriDB;

DELIMITER $$

CREATE PROCEDURE sp_AracSat(
    IN p_AracID INT,
    IN p_PersonelID INT,
    IN p_MusteriID INT,
    IN p_SatisFiyati DECIMAL(12,2)
)
BEGIN
    DECLARE v_durum VARCHAR(15);

    -- Arabanin durum
    SELECT Durum INTO v_durum FROM Araclar WHERE AracID = p_AracID;

    -- test
    IF v_durum IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Araç bulunamadı!';
    ELSEIF v_durum = 'Satıldı' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bu araç zaten satılmış!';
    ELSE
        -- satiliyoruz
        INSERT INTO Satislar (AracID, PersonelID, MusteriID, SatisFiyati)
        VALUES (p_AracID, p_PersonelID, p_MusteriID, p_SatisFiyati);
    END IF;
END$$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE sp_AylikSatisRaporu(
    IN p_Yil INT,
    IN p_Ay INT
)
BEGIN
    SELECT 
        DATE(s.SatisTarihi) AS Tarih,
        CONCAT(m.MarkaAdi, ' ', a.Model) AS Arac,
        mu.AdSoyad AS Musteri,
        p.AdSoyad AS Personel,
        s.SatisFiyati
    FROM Satislar s
    JOIN Araclar a    ON s.AracID = a.AracID
    JOIN Markalar m   ON a.MarkaID = m.MarkaID
    JOIN Musteriler mu ON s.MusteriID = mu.MusteriID
    JOIN Personeller p ON s.PersonelID = p.PersonelID
    WHERE YEAR(s.SatisTarihi) = p_Yil
      AND MONTH(s.SatisTarihi) = p_Ay
    ORDER BY s.SatisTarihi;
END$$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE sp_SubeStokOzeti(
    IN  p_SubeID INT,
    OUT p_Satista INT,
    OUT p_Satildi INT,
    OUT p_ToplamDeger DECIMAL(15,2)
)
BEGIN
    SELECT COUNT(*) INTO p_Satista
    FROM Araclar WHERE SubeID = p_SubeID AND Durum = 'Satışta';

    SELECT COUNT(*) INTO p_Satildi
    FROM Araclar WHERE SubeID = p_SubeID AND Durum = 'Satıldı';

    SELECT COALESCE(SUM(Fiyat), 0) INTO p_ToplamDeger
    FROM Araclar WHERE SubeID = p_SubeID AND Durum = 'Satışta';
END$$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE sp_YeniMusteriKaydet(
    IN p_AdSoyad VARCHAR(100),
    IN p_TCKimlik VARCHAR(11),
    IN p_Telefon VARCHAR(20),
    IN p_MusteriTipi VARCHAR(15)
)
BEGIN
    DECLARE v_count INT;

    -- kontrol ediyoruz ayni TC Kimlik 'le musteri var mi diye'
    SELECT COUNT(*) INTO v_count FROM Musteriler WHERE TCKimlik = p_TCKimlik;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bu TC Kimlik ile zaten kayıtlı müşteri var!';
    ELSEIF LENGTH(p_TCKimlik) <> 11 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'TC Kimlik 11 haneli olmalıdır!';
    ELSE
        INSERT INTO Musteriler (AdSoyad, TCKimlik, Telefon, MusteriTipi)
        VALUES (p_AdSoyad, p_TCKimlik, p_Telefon, COALESCE(p_MusteriTipi, 'Bireysel'));
    END IF;
END$$

DELIMITER ;