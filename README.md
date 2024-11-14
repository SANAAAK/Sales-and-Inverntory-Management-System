# 📊 **Order Management System Database**  

## 🌟 **Objectif**  
Ce projet vise à concevoir et implémenter une base de données relationnelle pour un système de gestion des commandes. Il contient des données sur les catégories, les clients, les commandes, les employés, les fournisseurs et les produits.  

---

## 🗂️ **Schéma de la Base de Données**  
### Tables principales :  
1. **📦 CATEGORIES**  
   - `CATEGORY_CODE`, `CATEGORY_NAME`, `DESCRIPTION`
2. **👥 CUSTOMERS**  
   - `CUSTOMER_CODE`, `COMPANY`, `ADDRESS`, `CITY`, `POSTAL_CODE`, `COUNTRY`, `PHONE`, `FAX`
3. **🛒 ORDERS**  
   - `ORDER_NUMBER`, `CUSTOMER_CODE#`, `EMPLOYEE_NUMBER#`, `ORDER_DATE`, `SHIP_DATE`, `SHIPPING_COST`
4. **📋 ORDER_DETAILS**  
   - `ORDER_NUMBER#`, `PRODUCT_REF#`, `UNIT_PRICE`, `QUANTITY`, `DISCOUNT`
5. **🧑‍💼 EMPLOYEES**  
   - `EMPLOYEE_NUMBER`, `REPORTS_TO#`, `LAST_NAME`, `FIRST_NAME`, `POSITION`, `TITLE`, `BIRTH_DATE`, `HIRE_DATE`, `SALARY`, `COMMISSION`
6. **🏭 SUPPLIERS**  
   - `SUPPLIER_NUMBER`, `COMPANY`, `ADDRESS`, `CITY`, `POSTAL_CODE`, `COUNTRY`, `PHONE`, `FAX`
7. **🛍️ PRODUCTS**  
   - `PRODUCT_REF`, `PRODUCT_NAME`, `SUPPLIER_NUMBER#`, `CATEGORY_CODE#`, `QUANTITY`, `UNIT_PRICE`, `UNITS_IN_STOCK`, `UNITS_ON_ORDER`, `UNAVAILABLE`

---

## 🛠️ **Requêtes SQL Implémentées**  

1. **👨‍💼 Affichage des employés masculins avec un salaire net ≥ 8000**  
   - 📑 Colonnes : Numéro d'employé, Prénom, Nom (formaté), Âge, Ancienneté.

2. **🍾 Produits répondant aux critères suivants :**  
   - Emballage : bouteille(s).  
   - Le 3e caractère du nom est "t" ou "T".  
   - Fournisseurs : 1, 2 ou 3.  
   - Prix unitaire : entre 70 et 200.  
   - Unités commandées : spécifiées (non null).  
   - 📑 Colonnes : Référence produit, Nom produit, Numéro fournisseur, Unités commandées, Prix unitaire.

3. **🌍 Clients dans la même région que le fournisseur 1**  
   - Critères : même pays, ville, et 3 derniers chiffres du code postal.  
   - 📑 Colonnes : Toutes les colonnes de la table `CUSTOMERS`.

4. **📉 Nouveau taux de remise pour les commandes 10998 à 11003**  
   - Taux basé sur le montant total avant remise.  
   - Message : "appliquer ancien taux" (si numéro entre 10000 et 10999), sinon "appliquer nouveau taux".  
   - 📑 Colonnes : Numéro commande, Nouveau taux, Note.

5. **🥤 Fournisseurs de boissons**  
   - 📑 Colonnes : Numéro fournisseur, Société, Adresse, Téléphone.

6. **🍰 Clients de Berlin ayant commandé au maximum 1 dessert**  
   - 📑 Colonnes : Code client.

7. **📅 Commandes des clients français chaque lundi d’avril 1998**  
   - Inclut les clients sans commandes.  
   - 📑 Colonnes : Numéro client, Société, Téléphone, Montant total, Pays.

8. **📦 Clients ayant commandé tous les produits**  
   - 📑 Colonnes : Code client, Société, Téléphone.

9. **📈 Nombre de commandes par client (France)**  
   - 📑 Colonnes : Code client, Nombre de commandes.

10. **🗓️ Commandes placées en 1996 vs 1997**  
    - Différence entre les deux années.  
    - 📑 Colonnes : Commandes 1996, Commandes 1997, Différence.

---
