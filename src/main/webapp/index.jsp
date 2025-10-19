<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%-- Redirection vers la servlet pour charger les produits --%>
<c:if test="${empty produits}">
    <jsp:forward page="/produit" />
</c:if>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Commerce - Accueil</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .product-card {
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }
        .product-img {
            height: 250px;
            object-fit: cover;
        }
        .badge-stock {
            position: absolute;
            top: 10px;
            right: 10px;
        }
    </style>
</head>
<body>
<%@ include file="/views/include/header.jsp" %>

<div class="container my-5">
    <!-- Messages -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="success" scope="session" />
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="error" scope="session" />
    </c:if>

    <!-- Titre et recherche -->
    <div class="row mb-4">
        <div class="col-md-6">
            <h1 class="mb-0">Nos Produits</h1>
            <c:if test="${not empty keyword}">
                <p class="text-muted">Résultats pour "${keyword}"</p>
            </c:if>
        </div>
        <div class="col-md-6">
            <form action="${pageContext.request.contextPath}/produit" method="get" class="d-flex">
                <input type="hidden" name="action" value="search">
                <input type="text" name="keyword" class="form-control me-2"
                       placeholder="Rechercher un produit..." value="${keyword}">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-search"></i>
                </button>
            </form>
        </div>
    </div>

    <!-- Liste des produits -->
    <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
        <c:choose>
            <c:when test="${empty produits}">
                <div class="col-12">
                    <div class="alert alert-info text-center">
                        <i class="fas fa-info-circle fa-3x mb-3"></i>
                        <p class="mb-0">Aucun produit disponible pour le moment.</p>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="produit" items="${produits}">
                    <div class="col">
                        <div class="card product-card">
                            <div class="position-relative">
                                <c:choose>
                                    <c:when test="${not empty produit.imageUrl}">
                                        <img src="${produit.imageUrl}" class="card-img-top product-img"
                                             alt="${produit.nom}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/images/no-image.png"
                                             class="card-img-top product-img" alt="${produit.nom}">
                                    </c:otherwise>
                                </c:choose>

                                <c:if test="${produit.stock <= 5 and produit.stock > 0}">
                                    <span class="badge bg-warning badge-stock">Stock limité</span>
                                </c:if>
                                <c:if test="${produit.stock == 0}">
                                    <span class="badge bg-danger badge-stock">Rupture</span>
                                </c:if>
                            </div>

                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">${produit.nom}</h5>
                                <p class="card-text text-muted small flex-grow-1">
                                        ${produit.description.length() > 80 ?
                                                produit.description.substring(0, 80).concat('...') :
                                                produit.description}
                                </p>
                                <div class="d-flex justify-content-between align-items-center mt-2">
                                    <h4 class="text-primary mb-0">
                                        <fmt:formatNumber value="${produit.prix}" type="currency"
                                                          currencySymbol="MAD" maxFractionDigits="2"/>
                                    </h4>
                                    <a href="${pageContext.request.contextPath}/produit?id=${produit.id}"
                                       class="btn btn-sm btn-outline-primary">
                                        Voir détails
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="/views/include/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>