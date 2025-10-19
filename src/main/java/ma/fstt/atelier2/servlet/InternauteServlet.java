package ma.fstt.atelier2.servlet;

import ma.fstt.atelier2.model.Internaute;
import ma.fstt.atelier2.service.InternauteService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "InternauteServlet", urlPatterns = {"/internaute"})
public class InternauteServlet extends HttpServlet {

    @Inject
    private InternauteService internauteService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "login";
        }

        switch (action) {
            case "login":
                afficherLogin(request, response);
                break;
            case "register":
                afficherRegister(request, response);
                break;
            case "logout":
                logout(request, response);
                break;
            case "profil":
                afficherProfil(request, response);
                break;
            default:
                afficherLogin(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "login";
        }

        switch (action) {
            case "login":
                traiterLogin(request, response);
                break;
            case "register":
                traiterRegister(request, response);
                break;
            default:
                afficherLogin(request, response);
        }
    }

    /**
     * Afficher la page de connexion
     */
    private void afficherLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/internaute/login.jsp").forward(request, response);
    }

    /**
     * Traiter la connexion
     */
    private void traiterLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Internaute internaute = internauteService.authentifier(email, password);

            if (internaute != null) {
                // Créer une session
                HttpSession session = request.getSession();
                session.setAttribute("internaute", internaute);
                session.setAttribute("internauteId", internaute.getId());
                session.setAttribute("internauteNom", internaute.getNomComplet());

                // Rediriger vers la page d'accueil
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else {
                // Échec de connexion
                request.setAttribute("error", "Email ou mot de passe incorrect");
                request.getRequestDispatcher("/views/internaute/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la connexion: " + e.getMessage());
            request.getRequestDispatcher("/views/internaute/login.jsp").forward(request, response);
        }
    }

    /**
     * Afficher la page d'inscription
     */
    private void afficherRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/internaute/register.jsp").forward(request, response);
    }

    /**
     * Traiter l'inscription
     */
    private void traiterRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String telephone = request.getParameter("telephone");
        String adresse = request.getParameter("adresse");

        try {
            // Vérifier que les mots de passe correspondent
            if (!password.equals(confirmPassword)) {
                throw new Exception("Les mots de passe ne correspondent pas");
            }

            // Créer un nouvel internaute
            Internaute internaute = new Internaute(nom, prenom, email, password);
            internaute.setTelephone(telephone);
            internaute.setAdresse(adresse);

            // Inscrire l'internaute
            internauteService.inscrire(internaute);

            // Rediriger vers la page de connexion avec un message de succès
            request.setAttribute("success", "Inscription réussie ! Vous pouvez maintenant vous connecter.");
            request.getRequestDispatcher("/views/internaute/login.jsp").forward(request, response);

        } catch (Exception e) {
            // En cas d'erreur, réafficher le formulaire avec le message d'erreur
            request.setAttribute("error", e.getMessage());
            request.setAttribute("nom", nom);
            request.setAttribute("prenom", prenom);
            request.setAttribute("email", email);
            request.setAttribute("telephone", telephone);
            request.setAttribute("adresse", adresse);
            request.getRequestDispatcher("/views/internaute/register.jsp").forward(request, response);
        }
    }

    /**
     * Déconnexion
     */
    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        response.sendRedirect(request.getContextPath() + "/internaute?action=login");
    }

    /**
     * Afficher le profil
     */
    private void afficherProfil(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("internaute") == null) {
            response.sendRedirect(request.getContextPath() + "/internaute?action=login");
            return;
        }

        request.getRequestDispatcher("/views/internaute/profil.jsp").forward(request, response);
    }
}