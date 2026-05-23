<style>
    .musteri-formu input, .musteri-formu select { padding: 8px; margin: 5px 5px 15px 0; border: 1px solid #ccc; border-radius: 4px; }
    .musteri-formu button { padding: 9px 15px; background-color: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; }
    .musteri-formu button:hover { background-color: #218838; }
    .musteri-karti { border-left: 4px solid #28a745; padding: 15px; margin-bottom: 15px; background: white; box-shadow: 0 1px 2px rgba(0,0,0,0.1); }
</style>

<h2>Müşteri İlişkileri</h2>

<div class="card musteri-formu">
    <h3>Yeni Müşteri Kaydı</h3>
    <form id="yeni-musteri-form">
        
        <input type="text" id="ad_soyad" placeholder="Ad Soyad" required>
        <input type="text" id="tc_kimlik" placeholder="TC Kimlik No (11 Hane)" maxlength="11" required>
        <input type="text" id="telefon" placeholder="Telefon (Örn: 05xx)" required>
        
        <select id="musteri_tipi" required>
            <option value="Bireysel">Bireysel</option>
            <option value="Kurumsal">Kurumsal</option>
        </select>
        
        <button type="submit">Müşteriyi Kaydet</button>
    </form>
</div>

<h3>Kayıtlı Müşteriler</h3>
<div id="musteri-listesi-kutu">
    <p>Müşteriler yükleniyor...</p>
</div>

<script>
    function musterileriGetir() {
        fetch('../backend/api.php?tip=musteriler')
            .then(res => res.json())
            .then(data => {
                const listeDiv = document.getElementById('musteri-listesi-kutu');
                listeDiv.innerHTML = ''; 

                data.forEach(musteri => {
                    listeDiv.innerHTML += `
                        <div class="musteri-karti">
                            <h4 style="margin:0 0 10px 0;">${musteri.AdSoyad} <span style="font-size: 14px; color: gray;">(${musteri.MusteriTipi})</span></h4>
                            <p style="margin:0; font-size:14px;">
                                <strong>TC Kimlik:</strong> ${musteri.TCKimlik} | 
                                <strong>Telefon:</strong> ${musteri.Telefon}
                            </p>
                        </div>
                    `;
                });
            });
    }

    musterileriGetir();

    // Yeni Müşteri Ekleme Formu
    document.getElementById('yeni-musteri-form').addEventListener('submit', function(e) {
        e.preventDefault();

        const yeniMusteri = {
            AdSoyad: document.getElementById('ad_soyad').value,
            TCKimlik: document.getElementById('tc_kimlik').value,
            Telefon: document.getElementById('telefon').value,
            MusteriTipi: document.getElementById('musteri_tipi').value
        };

        fetch('../backend/api.php', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(yeniMusteri)
        })
        .then(res => res.json())
        .then(data => {
            alert(data.mesaj);
            if(data.durum === "basarili") {
                document.getElementById('yeni-musteri-form').reset();
                musterileriGetir(); 
            }
        });
    });
</script>