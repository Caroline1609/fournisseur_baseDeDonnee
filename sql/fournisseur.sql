/* corrige le nom de la table */
-- ligne_bon_de_livraion --> ligne_bon_de_livraison
-- ALTER TABLE ligne_bon_de_livraion RENAME ligne_bon_de_livraison;
-- SHOW TABLES;


/* 1. Tous les employés triés par nom */
SELECT codeEmpl, nom, salaire
FROM employe 
ORDER BY nom ASC;


/* 2. Employés avec leur rayon */
SELECT codeEmpl, nom, salaire, nomR 
FROM employe;


/* 3. Fournisseurs et nb de produits */
SELECT 
    fournisseurs.codeF, 
    nomF, 
    COUNT(ligne_bon_de_livraison.codeF) AS nb_produits
FROM fournisseurs
INNER JOIN ligne_bon_de_livraison 
    ON ligne_bon_de_livraison.codeF = fournisseurs.codeF
GROUP BY fournisseurs.codeF
ORDER BY nb_produits DESC;


/* AJOUTER LA COLONNE PRIX (sécurisé) */
ALTER TABLE articles ADD COLUMN IF NOT EXISTS prix DECIMAL(5,2) NOT NULL DEFAULT '0';


/* Mise à jour des prix */
UPDATE articles SET prix=120 WHERE codeA='A0000001';
UPDATE articles SET prix=50  WHERE codeA='A0000002';
UPDATE articles SET prix=10  WHERE codeA='A0000003';
UPDATE articles SET prix=1   WHERE codeA='A0000004';
UPDATE articles SET prix=12  WHERE codeA='A0000005';
UPDATE articles SET prix=500 WHERE codeA='A0000006';
UPDATE articles SET prix=20  WHERE codeA='A0000007';
UPDATE articles SET prix=40  WHERE codeA='A0000008';
UPDATE articles SET prix=1.5 WHERE codeA='A0000009';
UPDATE articles SET prix=3   WHERE codeA='A0000010';


/* 4. Produits, prix et fournisseur associé */
SELECT nomA, prix, nomF
FROM articles AS TA 
INNER JOIN ligne_bon_de_livraison AS TL ON TL.codeA = TA.codeA 
INNER JOIN fournisseurs AS TF ON TL.codeF = TF.codeF;


/* 5. Produits > moyenne des prix */
SELECT nomA, prix, nomF
FROM articles AS TA 
INNER JOIN ligne_bon_de_livraison AS TL ON TL.codeA = TA.codeA 
INNER JOIN fournisseurs AS TF ON TL.codeF = TF.codeF 
WHERE prix > (SELECT AVG(prix) FROM articles);


/* 6. Employés avec rayon et nb articles */
SELECT codeEmpl, nom, rayon.nomR, COUNT(codeA) 
FROM employe 
INNER JOIN rayon ON employe.nomR = rayon.nomR 
INNER JOIN articles ON rayon.nomR = articles.nomR
GROUP BY codeEmpl, rayon.nomR, nom;


/* 7. Articles avec nb livraisons et qté totale */
SELECT articles.codeA, nomA, COUNT(ligne_bon_de_livraison.codeA) AS nb_livraisons, SUM(quantité) AS total_quantite
FROM ligne_bon_de_livraison 
JOIN articles ON ligne_bon_de_livraison.codeA = articles.codeA 
GROUP BY articles.codeA, nomA;


/* 8. Articles avec fournisseurs, rayon et employé */
SELECT 
articles.codeA, 
nomA, 
GROUP_CONCAT(nomF), 
rayon.nomR, 
etage, 
codeEmpl, 
nom 
FROM articles 
INNER JOIN ligne_bon_de_livraison ON ligne_bon_de_livraison.codeA = articles.codeA 
INNER JOIN fournisseurs ON fournisseurs.codeF = ligne_bon_de_livraison.codeF
INNER JOIN rayon ON rayon.nomR = articles.nomR 
INNER JOIN employe ON employe.nomR = rayon.nomR
;






/*
SELECT CONCAT(codeA, '-', nomA, ' ', nomR) FROM articles;


SELECT CONCAT(codeA, '-', nomA, ' ', (SELECT etage FROM rayon WHERE rayon.nomR = articles.nomR)) FROM articles;




SELECT CONCAT('Bonjour', ' ', 'les', ' ', 'DWWM');
*/