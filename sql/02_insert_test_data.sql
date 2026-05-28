USE OtogaleriDB;

SELECT 'Markalar' AS T, COUNT(*) AS N FROM Markalar
UNION ALL SELECT 'Subeler', COUNT(*) FROM Subeler
UNION ALL SELECT 'Musteriler', COUNT(*) FROM Musteriler
UNION ALL SELECT 'Personeller', COUNT(*) FROM Personeller
UNION ALL SELECT 'Araclar', COUNT(*) FROM Araclar;