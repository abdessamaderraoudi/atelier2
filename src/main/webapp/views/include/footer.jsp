<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<footer class="bg-dark text-white mt-5 py-4">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h5><i class="fas fa-shopping-bag"></i> E-Commerce</h5>
                <p class="text-muted">Votre boutique en ligne de confiance</p>
            </div>
            <div class="col-md-4">
                <h5>Liens rapides</h5>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/" class="text-white-50">Accueil</a></li>
                    <li><a href="${pageContext.request.contextPath}/panier" class="text-white-50">Panier</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5>Contact</h5>
                <p class="text-muted">
                    <i class="fas fa-envelope"></i> contact@ecommerce.ma<br>
                    <i class="fas fa-phone"></i> +212 XX XX XX XX
                </p>
            </div>
        </div>
        <hr class="bg-secondary">
        <div class="text-center text-muted">
            <p class="mb-0">&copy; 2025 E-Commerce. Tous droits réservés.</p>
        </div>
    </div>
</footer>