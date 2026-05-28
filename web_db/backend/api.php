<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
session_start();
// --- VERİTABANI BAĞLANTISI (PDO) ---
$host = 'localhost';
$dbname = 'otogaleridb';
$user = 'root';
$pass = '';

try {
    $db = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
} catch (PDOException $e) {
    die(json_encode(["hata" => "Veritabanı bağlantı hatası: " . $e->getMessage()]));
}

$method = $_SERVER['REQUEST_METHOD'];

// --- VERİ OKUMA (GET) İŞLEMİ ---
if ($method === 'GET') {
    $tip = isset($_GET['tip']) ? $_GET['tip'] : 'araclar';

    if ($tip === 'markalar') {
        $sorgu = $db->query("SELECT * FROM Markalar ORDER BY MarkaAdi ASC");
        $veriler = $sorgu->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($veriler);
    } 
    elseif ($tip === 'subeler') {
        $sorgu = $db->query("SELECT * FROM Subeler ORDER BY SubeAdi ASC");
        $veriler = $sorgu->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($veriler);
    }elseif ($tip === 'testsurusleri') {
        $sorgu = $db->query("
            SELECT t.TestID, t.Tarih, t.Notlar, 
                   CONCAT(m.MarkaAdi, ' ', a.Model) AS Arac, 
                   mu.AdSoyad AS Musteri, 
                   p.AdSoyad AS Personel 
            FROM TestSurusleri t
            JOIN Araclar a ON t.AracID = a.AracID
            JOIN Markalar m ON a.MarkaID = m.MarkaID
            JOIN Musteriler mu ON t.MusteriID = mu.MusteriID
            JOIN Personeller p ON t.PersonelID = p.PersonelID
            ORDER BY t.Tarih DESC
        ");
        $veriler = $sorgu->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($veriler);
    }
     elseif ($tip === 'musteriler') {
        $sorgu = $db->query("SELECT * FROM Musteriler ORDER BY MusteriID DESC");
        $veriler = $sorgu->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($veriler);
    }elseif ($tip === 'satislar') {
        $sorgu = $db->query("SELECT * FROM vw_SatislarDetay ORDER BY Tarih DESC");
        $veriler = $sorgu->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($veriler);
    }elseif ($tip === 'istatistik') {
        $istatistikler = [];
        
        $istatistikler['toplam_arac'] = $db->query("SELECT COUNT(*) FROM Araclar")->fetchColumn();
        $istatistikler['satilan_arac'] = $db->query("SELECT COUNT(*) FROM Araclar WHERE Durum = 'Satıldı'")->fetchColumn();
        $istatistikler['toplam_musteri'] = $db->query("SELECT COUNT(*) FROM Musteriler")->fetchColumn();
        $istatistikler['toplam_ciro'] = $db->query("SELECT SUM(SatisFiyati) FROM Satislar")->fetchColumn();
        
        $istatistikler['marka_dagilimi'] = $db->query("
            SELECT m.MarkaAdi, COUNT(a.AracID) as Sayi 
            FROM Araclar a 
            JOIN Markalar m ON a.MarkaID = m.MarkaID 
            GROUP BY m.MarkaAdi
        ")->fetchAll(PDO::FETCH_ASSOC);

        echo json_encode($istatistikler);
    }
    elseif ($tip === 'araclar') {
        $sql = "SELECT a.AracID, a.SubeID, a.MarkaID, m.MarkaAdi, a.Model, a.SasiNo, a.Yil, a.Fiyat, a.Durum
                FROM Araclar a
                JOIN Markalar m ON a.MarkaID = m.MarkaID";
        if (isset($_GET['durum']) && $_GET['durum'] !== '') {
            $stmt = $db->prepare($sql . " WHERE a.Durum = ? ORDER BY a.AracID DESC");
            $stmt->execute([$_GET['durum']]);
            echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
        } else {
            $sorgu = $db->query($sql . " ORDER BY a.AracID DESC");
            echo json_encode($sorgu->fetchAll(PDO::FETCH_ASSOC));
        }
    }
    else {
        $sorgu = $db->query("SELECT * FROM vw_AktifAraclar"); 
        $araclar = $sorgu->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($araclar);
    }
}

// --- VERİ EKLEME (POST) İŞLEMİ ---
elseif ($method === 'POST') {
    $gelenVeri = json_decode(file_get_contents('php://input'), true);

    try {
        if (isset($gelenVeri['SatisFiyati'])) {
            $personel_id = isset($_SESSION['personel_id']) ? $_SESSION['personel_id'] : 1; // Giriş yapan personel
            
            $ekle = $db->prepare("INSERT INTO Satislar (AracID, PersonelID, MusteriID, SatisFiyati) VALUES (?, ?, ?, ?)");
            $ekle->execute([
                $gelenVeri['AracID'],
                $personel_id,
                $gelenVeri['MusteriID'],
                $gelenVeri['SatisFiyati']
            ]);
            echo json_encode(["durum" => "basarili", "mesaj" => "Satış başarıyla tamamlandı! Araç durumu otomatik 'Satıldı' yapıldı."]);
        }elseif (isset($gelenVeri['Tarih'])) {
            $personel_id = isset($_SESSION['personel_id']) ? $_SESSION['personel_id'] : 1;
            
            $ekle = $db->prepare("INSERT INTO TestSurusleri (AracID, MusteriID, PersonelID, Tarih, Notlar) VALUES (?, ?, ?, ?, ?)");
            $ekle->execute([
                $gelenVeri['AracID'],
                $gelenVeri['MusteriID'],
                $personel_id,
                $gelenVeri['Tarih'],
                $gelenVeri['Notlar']
            ]);
            echo json_encode(["durum" => "basarili", "mesaj" => "Test sürüşü randevusu başarıyla oluşturuldu!"]);
        }
        elseif (isset($gelenVeri['TCKimlik'])) {
            $ekle = $db->prepare("INSERT INTO Musteriler (AdSoyad, TCKimlik, Telefon, MusteriTipi) VALUES (?, ?, ?, ?)");
            $ekle->execute([$gelenVeri['AdSoyad'], $gelenVeri['TCKimlik'], $gelenVeri['Telefon'], $gelenVeri['MusteriTipi']]);
            echo json_encode(["durum" => "basarili", "mesaj" => "Müşteri başarıyla kaydedildi!"]);
        } 
        else {
            $ekle = $db->prepare("INSERT INTO Araclar (SubeID, MarkaID, Model, SasiNo, Yil, Fiyat, Durum) VALUES (?, ?, ?, ?, ?, ?, ?)");
            $ekle->execute([$gelenVeri['SubeID'], $gelenVeri['MarkaID'], $gelenVeri['Model'], $gelenVeri['SasiNo'], $gelenVeri['Yil'], $gelenVeri['Fiyat'], $gelenVeri['Durum']]);
            echo json_encode(["durum" => "basarili", "mesaj" => "Araç başarıyla veritabanına eklendi!"]);
        }
    } catch(PDOException $e) {
        echo json_encode(["durum" => "hata", "mesaj" => "İşlem başarısız: " . $e->getMessage()]);
    }
}

// --- VERİ SİLME (DELETE) İŞLEMİ ---
elseif ($method === 'DELETE') {
    $arac_id = isset($_GET['id']) ? intval($_GET['id']) : 0;

    if ($arac_id > 0) {
        try {
            $sil = $db->prepare("DELETE FROM Araclar WHERE AracID = ?");
            $sil->execute([$arac_id]);
            
            echo json_encode(["durum" => "basarili", "mesaj" => "Araç sistemden başarıyla silindi."]);
        } catch (PDOException $e) {
            if ($e->getCode() == '23000') {
                echo json_encode(["durum" => "hata", "mesaj" => "Silinemez: Bu araca ait bir satış veya test sürüşü kaydı bulunuyor!"]);
            } else {
                echo json_encode(["durum" => "hata", "mesaj" => "Silme başarısız: " . $e->getMessage()]);
            }
        }
    } else {
        echo json_encode(["durum" => "hata", "mesaj" => "Geçersiz Araç ID!"]);
    }
}
?>