<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${produit.nom} - E-Commerce</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .product-image {
            max-height: 500px;
            object-fit: contain;
        }
    </style>
</head>
<body>
<%@ include file="/views/include/header.jsp" %>

<div class="container my-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/">Accueil</a>
            </li>
            <li class="breadcrumb-item active">${produit.nom}</li>
        </ol>
    </nav>

    <div class="row">
        <!-- Image du produit -->
        <div class="col-md-6 mb-4">
            <div class="card">
                <c:choose>
                    <c:when test="${not empty produit.imageUrl}">
                        <img src="${produit.imageUrl}" class="card-img-top product-image"
                             alt="${produit.nom}">
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/images/no-image.png"
                             class="card-img-top product-image" alt="${produit.nom}">
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Informations du produit -->
        <div class="col-md-6">
            <h1 class="mb-3">${produit.nom}</h1>

            <c:if test="${not empty produit.categorie}">
                <span class="badge bg-secondary mb-3">${produit.categorie}</span>
            </c:if>

            <h2 class="text-primary mb-4">
                <fmt:formatNumber value="${produit.prix}" type="currency"
                                  currencySymbol="MAD" maxFractionDigits="2"/>
            </h2>

            <div class="mb-4">
                <h5>Description</h5>
                <p class="text-muted">${produit.description}</p>
            </div>

            <div class="mb-4">
                <h5>Disponibilité</h5>
                <c:choose>
                    <c:when test="${produit.stock > 5}">
                            <span class="badge bg-success">
                                <i class="fas fa-check-circle"></i> En stock (${produit.stock} disponibles)
                            </span>
                    </c:when>
                    <c:when test="${produit.stock > 0}">
                            <span class="badge bg-warning">
                                <i class="fas fa-exclamation-triangle"></i> Stock limité (${produit.stock} restants)
                            </span>
                    </c:when>
                    <c:otherwise>
                            <span class="badge bg-danger">
                                <i class="fas fa-times-circle"></i> Rupture de stock
                            </span>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Formulaire d'ajout au panier -->
            <c:choose>
                <c:when test="${not empty sessionScope.internaute}">
                    <c:if test="${produit.stock > 0}">
                        <form action="${pageContext.request.contextPath}/panier" method="post">
                            <input type="hidden" name="action" value="ajouter">
                            <input type="hidden" name="produitId" value="${produit.id}">

                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label for="quantite" class="form-label">Quantité</label>
                                    <input type="number" class="form-control" id="quantite"
                                           name="quantite" value="1" min="1" max="${produit.stock}" required>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="fas fa-cart-plus"></i> Ajouter au panier
                            </button>
                        </form>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i>
                        Veuillez vous <a href="${pageContext.request.contextPath}/internaute?action=login">connecter</a>
                        pour ajouter ce produit à votre panier.
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left"></i> Retour aux produits
                </a>
            </div>
        </div>
    </div>
</div>

<%@ include file="/views/include/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>