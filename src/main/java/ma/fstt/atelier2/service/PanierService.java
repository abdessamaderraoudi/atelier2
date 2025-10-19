package ma.fstt.atelier2.service;

import ma.fstt.atelier2.DAO.PanierDAO;
import ma.fstt.atelier2.DAO.ProduitDAO;
import ma.fstt.atelier2.DAO.InternauteDAO;
import ma.fstt.atelier2.model.*;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.time.LocalDateTime;

@ApplicationScoped
@Transactional
public class PanierService {

    @Inject
    private PanierDAO panierDAO;

    @Inject
    private ProduitDAO produitDAO;

    @Inject
    private InternauteDAO internauteDAO;

    public Panier getPanierActif(Long internauteId) {
        Panier panier = panierDAO.findPanierActifByInternaute(internauteId);

        if (panier == null) {
            Internaute internaute = internauteDAO.findById(internauteId);
            panier = new Panier(internaute);
            panierDAO.save(panier);
        }

        return panier;
    }

    public void ajouterProduit(Long internauteId, Long produitId, int quantite) throws Exception {
        Produit produit = produitDAO.findById(produitId);

        if (produit == null) {
            throw new Exception("Produit introuvable");
        }

        if (produit.getStock() < quantite) {
            throw new Exception("Stock insuffisant. Disponible: " + produit.getStock());
        }

        Panier panier = getPanierActif(internauteId);

        // Vérifier si le produit existe déjà dans le panier
        LignePanier ligneExistante = panier.getLignes().stream()
                .filter(l -> l.getProduit().getId().equals(produitId))
                .findFirst()
                .orElse(null);

        if (ligneExistante != null) {
            int nouvelleQuantite = ligneExistante.getQuantite() + quantite;
            if (produit.getStock() < nouvelleQuantite) {
                throw new Exception("Stock insuffisant. Disponible: " + produit.getStock());
            }
            ligneExistante.setQuantite(nouvelleQuantite);
        } else {
            LignePanier nouvelleLigne = new LignePanier(produit, quantite);
            panier.ajouterLigne(nouvelleLigne);
        }

        panier.setDateModification(LocalDateTime.now());
        panierDAO.update(panier);
    }

    public void modifierQuantite(Long internauteId, Long ligneId, int quantite) throws Exception {
        Panier panier = getPanierActif(internauteId);

        LignePanier ligne = panier.getLignes().stream()
                .filter(l -> l.getId().equals(ligneId))
                .findFirst()
                .orElseThrow(() -> new Exception("Ligne non trouvée dans le panier"));

        if (quantite <= 0) {
            throw new Exception("La quantité doit être supérieure à 0");
        }

        if (ligne.getProduit().getStock() < quantite) {
            throw new Exception("Stock insuffisant. Disponible: " + ligne.getProduit().getStock());
        }

        ligne.setQuantite(quantite);
        panier.setDateModification(LocalDateTime.now());
        panierDAO.update(panier);
    }

    public void retirerProduit(Long internauteId, Long ligneId) throws Exception {
        Panier panier = getPanierActif(internauteId);

        LignePanier ligne = panier.getLignes().stream()
                .filter(l -> l.getId().equals(ligneId))
                .findFirst()
                .orElseThrow(() -> new Exception("Ligne non trouvée dans le panier"));

        panier.retirerLigne(ligne);
        panier.setDateModification(LocalDateTime.now());
        panierDAO.update(panier);
    }

    public void viderPanier(Long internauteId) {
        Panier panier = getPanierActif(internauteId);
        panier.getLignes().clear();
        panier.setDateModification(LocalDateTime.now());
        panierDAO.update(panier);
    }

    public Panier getPanierById(Long panierId) {
        return panierDAO.findById(panierId);
    }
}