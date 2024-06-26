
IF OBJECT_ID('vw_BireyselMusteriBilgileri') IS NOT NULL
BEGIN
    DROP VIEW vw_BireyselMusteriBilgileri
END
	  
GO
CREATE VIEW vw_BireyselMusteriBilgileri
AS 
  SELECT 
      bm.Ad AS [Müþteri Adý],
	  bm.Soyad AS [Müþteri Soyadý],
	  FORMAT(bm.DogumTarihi, 'dd/MM/yyyy') AS [Formatlý Doðum Tarihi],
	  DATEDIFF(YEAR, bm.DogumTarihi,Getdate()) AS Yas,
	  K.ID AS KartId,
	  k.KartTuru,
	  dbo.Taksitlendir(k.ID) AS TaksitSecenekleri,
	  CASE 
	     WHEN k.SonKullanmaTarih>Getdate() Then 'Aktif'
		 ELSE 'Pasif'
	  END AS KartDurumu
   FROM  Kart k INNER JOIN Musteri m ON k.MusteriID=m.ID
                INNER JOIN BireyselMusteri bm ON bm.MusteriID=m.ID;
				
	
-- vw_BireyselMusteriBilgileri view'ýný JOIN iþlemleri içeren bir test sorgusu
SELECT 
    bmb.[Müþteri Adý],
    bmb.[Müþteri Soyadý],
    bmb.[Formatlý Doðum Tarihi],
    bmb.Yas,
    bmb.KartId,
    bmb.KartTuru,
    bmb.TaksitSecenekleri,
    bmb.KartDurumu,
    a.IckapiNo,
    a.DisKapiNo,
    a.Aciklama,
    u.UlkeAdi,
    il.IlAd,
    ilce.IlceAd,
    mahalle.MahalleAd,
    sokak.SokakAd,
    h.IbanNo,
    h.Bakiye,
    h.AcilisTarih,
    h.KapanisTarih,
    d.DovizCinsi,
    ht.HesapTurAd
FROM  
    vw_BireyselMusteriBilgileri bmb
INNER JOIN Kart k ON bmb.KartId = k.ID
INNER JOIN Hesap h ON k.HesapID = h.ID
INNER JOIN Adres a ON h.ID = a.ID
INNER JOIN Ulke u ON a.UlkeID = u.ID
INNER JOIN Il il ON a.IlID = il.ID
INNER JOIN Ilce ilce ON a.IlceID = ilce.ID
INNER JOIN Mahalle mahalle ON a.MahalleID = mahalle.ID
INNER JOIN Sokak sokak ON a.SokakID = sokak.ID
INNER JOIN Doviz d ON h.DovizID = d.ID
INNER JOIN HesapTuru ht ON h.HesapTuruID = ht.ID;





