use Banka

IF OBJECT_ID('IX_BireyselMüsteriBilgi') IS NOT NULL
	BEGIN	
		DROP INDEX IX_BireyselMüsteriBilgi ON BireyselMüsteri
	END
GO


SET STATISTICS IO ON
SET STATISTICS TIME ON

SELECT Ad + ' ' + SoyAd [Ad Soyad], CONVERT(CHAR(10),DogumTarihi,103) AS [Doðum Tarihi] FROM BireyselMusteri


CREATE NONCLUSTERED INDEX IX_BireyselMüsteriBilgi ON BireyselMusteri(Ad,SoyAd,DogumTarihi)