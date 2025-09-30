/* 1. Sélectionner tous les employés (codeEmpl, nom, salaire) triés par nom et par ordre alphabétique */

SELECT codeEmpl, nom, salaire
FROM employe
ORDER BY nom ASC;


/* 2. Sélectionner tous les employés (codeEmpl, nom, salaire) avec, pour chaque employé, le nom du rayon dans lequel il travaille */

SELECT codeEmpl, nom, salaire, nomR
FROM employe;

/* 3. Sélectionner tous les fournisseurs (codeFourn, nom) et le nombre de produits qu'ils fournissent, triés par nombre de produits décroissant */

SELECT fournisseurs.codeF, fournisseurs.nomF, COUNT(codeA) AS "Nombre de produit"
FROM fournisseurs
INNER JOIN ligne_bon_de_livraion
ON fournisseurs.codeF = ligne_bon_de_livraion.codeF
GROUP BY fournisseurs.codeF, fournisseurs.nomF;
ORDER BY codeA DESC;

/* 4. Sélectionner le nom des produits, leur prix, et le nom du fournisseur associé */

SELECT articles.codeA, articles.nomA, fournisseurs.nomF
FROM articles
INNER JOIN ligne_bon_de_livraion
ON articles.codeA = ligne_bon_de_livraion.codeA
INNER JOIN fournisseurs
ON ligne_bon_de_livraion.codeF = fournisseurs.codeF
GROUP BY articles.nomA;



/* 5. Sélectionner le nom des produits, leur prix, et le nom du fournisseur pour chaque produit dont le prix est supérieur à la moyenne des prix des produits */



/* 6. Sélectionner tous les employés (codeEmpl, nom). Pour chaque employé, indiquer le nom du rayon, le nombre d'articles associés au rayon */

SELECT employe.codeEmpl, employe.nom, employe.nomR, 
FROM employe
INNER JOIN rayon
ON employe.nomR = rayon.nomR

;


/* 7. Sélectionner tous les articles (codeA, nomA). Pour chaque article, indiquer le nombre de livraisons et la quantité totale livrée. */

/*8. Sélectionner tous les articles (codeA, nomA). Pour chaque article, indiquer le nom du fournisseur, le nom et l'étage du rayon où il est stocké, et l'employé qui y travaille (codeEmpl, nom). */