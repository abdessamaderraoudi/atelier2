<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription - E-Commerce</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .register-container {
            min-height: 100vh;
            padding: 50px 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .register-card {
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
    </style>
</head>
<body>
<div class="register-container">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card register-card">
                    <div class="card-body p-5">
                        <div class="text-center mb-4">
                            <h1 class="h3 mb-3">
                                <i class="fas fa-shopping-bag text-primary"></i> E-Commerce
                            </h1>
                            <h2 class="h5 text-muted">Créer un compte</h2>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">
                                <i class="fas fa-exclamation-circle"></i> ${error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/internaute" method="post">
                            <input type="hidden" name="action" value="register">

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="nom" class="form-label">
                                        <i class="fas fa-user"></i> Nom *
                                    </label>
                                    <input type="text" class="form-control" id="nom" name="nom"
                                           value="${nom}" required>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="prenom" class="form-label">
                                        <i class="fas fa-user"></i> Prénom *
                                    </label>
                                    <input type="text" class="form-control" id="prenom" name="prenom"
                                           value="${prenom}" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="email" class="form-label">
                                    <i class="fas fa-envelope"></i> Email *
                                </label>
                                <input type="email" class="form-control" id="email" name="email"
                                       value="${email}" placeholder="votre.email@exemple.com" required>
                            </div>

                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="password" class="form-label">
                                        <i class="fas fa-lock"></i> Mot de passe *
                                    </label>
                                    <input type="password" class="form-control" id="password"
                                           name="password" minlength="6" required>
                                    <small class="text-muted">Au moins 6 caractères</small>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="confirmPassword" class="form-label">
                                        <i class="fas fa-lock"></i> Confirmer *
                                    </label>
                                    <input type="password" class="form-control" id="confirmPassword"
                                           name="confirmPassword" minlength="6" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="telephone" class="form-label">
                                    <i class="fas fa-phone"></i> Téléphone
                                </label>
                                <input type="tel" class="form-control" id="telephone" name="telephone"
                                       value="${telephone}" placeholder="06XXXXXXXX">
                            </div>

                            <div class="mb-3">
                                <label for="adresse" class="form-label">
                                    <i class="fas fa-map-marker-alt"></i> Adresse
                                </label>
                                <textarea class="form-control" id="adresse" name="adresse"
                                          rows="2">${adresse}</textarea>
                            </div>

                            <button type="submit" class="btn btn-primary w-100 mb-3">
                                <i class="fas fa-user-plus"></i> S'inscrire
                            </button>

                            <div class="text-center">
                                <p class="mb-0">Vous avez déjà un compte ?</p>
                                <a href="${pageContext.request.contextPath}/internaute?action=login"
                                   class="btn btn-link">
                                    Se connecter
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>