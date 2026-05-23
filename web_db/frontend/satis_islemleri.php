<style>
    .satis-formu select, .satis-formu input { padding: 8px; margin: 5px 5px 15px 0; border: 1px solid #ccc; border-radius: 4px; width: 300px; display: block; }
    .satis-formu button { padding: 9px 15px; background-color: #f39c12; color: white; border: none; border-radius: 4px; cursor: pointer; }
    .satis-formu button:hover { background-color: #e67e22; }
    .satis-karti { border-left: 4px solid #f39c12; padding: 15px; margin-bottom: 15px; background: white; box-shadow: 0 1px 2px rgba(0,0,0,0.1); }
</style>

<h2>Satış İşlemleri</h2>

<div class="card satis-formu">
    <h3>Yeni Satış Yap</h3>
    <form id="yeni-satis-form">
        
        <label>Araç Seçin (Sadece Satışta Olanlar):</label>
        <select id="arac_id" required>
            <option value="">Araç Seçiliyor...</option>
        </select>
        
        <label>Müşteri Seçin:</label>
        <select id="musteri_id" required>
            <option value="">Müşteri Seçiliyor...</option>
        </select>

        <label>Anlaşılan Satış Fiyatı (TL):</label>
        <input type="number" id="satis_fiyati" placeholder="Örn: 1500000" required>
        
        <button type="submit">Satışı Onayla</button>
    </form>
</div>

<h3>Geçmiş Satış Kayıtları</h3>
<div id="satis-listesi-kutu">
    <p>Satışlar yükleniyor...</p>
</div>

<script>
    function formVerileriniGetir() {
        fetch('../backend/api.php?tip=araclar')
            .then(res => res.json())
            .then(data => {
                const aracSelect = document.getElementById('arac_id');
                aracSelect.innerHTML = '<option value="">Satılacak Aracı Seçin</option>';
                data.forEach(arac => {
                    aracSelect.innerHTML += `<option value="${arac.AracID}">${arac.MarkaAdi} ${arac.Model} - ${arac.Fiyat} TL</option>`;
                });
            });

        fetch('../backend/api.php?tip=musteriler')
            .then(res => res.json())
            .then(data => {
                const musteriSelect = document.getElementById('musteri_id');
                musteriSelect.innerHTML = '<option value="">Müşteri Seçin</option>';
                data.forEach(musteri => {
                    musteriSelect.innerHTML += `<option value="${musteri.MusteriID}">${musteri.AdSoyad} (${musteri.TCKimlik})</option>`;
                });
            });
    }

    function satislariGetir() {
        fetch('../backend/api.php?tip=satislar')
            .then(res => res.json())
            .then(data => {
                const listeDiv = document.getElementById('satis-listesi-kutu');
                listeDiv.innerHTML = ''; 

                data.forEach(satis => {
                    listeDiv.innerHTML += `
                        <div class="satis-karti">
                            <h4 style="margin:0 0 10px 0;">${satis.Arac}</h4>
                            <p style="margin:0; font-size:14px;">
                                <strong>Müşteri:</strong> ${satis.MusteriAdi} | 
                                <strong>Satış Fiyatı:</strong> ${satis.SatisFiyati} TL |
                                <strong>İndirim Tutarı:</strong> ${satis.Indirim} TL |
                                <strong>Tarih:</strong> ${satis.Tarih} |
                                <strong>Satan Personel:</strong> ${satis.PersonelAdi}
                            </p>
                        </div>
                    `;
                });
            });
    }

    formVerileriniGetir();
    satislariGetir();

    // 3. Satış Formu Gönderimi
    document.getElementById('yeni-satis-form').addEventListener('submit', function(e) {
        e.preventDefault();

        const yeniSatis = {
            AracID: document.getElementById('arac_id').value,
            MusteriID: document.getElementById('musteri_id').value,
            SatisFiyati: document.getElementById('satis_fiyati').value
        };

        fetch('../backend/api.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(yeniSatis)
        })
        .then(res => res.json())
        .then(data => {
            alert(data.mesaj);
            if(data.durum === "basarili") {
                document.getElementById('yeni-satis-form').reset();
                satislariGetir(); 
                formVerileriniGetir(); 
            }
        });
    });
</script>