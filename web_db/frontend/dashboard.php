<?php
session_start();

if (!isset($_SESSION['oturum_acik']) || $_SESSION['oturum_acik'] !== true) {
    header('Location: index.php');
    exit;
}

if (isset($_GET['cikis'])) {
    session_destroy();
    header('Location: index.php');
    exit;
}
?>

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yönetim Paneli - Galeri Otomasyonu</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --turkuaz: #1381cb;       /* Ana tema rengi */
            --koyu-turkuaz: #008B8B;  /* Hover efektleri için */
            --acik-kahve: #D2B48C;    /* Vurgu rengi */
            --beyaz: #FFFFFF;         /* Arkaplan ve metin rengi */
            --acik-gri: #f4f7f6;      /* İçerik arkaplanı */
            --koyu-metin: #333333;
        }

        body { margin: 0; font-family: 'Segoe UI', sans-serif; display: flex; height: 100vh; background-color: var(--acik-gri); color: var(--koyu-metin); }
        
        /* Sol Menü (Sidebar) */
        .sidebar { width: 260px; background-color: var(--turkuaz); color: var(--beyaz); display: flex; flex-direction: column; box-shadow: 2px 0 5px rgba(0,0,0,0.1); }
        .sidebar h2 { text-align: center; padding: 25px 0; margin: 0; background-color: var(--koyu-turkuaz); font-size: 22px; letter-spacing: 1px; }
        .sidebar a { padding: 18px 20px; color: var(--beyaz); text-decoration: none; border-bottom: 1px solid rgba(255,255,255,0.2); display: block; font-weight: 500; transition: 0.3s; }
        .sidebar a:hover { background-color: var(--koyu-turkuaz); border-left: 5px solid var(--acik-kahve); padding-left: 15px; }
        .kullanici-bilgi { padding: 20px 15px; font-size: 14px; background-color: var(--beyaz); color: var(--koyu-turkuaz); font-weight: bold; text-align: center; border-bottom: 3px solid var(--acik-kahve); }
        
        /* Sağ İçerik Alanı */
        .content { flex: 1; padding: 30px; overflow-y: auto; }
        .content h1 { color: var(--koyu-turkuaz); margin-top: 0; border-bottom: 2px solid var(--acik-kahve); padding-bottom: 10px; display: inline-block; }
        .card { background: var(--beyaz); padding: 25px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); margin-bottom: 25px; border-top: 4px solid var(--turkuaz); }
        .btn-cikis { color: var(--beyaz); background-color: var(--acik-kahve); float: right; text-decoration: none; font-weight: bold; padding: 10px 15px; border-radius: 5px; transition: 0.3s; }
        .btn-cikis:hover { background-color: #B8966E; }

        /* Dashboard İstatistik Kartları */
        .stats-container { display: flex; gap: 20px; margin-bottom: 30px; }
        .stat-box { background: var(--turkuaz); color: var(--beyaz); padding: 20px; border-radius: 8px; flex: 1; text-align: center; border-bottom: 5px solid var(--acik-kahve); box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .stat-box h3 { margin: 0 0 10px 0; font-size: 16px; opacity: 0.9; }
        .stat-box h2 { margin: 0; font-size: 28px; }
        
        /* Grafik Konteyneri */
        .chart-container { background: var(--beyaz); padding: 20px; border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border-top: 4px solid var(--acik-kahve); width: 100%; max-width: 800px; margin: 0 auto; }
    </style>
</head>
<body>

    <div class="sidebar">
        <h2>Otogaleri Pro</h2>
        <div class="kullanici-bilgi">
            Hoş Geldin, <?php echo $_SESSION['personel_ad']; ?> 
        </div>
        <a href="dashboard.php">📊 Ana Sayfa (Özet)</a>
        <a href="?sayfa=araclar">🚗 Araç Yönetimi</a> 
        <a href="?sayfa=musteriler">👥 Müşteri İlişkileri</a>
        <a href="?sayfa=satislar">💰 Satış İşlemleri</a>
        <a href="?sayfa=testsurusleri">🔑 Test Sürüşleri</a>
    </div>

    <div class="content">
        <a href="?cikis=1" class="btn-cikis">Güvenli Çıkış Yap</a>
        
        <?php
        $sayfa = isset($_GET['sayfa']) ? $_GET['sayfa'] : 'anasayfa';

        if ($sayfa === 'araclar') {
            include 'arac_yonetimi.php';
        } elseif ($sayfa === 'musteriler') {
            include 'musteri_iliskileri.php';
        } elseif ($sayfa === 'satislar') {
            include 'satis_islemleri.php';
        } elseif ($sayfa === 'testsurusleri') {
            include 'test_surusleri.php';
        } elseif ($sayfa === 'anasayfa') {
            // YENİ ANA SAYFA (GRAFİKLİ ÖZET)
            echo '<h1>Sistem Özeti</h1>';
            echo '
            <div class="stats-container">
                <div class="stat-box"><h3>Toplam Araç Stoğu</h3><h2 id="toplam_arac">-</h2></div>
                <div class="stat-box"><h3>Satılan Araç Sayısı</h3><h2 id="satilan_arac">-</h2></div>
                <div class="stat-box" style="background-color: var(--koyu-turkuaz);"><h3>Kayıtlı Müşteri</h3><h2 id="toplam_musteri">-</h2></div>
                <div class="stat-box" style="background-color: var(--acik-kahve);"><h3>Toplam Ciro</h3><h2 id="toplam_ciro">- TL</h2></div>
            </div>
            
            <div class="chart-container">
                <h3 style="text-align:center; color: var(--koyu-turkuaz);">Markalara Göre Araç Dağılımı</h3>
                <canvas id="markaGrafik"></canvas>
            </div>

            <script>
                // API\'den istatistikleri çekip ekrana basıyoruz
                fetch("../backend/api.php?tip=istatistik")
                .then(res => res.json())
                .then(data => {
                    document.getElementById("toplam_arac").innerText = data.toplam_arac;
                    document.getElementById("satilan_arac").innerText = data.satilan_arac;
                    document.getElementById("toplam_musteri").innerText = data.toplam_musteri;
                    document.getElementById("toplam_ciro").innerText = data.toplam_ciro ? new Intl.NumberFormat("tr-TR").format(data.toplam_ciro) + " ₺" : "0 ₺";

                    // Chart.js Bar Grafiği Kurulumu
                    const ctx = document.getElementById("markaGrafik").getContext("2d");
                    const etiketler = data.marka_dagilimi.map(item => item.MarkaAdi);
                    const degerler = data.marka_dagilimi.map(item => item.Sayi);

                    new Chart(ctx, {
                        type: "bar",
                        data: {
                            labels: etiketler,
                            datasets: [{
                                label: "Stoktaki Araç Sayısı",
                                data: degerler,
                                backgroundColor: "#D2B48C", // Açık Kahve
                                borderColor: "#00CED1",     // Turkuaz
                                borderWidth: 2,
                                borderRadius: 5
                            }]
                        },
                        options: { 
                            responsive: true,
                            scales: {
                                y: { beginAtZero: true, ticks: { stepSize: 1 } }
                            }
                        }
                    });
                });
            </script>
            ';
        }
        ?>
    </div>

</body>
</html>