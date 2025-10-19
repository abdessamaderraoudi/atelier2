<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fas fa-shopping-bag"></i> E-Commerce
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/">
                        <i class="fas fa-home"></i> Accueil
                    </a>
                </li>

                <c:choose>
                    <c:when test="${not empty sessionScope.internaute}">
                        <!-- Panier avec badge -->
                        <li class="nav-item">
                            <a class="nav-link position-relative"
                               href="${pageContext.request.contextPath}/panier">
                                <i class="fas fa-shopping-cart fa-lg"></i>
                                <c:if test="${not empty sessionScope.panierCount and sessionScope.panierCount > 0}">
                                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                            ${sessionScope.panierCount}
                                    </span>
                                </c:if>
                            </a>
                        </li>

                        <!-- Menu utilisateur -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                               role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-user"></i> ${sessionScope.internauteNom}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li>
                                    <a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/internaute?action=profil">
                                        <i class="fas fa-user-circle"></i> Mon profil
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item"
                                       href="${pageContext.request.contextPath}/internaute?action=logout">
                                        <i class="fas fa-sign-out-alt"></i> Déconnexion
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <a class="nav-link"
                               href="${pageContext.request.contextPath}/internaute?action=login">
                                <i class="fas fa-sign-in-alt"></i> Connexion
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link"
                               href="${pageContext.request.contextPath}/internaute?action=register">
                                <i class="fas fa-user-plus"></i> Inscription
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>