USE OtogaleriDB;

-- ==========================================================
-- INDEX 1: Araçları durumuna göre ara
-- Neden: Uygulama sürekli olarak "sadece satılık" gösteriyor
-- Sorgu: SELECT * FROM Araclar WHERE Durum = 'Satışta'
-- ==========================================================
CREATE INDEX idx_araclar_durum 
ON Araclar(Durum);

-- ==========================================================
-- INDEX 2: Marka ve yıla göre arama için bileşik indeks
-- Neden: Kullanıcılar kataloğu şu şekilde filtreliyor: "2022'den itibaren BMW"
-- Sorgu: SELECT * FROM Araclar WHERE MarkaID = 1 AND Yil >= 2022
-- ==========================================================
CREATE INDEX idx_araclar_marka_yil 
ON Araclar(MarkaID, Yil);

-- ==========================================================
-- INDEX 3: Tarihe Göre Satışlar
-- Neden: Aylık/Üç Aylık/Yıllık raporlar
-- Sorgu: SELECT * FROM Satislar WHERE SatisTarihi BETWEEN '...' AND '...'
-- ==========================================================
CREATE INDEX idx_satislar_tarih 
ON Satislar(SatisTarihi);

-- ==========================================================
-- INDEX 4: Müşteri Türüne Göre
-- Neden: Bireysel ve Kurumsal için ayrı ayrı pazarlama
-- Sorgu: SELECT * FROM Musteriler WHERE MusteriTipi = 'Kurumsal'
-- ==========================================================
CREATE INDEX idx_musteriler_tipi 
ON Musteriler(MusteriTipi);

-- ==========================================================
-- INDEX 5: Tarihe Göre Test Sürüşleri
-- Neden: Belirli bir döneme ait test sürüşlerini görüntüleyin (raporlar, yönetici KPI'ları)
-- Sorgu: SELECT * FROM TestSurusleri WHERE Tarih >= '...'
-- ==========================================================
CREATE INDEX idx_testsurusleri_tarih 
ON TestSurusleri(Tarih);

SHOW INDEXES FROM Araclar;

SHOW INDEXES FROM Satislar;
SHOW INDEXES FROM Musteriler;
SHOW INDEXES FROM TestSurusleri;

EXPLAIN SELECT * FROM Araclar WHERE Durum = 'Satışta';

EXPLAIN SELECT * FROM Araclar WHERE Model = 'X5';