<?php
session_start();

// --- VERİTABANI BAĞLANTISI ---
$host = 'localhost';
$dbname = 'otogaleridb';
$user = 'root';
$pass = '';

try {
    $db = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
} catch (PDOException $e) {
    die("Veritabanı bağlantı hatası: " . $e->getMessage());
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $eposta = trim($_POST['eposta']);
    $sifre = $_POST['sifre'];

    $sorgu = $db->prepare("SELECT * FROM Personeller WHERE Eposta = ?");
    $sorgu->execute([$eposta]);
    $personel = $sorgu->fetch(PDO::FETCH_ASSOC);

    if ($personel && $sifre === '123456') {
        $_SESSION['oturum_acik'] = true;
        $_SESSION['personel_ad'] = $personel['AdSoyad']; 
        $_SESSION['personel_id'] = $personel['PersonelID']; 
        
        header('Location: dashboard.php'); 
        exit;
    } else {
        $hata = "Sistemde böyle bir personel bulunamadı veya şifre hatalı!";
    }
}
?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Galeri Otomasyonu - Giriş</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f4f9; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-box { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); width: 300px; text-align: center; }
        .login-box h2 { margin-bottom: 20px; color: #333; }
        .login-box input { width: 90%; padding: 10px; margin: 10px 0; border: 1px solid #ccc; border-radius: 4px; }
        .login-box button { width: 100%; padding: 10px; background-color: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
        .login-box button:hover { background-color: #218838; }
        .error { color: red; font-size: 14px; margin-bottom: 10px; }
    </style>
</head>
<body>

    <div class="login-box">
        <h2>Sisteme Giriş</h2>
        <?php if(isset($hata)) echo "<div class='error'>$hata</div>"; ?>
        <form method="POST" action="">
            <input type="email" name="eposta" placeholder="E-posta (admin@galeri.com)" required>
            <input type="password" name="sifre" placeholder="Şifre (123456)" required>
            <button type="submit">Giriş Yap</button>
        </form>
    </div>

</body>
</html>