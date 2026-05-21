USE OtogaleriDB;

-- ==========================================================
-- VIEW 1: Satılık araçların aktif kataloğu
-- Kullanım alanı: web sitesinin ana sayfası, şehre göre filtreleme
-- Gizlenenler: 3 tabloda birleştirme (Araclar, Markalar, Subeler)
-- ==========================================================
CREATE OR REPLACE VIEW vw_AktifAraclar AS
SELECT 
    a.AracID,
    m.MarkaAdi,
    a.Model,
    a.Yil,
    a.Fiyat,
    a.SasiNo,
    a.Durum,
    s.SubeAdi,
    s.Sehir
FROM Araclar a
JOIN Markalar m ON a.MarkaID = m.MarkaID
JOIN Subeler s ON a.SubeID = s.SubeID
WHERE a.Durum = 'Satışta'
ORDER BY a.Fiyat;

-- ==========================================================
-- VIEW 2: Detaylı Satış Raporu
-- Kullanım Alanları: Yönetim Paneli, Aylık Raporlar
-- Gizlenenler: 6 tabloda birleştirme + indirim hesaplaması
-- ==========================================================
CREATE OR REPLACE VIEW vw_SatislarDetay AS
SELECT 
    s.SatisID,
    DATE(s.SatisTarihi) AS Tarih,
    CONCAT(m.MarkaAdi, ' ', a.Model, ' (', a.Yil, ')') AS Arac,
    a.SasiNo,
    mu.AdSoyad AS MusteriAdi,
    mu.MusteriTipi,
    p.AdSoyad AS PersonelAdi,
    sb.SubeAdi,
    sb.Sehir,
    a.Fiyat AS KatalogFiyati,
    s.SatisFiyati,
    (a.Fiyat - s.SatisFiyati) AS Indirim,
    ROUND((a.Fiyat - s.SatisFiyati) / a.Fiyat * 100, 2) AS IndirimYuzdesi
FROM Satislar s
JOIN Araclar a ON s.AracID = a.AracID
JOIN Markalar m ON a.MarkaID = m.MarkaID
JOIN Musteriler mu ON s.MusteriID = mu.MusteriID
JOIN Personeller p ON s.PersonelID = p.PersonelID
JOIN Subeler sb ON p.SubeID = sb.SubeID;

-- ==========================================================
-- VIEW 3: Çalışan Performansı (KPI)
-- Kullanım alanları: prim hesaplamaları, çalışan değerlendirmeleri, puanlamalar
-- Özellik: toplama (GROUP BY) + LEFT JOIN
-- ==========================================================
CREATE OR REPLACE VIEW vw_PersonelPerformans AS
SELECT 
    p.PersonelID,
    p.AdSoyad,
    sb.SubeAdi,
    sb.Sehir,
    COUNT(s.SatisID) AS ToplamSatis,
    COALESCE(SUM(s.SatisFiyati), 0) AS ToplamCiro,
    COALESCE(ROUND(AVG(s.SatisFiyati), 2), 0) AS OrtalamaSatis,
    MAX(s.SatisTarihi) AS SonSatisTarihi
FROM Personeller p
JOIN Subeler sb ON p.SubeID = sb.SubeID
LEFT JOIN Satislar s ON p.PersonelID = s.PersonelID
GROUP BY p.PersonelID, p.AdSoyad, sb.SubeAdi, sb.Sehir
ORDER BY ToplamCiro DESC;

-- ==========================================================
-- VIEW 4: Şube bazında depo özeti
-- Kullanım amacı: operasyonel izleme, stok dengeleme
-- Özellik: koşullu toplama (CASE WHEN)
-- ==========================================================
CREATE OR REPLACE VIEW vw_SubeStok AS
SELECT 
    sb.SubeID,
    sb.SubeAdi,
    sb.Sehir,
    COUNT(a.AracID) AS ToplamArac,
    SUM(CASE WHEN a.Durum = 'Satışta' THEN 1 ELSE 0 END) AS Satista,
    SUM(CASE WHEN a.Durum = 'Satıldı' THEN 1 ELSE 0 END) AS Satildi,
    SUM(CASE WHEN a.Durum = 'Rezerve' THEN 1 ELSE 0 END) AS Rezerve,
    COALESCE(SUM(CASE WHEN a.Durum = 'Satışta' THEN a.Fiyat ELSE 0 END), 0) AS SatistakiToplamDeger
FROM Subeler sb
LEFT JOIN Araclar a ON sb.SubeID = a.SubeID
GROUP BY sb.SubeID, sb.SubeAdi, sb.Sehir
ORDER BY ToplamArac DESC;