package ma.fstt.atelier2.filter;

import ma.fstt.atelier2.model.Panier;
import ma.fstt.atelier2.service.PanierService;
import jakarta.inject.Inject;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "PanierCountFilter", urlPatterns = {"/*"})
public class PanierCountFilter implements Filter {

    @Inject
    private PanierService panierService;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession(false);

        if (session != null && session.getAttribute("internauteId") != null) {
            try {
                Long internauteId = (Long) session.getAttribute("internauteId");
                Panier panier = panierService.getPanierActif(internauteId);

                if (panier != null) {
                    session.setAttribute("panierCount", panier.getNombreArticles());
                } else {
                    session.setAttribute("panierCount", 0);
                }
            } catch (Exception e) {
                session.setAttribute("panierCount", 0);
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void destroy() {
    }
}