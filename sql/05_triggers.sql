USE OtogaleriDB;


CREATE TABLE IF NOT EXISTS Araclar_FiyatGecmisi (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    AracID INT NOT NULL,
    EskiFiyat DECIMAL(12, 2) NOT NULL,
    YeniFiyat DECIMAL(12, 2) NOT NULL,
    DegisimTarihi DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_FiyatGecmisi_Arac 
        FOREIGN KEY (AracID) REFERENCES Araclar(AracID) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

DELIMITER $$
CREATE TRIGGER trg_Satislar_AfterInsert
AFTER INSERT ON Satislar
FOR EACH ROW
BEGIN
    UPDATE Araclar
    SET Durum = 'Satıldı'
    WHERE AracID = NEW.AracID;
END$$
DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_TestSurusleri_BeforeInsert
BEFORE INSERT ON TestSurusleri
FOR EACH ROW
BEGIN
    DECLARE v_durum VARCHAR(15);
    
    SELECT Durum INTO v_durum
    FROM Araclar
    WHERE AracID = NEW.AracID;
    
    IF v_durum = 'Satıldı' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Satılmış araç için test sürüşü yapılamaz!';
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_Araclar_FiyatLog
AFTER UPDATE ON Araclar
FOR EACH ROW
BEGIN
    IF OLD.Fiyat <> NEW.Fiyat THEN
        INSERT INTO Araclar_FiyatGecmisi (AracID, EskiFiyat, YeniFiyat)
        VALUES (NEW.AracID, OLD.Fiyat, NEW.Fiyat);
    END IF;
END$$

DELIMITER ;
