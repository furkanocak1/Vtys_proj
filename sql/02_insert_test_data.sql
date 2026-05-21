
-- ==========================================================
-- 1. MARKALAR
-- ==========================================================
INSERT INTO Markalar (MarkaAdi) VALUES
('BMW'),
('Mercedes-Benz'),
('Audi'),
('Volkswagen'),
('Toyota'),
('Honda'),
('Ford'),
('Renault'),
('Fiat'),
('Hyundai');

-- ==========================================================
-- 2. SUBELER
-- ==========================================================
INSERT INTO Subeler (SubeAdi, Sehir) VALUES
('İstanbul Kadıköy Şubesi',  'İstanbul'),
('İstanbul Beşiktaş Şubesi', 'İstanbul'),
('İstanbul Maslak Şubesi',   'İstanbul'),
('Ankara Çankaya Şubesi',    'Ankara'),
('Ankara Kızılay Şubesi',    'Ankara'),
('İzmir Bornova Şubesi',     'İzmir'),
('İzmir Karşıyaka Şubesi',   'İzmir'),
('Bursa Nilüfer Şubesi',     'Bursa'),
('Antalya Muratpaşa Şubesi', 'Antalya'),
('Kocaeli İzmit Şubesi',     'Kocaeli');

-- ==========================================================
-- 3. MUSTERILER
-- ==========================================================
INSERT INTO Musteriler (AdSoyad, TCKimlik, Telefon, MusteriTipi) VALUES
('Ahmet Yılmaz',       '12345678901', '0532-111-2233', 'Bireysel'),
('Ayşe Kaya',          '12345678902', '0533-222-3344', 'Bireysel'),
('Mehmet Demir',       '12345678903', '0534-333-4455', 'Bireysel'),
('Fatma Şahin',        '12345678904', '0535-444-5566', 'Bireysel'),
('Mustafa Çelik',      '12345678905', '0536-555-6677', 'Bireysel'),
('Zeynep Arslan',      '12345678906', '0537-666-7788', 'Bireysel'),
('Hasan Yıldız',       '12345678907', '0538-777-8899', 'Bireysel'),
('Elif Aydın',         '12345678908', '0539-888-9900', 'Bireysel'),
('ABC Lojistik A.Ş.',  '12345678909', '0212-555-0001', 'Kurumsal'),
('XYZ İnşaat Ltd.',    '12345678910', '0212-555-0002', 'Kurumsal'),
('Teknoloji A.Ş.',     '12345678911', '0216-555-0003', 'Kurumsal'),
('Mega Market Zinciri','12345678912', '0312-555-0004', 'Kurumsal');

-- ==========================================================
-- 4. PERSONELLER (10 сотрудников — по разным филиалам)
-- ==========================================================
INSERT INTO Personeller (SubeID, AdSoyad, Eposta, IseGirisTarihi) VALUES
(1,  'Furkan Ocak',      'furkan.ocak@otogaleri.com',    '2020-03-15'),
(1,  'Kamil Khozhikov',  'kamil.k@otogaleri.com',        '2021-06-20'),
(2,  'Selin Yıldırım',   'selin.y@otogaleri.com',        '2019-11-05'),
(3,  'Burak Öztürk',     'burak.o@otogaleri.com',        '2022-01-10'),
(4,  'Deniz Aksoy',      'deniz.a@otogaleri.com',        '2020-08-22'),
(5,  'Ece Polat',        'ece.p@otogaleri.com',          '2023-02-14'),
(6,  'Onur Erdoğan',     'onur.e@otogaleri.com',         '2021-09-30'),
(7,  'Pınar Koç',        'pinar.k@otogaleri.com',        '2022-05-18'),
(8,  'Serkan Aslan',     'serkan.a@otogaleri.com',       '2020-12-01'),
(10, 'Tuğçe Çetin',      'tugce.c@otogaleri.com',        '2023-07-07');

-- ==========================================================
-- 5. ARACLAR 
-- ==========================================================
INSERT INTO Araclar (SubeID, MarkaID, Model, SasiNo, Yil, Fiyat, Durum) VALUES
-- 10 ('Satıldı')
(1,  1,  'X5',       'WBAFR9C50BC100001', 2022, 2450000, 'Satıldı'),
(1,  2,  'C200',     'WDDGF8AB1FR100002', 2021, 1850000, 'Satıldı'),
(2,  3,  'A4',       'WAUZZZ8K1AN100003', 2023, 2100000, 'Satıldı'),
(3,  4,  'Passat',   'WVWZZZ3CZ9P100004', 2020, 1450000, 'Satıldı'),
(4,  5,  'Corolla',  'JTDBT923771100005', 2022, 1250000, 'Satıldı'),
(5,  7,  'Focus',    'WF0DXXGCBDA100006', 2021,  980000, 'Satıldı'),
(6,  8,  'Megane',   'VF1KZ140548100007', 2023, 1150000, 'Satıldı'),
(7,  6,  'Civic',    'JHMFA16506S100008', 2020,  980000, 'Satıldı'),
(8,  9,  'Egea',     'ZFA32400006100009', 2022,  750000, 'Satıldı'),
(1,  10, 'Tucson',   'KMHJ381BFFU100010', 2023, 1690000, 'Satıldı'),
-- 6('Satışta')
(2,  1,  '320i',     'WBA8E1100C7100011', 2024, 2750000, 'Satışta'),
(3,  2,  'E300',     'WDDZF4JBXKA100012', 2024, 3450000, 'Satışta'),
(4,  5,  'RAV4',     'JTMBFREV60J100013', 2023, 2150000, 'Satışta'),
(5,  4,  'Tiguan',   'WVGZZZ5NZNW100014', 2024, 1980000, 'Satışta'),
(6,  7,  'Kuga',     'WF0AXXGCBANL00015', 2022, 1450000, 'Satışta'),
(7,  3,  'Q5',       'WAUZZZFY1L2100016', 2023, 2890000, 'Satışta'),
-- 2('Rezerve')
(8,  1,  'M3',       'WBS8M9C50P5100017', 2024, 3850000, 'Rezerve'),
(10, 2,  'GLC300',   'W1N0G8DB2NF100018', 2023, 2950000, 'Rezerve');

-- ==========================================================
-- 6. TESTSURUSLERI 
-- ==========================================================
INSERT INTO TestSurusleri (AracID, MusteriID, PersonelID, Tarih, Notlar) VALUES
(11, 1,  1,  '2026-05-10 10:30:00', 'Müşteri motor sesinden çok memnun kaldı'),
(12, 2,  3,  '2026-05-11 14:00:00', 'Test sürüşü olumlu, fiyat görüşülecek'),
(11, 3,  1,  '2026-05-12 11:15:00', 'İlgilendi ama düşünme süresi istedi'),
(13, 4,  5,  '2026-05-13 16:45:00', 'Aile aracı olarak değerlendiriyor'),
(14, 5,  5,  '2026-05-14 09:30:00', 'Yakıt tüketimi konusunda soru sordu'),
(15, 6,  7,  '2026-05-15 13:00:00', 'Memnun kaldı, eşiyle gelip tekrar bakacak'),
(16, 7,  4,  '2026-05-16 10:00:00', 'Premium segment, üst paket istiyor'),
(17, 8,  9,  '2026-05-17 15:30:00', 'Spor model, performansından etkilendi'),
(18, 11, 10, '2026-05-18 11:45:00', 'Kurumsal filo için değerlendirme'),
(11, 4,  2,  '2026-05-19 14:15:00', NULL),
(13, 9,  5,  '2026-05-19 16:00:00', 'Toplu alım için fiyat sorusu'),
(15, 10, 7,  '2026-05-20 10:30:00', 'Şirket aracı olarak almayı düşünüyor');

-- ==========================================================
-- 7. SATISLAR 
-- ==========================================================
INSERT INTO Satislar (AracID, PersonelID, MusteriID, SatisFiyati, SatisTarihi) VALUES
(1,  1, 1,  2400000, '2026-04-15 14:30:00'),
(2,  3, 2,  1820000, '2026-04-20 11:00:00'),
(3,  4, 3,  2050000, '2026-04-25 16:15:00'),
(4,  5, 9,  1400000, '2026-04-28 10:45:00'),
(5,  6, 5,  1230000, '2026-05-02 13:20:00'),
(6,  7, 6,   970000, '2026-05-05 15:00:00'),
(7,  8, 11, 1130000, '2026-05-08 09:30:00'),
(8,  9, 8,   970000, '2026-05-10 14:00:00'),
(9,  9, 12,  745000, '2026-05-15 11:45:00'),
(10, 1, 7,  1670000, '2026-05-18 16:30:00');


SELECT 'Markalar' AS Tablo, COUNT(*) AS Sayi FROM Markalar
UNION ALL SELECT 'Subeler', COUNT(*) FROM Subeler
UNION ALL SELECT 'Musteriler', COUNT(*) FROM Musteriler
UNION ALL SELECT 'Personeller', COUNT(*) FROM Personeller
UNION ALL SELECT 'Araclar', COUNT(*) FROM Araclar
UNION ALL SELECT 'TestSurusleri', COUNT(*) FROM TestSurusleri
UNION ALL SELECT 'Satislar', COUNT(*) FROM Satislar;

SELECT 
    s.SatisID,
    DATE(s.SatisTarihi) AS Tarih,
    CONCAT(mk.MarkaAdi, ' ', a.Model, ' (', a.Yil, ')') AS Arac,
    mu.AdSoyad AS Musteri,
    mu.MusteriTipi AS Tip,
    p.AdSoyad AS SatanPersonel,
    sb.SubeAdi AS Sube,
    FORMAT(a.Fiyat, 0) AS KatalogFiyati,
    FORMAT(s.SatisFiyati, 0) AS SatisFiyati,
    FORMAT(a.Fiyat - s.SatisFiyati, 0) AS Indirim
FROM Satislar s
JOIN Araclar a       ON s.AracID = a.AracID
JOIN Markalar mk     ON a.MarkaID = mk.MarkaID
JOIN Musteriler mu   ON s.MusteriID = mu.MusteriID
JOIN Personeller p   ON s.PersonelID = p.PersonelID
JOIN Subeler sb      ON p.SubeID = sb.SubeID
ORDER BY s.SatisTarihi DESC;