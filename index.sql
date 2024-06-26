use Banka

IF OBJECT_ID('IX_BireyselM�steriBilgi') IS NOT NULL
	BEGIN	
		DROP INDEX IX_BireyselM�steriBilgi ON BireyselM�steri
	END
GO


SET STATISTICS IO ON
SET STATISTICS TIME ON

SELECT Ad + ' ' + SoyAd [Ad Soyad], CONVERT(CHAR(10),DogumTarihi,103) AS [Do�um Tarihi] FROM BireyselMusteri


CREATE NONCLUSTERED INDEX IX_BireyselM�steriBilgi ON BireyselMusteri(Ad,SoyAd,DogumTarihi)