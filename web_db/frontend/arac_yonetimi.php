<style>
    .arac-formu input, .arac-formu select { padding: 8px; margin: 5px 5px 15px 0; border: 1px solid #ccc; border-radius: 4px; }
    .arac-formu button { padding: 9px 15px; background-color: #3c8dbc; color: white; border: none; border-radius: 4px; cursor: pointer; }
    .arac-formu button:hover { background-color: #367fa9; }
    .arac-karti { border-left: 4px solid #3c8dbc; padding: 15px; margin-bottom: 15px; background: white; box-shadow: 0 1px 2px rgba(0,0,0,0.1); }
</style>

<h2>Araç Yönetimi</h2>

<div class="card arac-formu">
    <h3>Yeni Araç Ekle</h3>
    <form id="yeni-arac-form">
        
        <select id="sube_id" required>
            <option value="">Şube Seçiniz...</option>
        </select>
        
        <select id="marka_id" required>
            <option value="">Marka Seçiniz...</option>
        </select>

        <input type="text" id="model" placeholder="Model (Örn: X5)" required>
        <input type="text" id="sasi_no" placeholder="Şasi No" required>
        <input type="number" id="yil" placeholder="Yıl" required>
        <input type="number" id="fiyat" placeholder="Fiyat (TL)" required>
        
        <button type="submit">Sisteme Ekle</button>
    </form>
</div>

<h3>Sistemdeki Araçlar</h3>
<div id="arac-listesi-kutu">
    <p>Araçlar yükleniyor...</p>
</div>

<script>
    // 1. Veritabanındaki Şubeleri Çekip Select Kutusuna Doldurma
    function subeleriGetir() {
        fetch('../backend/api.php?tip=subeler')
            .then(res => res.json())
            .then(data => {
                const subeSelect = document.getElementById('sube_id');
                data.forEach(sube => {
                    subeSelect.innerHTML += `<option value="${sube.SubeID}">${sube.SubeAdi} (${sube.Sehir})</option>`;
                });
            });
    }

    // 2. Veritabanındaki Markaları Çekip Select Kutusuna Doldurma
    function markalariGetir() {
        fetch('../backend/api.php?tip=markalar')
            .then(res => res.json())
            .then(data => {
                const markaSelect = document.getElementById('marka_id');
                data.forEach(marka => {
                    markaSelect.innerHTML += `<option value="${marka.MarkaID}">${marka.MarkaAdi}</option>`;
                });
            });
    }

    // 3. Sistemdeki Aktif Araçları Listeleme
    function araclariGetir() {
        fetch('../backend/api.php?tip=araclar')
            .then(res => res.json())
            .then(data => {
                const listeDiv = document.getElementById('arac-listesi-kutu');
                listeDiv.innerHTML = ''; 

                data.forEach(arac => {
                    listeDiv.innerHTML += `
                        <div class="arac-karti">
                            <h4 style="margin:0 0 10px 0;">${arac.MarkaAdi} ${arac.Model} (${arac.Yil})</h4>
                            <p style="margin:0; font-size:14px;">
                                <strong>Fiyat:</strong> ${arac.Fiyat} TL | 
                                <strong>Durum:</strong> ${arac.Durum} | 
                                <strong>Şasi:</strong> ${arac.SasiNo} |
                                <strong>Şube:</strong> ${arac.SubeAdi} (${arac.Sehir})
                            </p>
                        </div>
                    `;
                });
            });
    }

    subeleriGetir();
    markalariGetir();
    araclariGetir();

    // 4. Yeni Araç Ekleme Formu
    document.getElementById('yeni-arac-form').addEventListener('submit', function(e) {
        e.preventDefault();

        const yeniArac = {
            SubeID: document.getElementById('sube_id').value,
            MarkaID: document.getElementById('marka_id').value,
            Model: document.getElementById('model').value,
            SasiNo: document.getElementById('sasi_no').value,
            Yil: document.getElementById('yil').value,
            Fiyat: document.getElementById('fiyat').value,
            Durum: "Satışta" 
        };

        fetch('../backend/api.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(yeniArac)
        })
        .then(res => res.json())
        .then(data => {
            alert(data.mesaj);
            if(data.durum === "basarili") {
                document.getElementById('yeni-arac-form').reset();
                araclariGetir(); 
        });
    });
function araclariGetir() {
        fetch('../backend/api.php?tip=araclar')
            .then(res => res.json())
            .then(data => {
                const listeDiv = document.getElementById('arac-listesi-kutu');
                listeDiv.innerHTML = ''; 

                data.forEach(arac => {
                    listeDiv.innerHTML += `
                        <div class="arac-karti">
                            <h4 style="margin:0 0 10px 0;">${arac.MarkaAdi} ${arac.Model} (${arac.Yil})</h4>
                            <p style="margin:0; font-size:14px;">
                                <strong>Fiyat:</strong> ${arac.Fiyat} TL | 
                                <strong>Durum:</strong> ${arac.Durum} | 
                                <strong>Şasi:</strong> ${arac.SasiNo} |
                                <strong>Şube:</strong> ${arac.SubeAdi}
                            </p>
                            <button onclick="aracSil(${arac.AracID})" style="margin-top:10px; background-color:#e74c3c; color:white; border:none; padding:6px 12px; border-radius:4px; cursor:pointer;">Sistemden Sil</button>
                        </div>
                    `;
                });
            });
    }
    function aracSil(id) {
        if(confirm('Bu aracı sistemden kalıcı olarak silmek istediğinize emin misiniz?')) {
            fetch('../backend/api.php?id=' + id, {
                method: 'DELETE'
            })
            .then(res => res.json())
            .then(data => {
                alert(data.mesaj); 
                if(data.durum === 'basarili') {
                    araclariGetir(); 
                }
            })
            .catch(error => console.error('Hata:', error));
        }
    }        
</script>