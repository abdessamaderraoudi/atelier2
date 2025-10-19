<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Panier</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }

        header {
            background-color: #2c3e50;
            color: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h1 a {
            color: white;
            text-decoration: none;
            font-size: 1.8rem;
        }

        .panier-link {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: white;
            text-decoration: none;
            background-color: #e74c3c;
            padding: 0.7rem 1.5rem;
            border-radius: 5px;
        }

        .panier-icon {
            font-size: 1.5rem;
        }

        main {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .retour-link {
            display: inline-block;
            margin-bottom: 2rem;
            color: #3498db;
            text-decoration: none;
            font-size: 1rem;
        }

        .retour-link:hover {
            text-decoration: underline;
        }

        h2 {
            color: #2c3e50;
            margin-bottom: 2rem;
        }

        .panier-vide {
            background: white;
            padding: 3rem;
            border-radius: 10px;
            text-align: center;
            color: #7f8c8d;
        }

        .panier-vide-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
        }

        .continuer-btn {
            display: inline-block;
            margin-top: 1rem;
            padding: 1rem 2rem;
            background-color: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .continuer-btn:hover {
            background-color: #2980b9;
        }

        .panier-contenu {
            background: white;
            border-radius: 10px;
            padding: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .ligne-panier {
            display: grid;
            grid-template-columns: 100px 1fr 150px 100px 100px 50px;
            gap: 1.5rem;
            align-items: center;
            padding: 1.5rem 0;
            border-bottom: 1px solid #ecf0f1;
        }

        .ligne-panier:last-child {
            border-bottom: none;
        }

        .ligne-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
        }

        .ligne-nom {
            font-weight: bold;
            color: #2c3e50;
        }

        .ligne-prix {
            color: #e74c3c;
            font-weight: bold;
            font-size: 1.1rem;
        }

        .ligne-quantite {
            text-align: center;
            color: #7f8c8d;
        }

        .ligne-total {
            color: #27ae60;
            font-weight: bold;
            font-size: 1.1rem;
        }

        .supprimer-btn {
            background: none;
            border: none;
            color: #e74c3c;
            font-size: 1.5rem;
            cursor: pointer;
            transition: transform 0.2s;
        }

        .supprimer-btn:hover {
            transform: scale(1.2);
        }

        .panier-resume {
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 2px solid #ecf0f1;
            text-align: right;
        }

        .total-general {
            font-size: 1.8rem;
            color: #2c3e50;
            font-weight: bold;
            margin-bottom: 1.5rem;
        }

        .total-montant {
            color: #27ae60;
        }

        .commander-btn {
            padding: 1rem 3rem;
            background-color: #27ae60;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .commander-btn:hover {
            background-color: #229954;
        }

        @media (max-width: 768px) {
            .ligne-panier {
                grid-template-columns: 1fr;
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
<header>
    <div class="header-content">
        <h1><a href="${pageContext.request.contextPath}/">🛍️ Ma Boutique</a></h1>
        <div class="panier-link">
            <span class="panier-icon">🛒</span>
            <span>Mon Panier</span>
        </div>
    </div>
</header>

<main>
    <a href="${pageContext.request.contextPath}/" class="retour-link">← Continuer mes achats</a>

    <h2>Mon Panier</h2>

    <c:choose>
        <c:when test="${empty panier or empty panier.lignes}">
            <div class="panier-vide">
                <div class="panier-vide-icon">🛒</div>
                <h3>Votre panier est vide</h3>
                <p>Découvrez nos produits et ajoutez-les à votre panier</p>
                <a href="${pageContext.request.contextPath}/" class="continuer-btn">
                    Voir les produits
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="panier-contenu">
                <c:set var="total" value="0" />

                <c:forEach var="ligne" items="${panier.lignes}">
                    <div class="ligne-panier">
                        <img src="${ligne.produit.imageUrl}" alt="${ligne.produit.nom}" class="ligne-image">

                        <div class="ligne-nom">${ligne.produit.nom}</div>

                        <div class="ligne-prix">
                            <fmt:formatNumber value="${ligne.produit.prix}" type="currency" currencySymbol="DH" />
                        </div>

                        <div class="ligne-quantite">
                            Quantité: ${ligne.quantite}
                        </div>

                        <div class="ligne-total">
                            <c:set var="ligneTotal" value="${ligne.produit.prix * ligne.quantite}" />
                            <fmt:formatNumber value="${ligneTotal}" type="currency" currencySymbol="DH" />
                            <c:set var="total" value="${total + ligneTotal}" />
                        </div>

                        <form action="${pageContext.request.contextPath}/panier" method="post" style="margin: 0;">
                            <input type="hidden" name="action" value="supprimer">
                            <input type="hidden" name="ligneId" value="${ligne.id}">
                            <button type="submit" class="supprimer-btn" title="Supprimer">🗑️</button>
                        </form>
                    </div>
                </c:forEach>

                <div class="panier-resume">
                    <div class="total-general">
                        Total: <span class="total-montant">
                                <fmt:formatNumber value="${total}" type="currency" currencySymbol="DH" />
                            </span>
                    </div>
                    <button class="commander-btn" onclick="alert('Fonctionnalité de commande à implémenter')">
                        Passer la commande
                    </button>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</main>
</body>
</html>