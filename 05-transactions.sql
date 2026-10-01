-- COMMIT

PRINT 'Nome do Fabricante ANTES da atualização:';
SELECT NomeFabricante FROM Fabricante WHERE IdFabricante = 1; -- Resultado esperado: Pfizer

BEGIN TRANSACTION;

    PRINT 'Atualizando o nome para "Pfizer-BioNTech"...';
    UPDATE Fabricante
    SET NomeFabricante = 'Pfizer-BioNTech'
    WHERE IdFabricante = 1;

    SELECT NomeFabricante FROM Fabricante WHERE IdFabricante = 1; -- Resultado: Pfizer-BioNTech

COMMIT TRANSACTION;

PRINT 'Nome DEPOIS do COMMIT (alteração salva):';
SELECT NomeFabricante FROM Fabricante WHERE IdFabricante = 1; -- Resultado: Pfizer-BioNTech
GO


-- ROLLBACK

PRINT 'Nome do Fabricante ANTES da atualização:';
SELECT NomeFabricante FROM Fabricante WHERE IdFabricante = 2; -- Resultado esperado: AstraZeneca

BEGIN TRANSACTION;

    PRINT 'Atualizando o nome para "AstraZeneca/Oxford"...';
    UPDATE Fabricante
    SET NomeFabricante = 'AstraZeneca/Oxford'
    WHERE IdFabricante = 2;

    PRINT 'Nome DENTRO da transação:';
    SELECT NomeFabricante FROM Fabricante WHERE IdFabricante = 2; -- Resultado: AstraZeneca/Oxford

-- Desfaz a transação, revertendo todas as alterações feitas desde o BEGIN
ROLLBACK TRANSACTION;

PRINT 'Nome DEPOIS do ROLLBACK (alteração desfeita):';
SELECT NomeFabricante FROM Fabricante WHERE IdFabricante = 2; -- Resultado: AstraZeneca
GO
