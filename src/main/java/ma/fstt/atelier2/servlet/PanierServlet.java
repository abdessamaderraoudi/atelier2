package ma.fstt.atelier2.servlet;

import ma.fstt.atelier2.model.Panier;
import ma.fstt.atelier2.service.PanierService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "PanierServlet", urlPatterns = {"/panier"})
public class PanierServlet extends HttpServlet {

    @Inject
    private PanierService panierService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("internauteId") == null) {
            response.sendRedirect(request.getContextPath() + "/internaute?action=login");
            return;
        }

        afficherPanier(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("internauteId") == null) {
            response.sendRedirect(request.getContextPath() + "/internaute?action=login");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            afficherPanier(request, response);
            return;
        }

        switch (action) {
            case "ajouter":
                ajouterAuPanier(request, response);
                break;
            case "modifier":
                modifierQuantite(request, response);
                break;
            case "retirer":
                retirerDuPanier(request, response);
                break;
            case "vider":
                viderPanier(request, response);
                break;
            default:
                afficherPanier(request, response);
        }
    }

    private void afficherPanier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long internauteId = (Long) request.getSession().getAttribute("internauteId");
            Panier panier = panierService.getPanierActif(internauteId);

            request.setAttribute("panier", panier);
            request.getRequestDispatcher("/views/panier/panier.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors du chargement du panier: " + e.getMessage());
            request.getRequestDispatcher("/views/panier/panier.jsp").forward(request, response);
        }
    }

    private void ajouterAuPanier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long internauteId = (Long) request.getSession().getAttribute("internauteId");
            Long produitId = Long.parseLong(request.getParameter("produitId"));
            int quantite = Integer.parseInt(request.getParameter("quantite"));

            panierService.ajouterProduit(internauteId, produitId, quantite);

            request.getSession().setAttribute("success", "Produit ajouté au panier avec succès!");

            // Rediriger vers la page précédente ou vers le panier
            String referer = request.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/panier");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", e.getMessage());
            String referer = request.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }
        }
    }

    private void modifierQuantite(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long internauteId = (Long) request.getSession().getAttribute("internauteId");
            Long ligneId = Long.parseLong(request.getParameter("ligneId"));
            int quantite = Integer.parseInt(request.getParameter("quantite"));

            panierService.modifierQuantite(internauteId, ligneId, quantite);

            request.getSession().setAttribute("success", "Quantité mise à jour!");
            response.sendRedirect(request.getContextPath() + "/panier");
        } catch (Exception e) {
            request.getSession().setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/panier");
        }
    }

    private void retirerDuPanier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long internauteId = (Long) request.getSession().getAttribute("internauteId");
            Long ligneId = Long.parseLong(request.getParameter("ligneId"));

            panierService.retirerProduit(internauteId, ligneId);

            request.getSession().setAttribute("success", "Produit retiré du panier!");
            response.sendRedirect(request.getContextPath() + "/panier");
        } catch (Exception e) {
            request.getSession().setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/panier");
        }
    }

    private void viderPanier(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long internauteId = (Long) request.getSession().getAttribute("internauteId");
            panierService.viderPanier(internauteId);

            request.getSession().setAttribute("success", "Panier vidé!");
            response.sendRedirect(request.getContextPath() + "/panier");
        } catch (Exception e) {
            request.getSession().setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/panier");
        }
    }
}