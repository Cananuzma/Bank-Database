-- Bu stored procedure, m��terinin hesap bilgilerini g�ncellerken bir i�lem kayd� ekler

IF OBJECT_ID('sp_MusteriHesapBilgisiIslemleri') IS NOT NULL
BEGIN
    DROP PROCEDURE sp_MusteriHesapBilgisiIslemleri
END
	  
GO
CREATE PROCEDURE sp_MusteriHesapBilgisiIslemleri
    @MusteriID INT,
    @HesapBakiye MONEY,
    @IslemTuruAd VARCHAR(20),
    @YeniBakiye MONEY OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRANSACTION;

    
    BEGIN TRY
        
        DECLARE @IslemTuruID INT
        SELECT @IslemTuruID = ID FROM IslemTuru WHERE Ad = @IslemTuruAd

        UPDATE Hesap
        SET Bakiye = @HesapBakiye
        WHERE MusteriID = @MusteriID;

        
        INSERT INTO Islem (HareketTipi, IslemTarihi, AliciIban, Tutar, Aciklama, HesapID, IslemTuru)
        VALUES (1, GETDATE(), '', @HesapBakiye, 'Hesap G�ncelleme', @MusteriID, @IslemTuruID);

       
        SELECT @YeniBakiye = Bakiye FROM Hesap WHERE MusteriID = @MusteriID;

        
        COMMIT;
    END TRY
    BEGIN CATCH
        
        ROLLBACK;
    END CATCH;
END;


--cag�rma

DECLARE @YeniBakiye MONEY;

EXEC sp_MusteriHesapBilgisiIslemleri
    @MusteriID = 1,
    @HesapBakiye = 100.00,
    @IslemTuruAd = 'Para Yat�rma',
    @YeniBakiye = @YeniBakiye OUTPUT;


SELECT @YeniBakiye AS YeniBakiye;

