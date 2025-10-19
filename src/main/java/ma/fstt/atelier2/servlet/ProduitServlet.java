package ma.fstt.atelier2.servlet;

import ma.fstt.atelier2.model.Produit;
import ma.fstt.atelier2.service.ProduitService;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProduitServlet", urlPatterns = {"/produit"})
public class ProduitServlet extends HttpServlet {

    @Inject
    private ProduitService produitService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        if (action == null && idParam != null) {
            afficherDetailProduit(request, response, Long.parseLong(idParam));
        } else if (action != null && action.equals("search")) {
            rechercherProduits(request, response);
        } else {
            afficherListeProduits(request, response);
        }
    }

    private void afficherListeProduits(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Produit> produits = produitService.getProduitsDisponibles();
            request.setAttribute("produits", produits);
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors du chargement des produits: " + e.getMessage());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }

    private void afficherDetailProduit(HttpServletRequest request, HttpServletResponse response, Long id)
            throws ServletException, IOException {
        try {
            Produit produit = produitService.getProduitById(id);
            if (produit == null) {
                response.sendRedirect(request.getContextPath() + "/");
                return;
            }
            request.setAttribute("produit", produit);
            request.getRequestDispatcher("/views/produit/detail.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors du chargement du produit: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/");
        }
    }

    private void rechercherProduits(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        try {
            List<Produit> produits = produitService.rechercherProduits(keyword);
            request.setAttribute("produits", produits);
            request.setAttribute("keyword", keyword);
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur lors de la recherche: " + e.getMessage());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }
}