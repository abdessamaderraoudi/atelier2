<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Panier - E-Commerce</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<%@ include file="/views/include/header.jsp" %>

<div class="container my-5">
    <h1 class="mb-4">
        <i class="fas fa-shopping-cart"></i> Mon Panier
    </h1>

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

    <c:choose>
        <c:when test="${empty panier.lignes}">
            <div class="alert alert-info text-center">
                <i class="fas fa-shopping-cart fa-3x mb-3"></i>
                <h4>Votre panier est vide</h4>
                <p>Découvrez nos produits et ajoutez-les à votre panier !</p>
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                    <i class="fas fa-shopping-bag"></i> Continuer mes achats
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="row">
                <div class="col-lg-8">
                    <div class="card mb-4">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">Articles (${panier.nombreArticles})</h5>
                        </div>
                        <div class="card-body">
                            <c:forEach var="ligne" items="${panier.lignes}">
                                <div class="row mb-3 pb-3 border-bottom">
                                    <div class="col-md-2">
                                        <c:choose>
                                            <c:when test="${not empty ligne.produit.imageUrl}">
                                                <img src="${ligne.produit.imageUrl}"
                                                     class="img-fluid rounded"
                                                     alt="${ligne.produit.nom}">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/images/no-image.png"
                                                     class="img-fluid rounded"
                                                     alt="${ligne.produit.nom}">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <div class="col-md-4">
                                        <h5>${ligne.produit.nom}</h5>
                                        <p class="text-muted small">${ligne.produit.description}</p>
                                    </div>

                                    <div class="col-md-2">
                                        <form action="${pageContext.request.contextPath}/panier"
                                              method="post" class="d-inline">
                                            <input type="hidden" name="action" value="modifier">
                                            <input type="hidden" name="ligneId" value="${ligne.id}">
                                            <div class="input-group input-group-sm">
                                                <input type="number" class="form-control" name="quantite"
                                                       value="${ligne.quantite}" min="1"
                                                       max="${ligne.produit.stock}">
                                                <button type="submit" class="btn btn-outline-secondary">
                                                    <i class="fas fa-sync"></i>
                                                </button>
                                            </div>
                                        </form>
                                    </div>

                                    <div class="col-md-2 text-end">
                                        <p class="mb-1">
                                            <fmt:formatNumber value="${ligne.prixUnitaire}"
                                                              type="currency" currencySymbol="MAD"
                                                              maxFractionDigits="2"/>
                                        </p>
                                        <p class="text-muted small">Prix unitaire</p>
                                    </div>

                                    <div class="col-md-2 text-end">
                                        <h5 class="text-primary">
                                            <fmt:formatNumber value="${ligne.sousTotal}"
                                                              type="currency" currencySymbol="MAD"
                                                              maxFractionDigits="2"/>
                                        </h5>
                                        <form action="${pageContext.request.contextPath}/panier"
                                              method="post" class="d-inline">
                                            <input type="hidden" name="action" value="retirer">
                                            <input type="hidden" name="ligneId" value="${ligne.id}">
                                            <button type="submit" class="btn btn-sm btn-outline-danger"
                                                    onclick="return confirm('Voulez-vous retirer ce produit ?');">
                                                <i class="fas fa-trash"></i> Retirer
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <a href="${pageContext.request.contextPath}/" class="btn btn-outline-primary">
                        <i class="fas fa-arrow-left"></i> Continuer mes achats
                    </a>
                </div>

                <!-- Résumé du panier -->
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-header bg-primary text-white">
                            <h5 class="mb-0">Résumé</h5>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between mb-3">
                                <span>Nombre d'articles:</span>
                                <strong>${panier.nombreArticles}</strong>
                            </div>

                            <hr>

                            <div class="d-flex justify-content-between mb-3">
                                <h5>Total:</h5>
                                <h5 class="text-primary">
                                    <fmt:formatNumber value="${panier.total}"
                                                      type="currency" currencySymbol="MAD"
                                                      maxFractionDigits="2"/>
                                </h5>
                            </div>

                            <button class="btn btn-success w-100 mb-2" disabled>
                                <i class="fas fa-credit-card"></i> Passer la commande
                            </button>
                            <small class="text-muted d-block text-center">
                                (Fonction disponible prochainement)
                            </small>

                            <hr>

                            <form action="${pageContext.request.contextPath}/panier"
                                  method="post">
                                <input type="hidden" name="action" value="vider">
                                <button type="submit" class="btn btn-outline-danger w-100"
                                        onclick="return confirm('Voulez-vous vider votre panier ?');">
                                    <i class="fas fa-trash-alt"></i> Vider le panier
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%@ include file="/views/include/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>