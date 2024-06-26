--Girilen Kart Id'sine g�re taksit se�ene�ini d�nd�ren fonksiyon
CREATE OR ALTER FUNCTION Taksitlendir (@KartId INT)  
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @TaksitSecenekleri VARCHAR(100);
    
    SELECT @TaksitSecenekleri = 
        CASE 
            WHEN KartTuru = 'Banka Kart�' THEN 'Tek Cekim'
            WHEN KartTuru = 'Kredi Kart�' THEN '9 Taksit'
            WHEN KartTuru = 'Gift Kart' THEN '3 Taksit'
            ELSE 'UNDEFINED'
        END
    FROM Kart 
    WHERE ID = @KartId;

    RETURN @TaksitSecenekleri;
END;

-- Fonksiyonu �a��rmak i�in SELECT kullan�l�r.
SELECT dbo.Taksitlendir(3);
