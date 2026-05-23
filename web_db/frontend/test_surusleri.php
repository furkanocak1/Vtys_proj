<style>
    .test-formu select, .test-formu input, .test-formu textarea { padding: 8px; margin: 5px 5px 15px 0; border: 1px solid #ccc; border-radius: 4px; width: 300px; display: block; }
    .test-formu button { padding: 9px 15px; background-color: #9b59b6; color: white; border: none; border-radius: 4px; cursor: pointer; }
    .test-formu button:hover { background-color: #8e44ad; }
    .test-karti { border-left: 4px solid #9b59b6; padding: 15px; margin-bottom: 15px; background: white; box-shadow: 0 1px 2px rgba(0,0,0,0.1); }
</style>

<h2>Test Sürüşleri Yönetimi</h2>

<div class="card test-formu">
    <h3>Yeni Randevu Oluştur</h3>
    <form id="yeni-test-form">
        
        <label>Araç Seçin:</label>
        <select id="arac_id" required>
            <option value="">Araç Seçiliyor...</option>
        </select>
        
        <label>Müşteri Seçin:</label>
        <select id="musteri_id" required>
            <option value="">Müşteri Seçiliyor...</option>
        </select>

        <label>Randevu Tarihi ve Saati:</label>
        <input type="datetime-local" id="tarih" required>
        
        <label>Notlar (İsteğe Bağlı):</label>
        <textarea id="notlar" rows="3" placeholder="Müşteri talepleri vb..."></textarea>
        
        <button type="submit">Randevuyu Kaydet</button>
    </form>
</div>

<h3>Geçmiş ve Planlanan Sürüşler</h3>
<div id="test-listesi-kutu">
    <p>Randevular yükleniyor...</p>
</div>

<script>
    function formVerileriniGetir() {
        fetch('../backend/api.php?tip=araclar')
            .then(res => res.json())
            .then(data => {
                const aracSelect = document.getElementById('arac_id');
                aracSelect.innerHTML = '<option value="">Test Edilecek Aracı Seçin</option>';
                data.forEach(arac => {
                    aracSelect.innerHTML += `<option value="${arac.AracID}">${arac.MarkaAdi} ${arac.Model} (${arac.Durum})</option>`;
                });
            });

        fetch('../backend/api.php?tip=musteriler')
            .then(res => res.json())
            .then(data => {
                const musteriSelect = document.getElementById('musteri_id');
                musteriSelect.innerHTML = '<option value="">Müşteri Seçin</option>';
                data.forEach(musteri => {
                    musteriSelect.innerHTML += `<option value="${musteri.MusteriID}">${musteri.AdSoyad}</option>`;
                });
            });
    }

    function testleriGetir() {
        fetch('../backend/api.php?tip=testsurusleri')
            .then(res => res.json())
            .then(data => {
                const listeDiv = document.getElementById('test-listesi-kutu');
                listeDiv.innerHTML = ''; 

                data.forEach(test => {
                    let notMetni = test.Notlar ? test.Notlar : "Not girilmemiş.";
                    listeDiv.innerHTML += `
                        <div class="test-karti">
                            <h4 style="margin:0 0 10px 0;">${test.Arac}</h4>
                            <p style="margin:0; font-size:14px;">
                                <strong>Müşteri:</strong> ${test.Musteri} | 
                                <strong>Tarih:</strong> ${test.Tarih} |
                                <strong>Personel:</strong> ${test.Personel}
                            </p>
                            <p style="margin:10px 0 0 0; font-size:13px; color:#555;"><i>" ${notMetni} "</i></p>
                        </div>
                    `;
                });
            });
    }

    formVerileriniGetir();
    testleriGetir();

    // Form Gönderimi
    document.getElementById('yeni-test-form').addEventListener('submit', function(e) {
        e.preventDefault();

        const yeniTest = {
            AracID: document.getElementById('arac_id').value,
            MusteriID: document.getElementById('musteri_id').value,
            Tarih: document.getElementById('tarih').value,
            Notlar: document.getElementById('notlar').value
        };

        fetch('../backend/api.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(yeniTest)
        })
        .then(res => res.json())
        .then(data => {
            alert(data.mesaj); // Trigger hata atarsa burada "Satılmış araç için..." uyarısını göreceğiz.
            if(data.durum === "basarili") {
                document.getElementById('yeni-test-form').reset();
                testleriGetir(); 
            }
        });
    });
</script>