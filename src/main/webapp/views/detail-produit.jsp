<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${produit.nom} - Détails</title>
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
            transition: background-color 0.3s;
        }

        .panier-link:hover {
            background-color: #c0392b;
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

        .produit-detail {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
        }

        .produit-image-container {
            padding: 2rem;
        }

        .produit-image {
            width: 100%;
            border-radius: 10px;
            object-fit: cover;
        }

        .produit-info {
            padding: 2rem;
        }

        .produit-nom {
            font-size: 2rem;
            color: #2c3e50;
            margin-bottom: 1rem;
        }

        .produit-prix {
            font-size: 2rem;
            color: #e74c3c;
            font-weight: bold;
            margin-bottom: 1.5rem;
        }

        .produit-description {
            color: #7f8c8d;
            line-height: 1.6;
            margin-bottom: 2rem;
        }

        .produit-stock {
            margin-bottom: 2rem;
            color: #27ae60;
            font-weight: bold;
        }

        .stock-epuise {
            color: #e74c3c;
        }

        .ajouter-panier-form {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .quantite-input {
            width: 80px;
            padding: 0.8rem;
            font-size: 1rem;
            border: 2px solid #ddd;
            border-radius: 5px;
        }

        .ajouter-btn {
            flex: 1;
            padding: 1rem 2rem;
            background-color: #27ae60;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1.1rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .ajouter-btn:hover {
            background-color: #229954;
        }

        .ajouter-btn:disabled {
            background-color: #95a5a6;
            cursor: not-allowed;
        }

        @media (max-width: 768px) {
            .produit-detail {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<header>
    <div class="header-content">
        <h1><a href="${pageContext.request.contextPath}/">🛍️ Ma Boutique</a></h1>
        <a href="${pageContext.request.contextPath}/panier" class="panier-link">
            <span class="panier-icon">🛒</span>
            <span>Mon Panier</span>
        </a>
    </div>
</header>

<main>
    <a href="${pageContext.request.contextPath}/" class="retour-link">← Retour aux produits</a>

    <div class="produit-detail">
        <div class="produit-image-container">
            <img src="${produit.imageUrl}" alt="${produit.nom}" class="produit-image">
        </div>

        <div class="produit-info">
            <h1 class="produit-nom">${produit.nom}</h1>

            <div class="produit-prix">
                <fmt:formatNumber value="${produit.prix}" type="currency" currencySymbol="DH" />
            </div>

            <p class="produit-description">${produit.description}</p>

            <c:choose>
                <c:when test="${produit.stock > 0}">
                    <div class="produit-stock">
                        ✓ En stock (${produit.stock} disponibles)
                    </div>

                    <form action="${pageContext.request.contextPath}/panier" method="post" class="ajouter-panier-form">
                        <input type="hidden" name="action" value="ajouter">
                        <input type="hidden" name="produitId" value="${produit.id}">

                        <input type="number" name="quantite" value="1" min="1" max="${produit.stock}"
                               class="quantite-input" required>

                        <button type="submit" class="ajouter-btn">
                            Ajouter au panier
                        </button>
                    </form>
                </c:when>
                <c:otherwise>
                    <div class="produit-stock stock-epuise">
                        ✗ Rupture de stock
                    </div>

                    <button class="ajouter-btn" disabled>
                        Produit indisponible
                    </button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</main>
</body>
</html>1 {
font-size: 1.8rem;
}

header h