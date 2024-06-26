--Girilen Kart Id'sine göre taksit seçeneðini döndüren fonksiyon
CREATE OR ALTER FUNCTION Taksitlendir (@KartId INT)  
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @TaksitSecenekleri VARCHAR(100);
    
    SELECT @TaksitSecenekleri = 
        CASE 
            WHEN KartTuru = 'Banka Kartý' THEN 'Tek Cekim'
            WHEN KartTuru = 'Kredi Kartý' THEN '9 Taksit'
            WHEN KartTuru = 'Gift Kart' THEN '3 Taksit'
            ELSE 'UNDEFINED'
        END
    FROM Kart 
    WHERE ID = @KartId;

    RETURN @TaksitSecenekleri;
END;

-- Fonksiyonu çaðýrmak için SELECT kullanýlýr.
SELECT dbo.Taksitlendir(3);
