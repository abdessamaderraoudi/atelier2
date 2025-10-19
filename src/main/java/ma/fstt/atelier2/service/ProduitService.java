package ma.fstt.atelier2.service;

import ma.fstt.atelier2.DAO.ProduitDAO;
import ma.fstt.atelier2.model.Produit;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;

@ApplicationScoped
@Transactional
public class ProduitService {

    @Inject
    private ProduitDAO produitDAO;

    public List<Produit> getTousProduits() {
        return produitDAO.findAll();
    }

    public List<Produit> getProduitsDisponibles() {
        return produitDAO.findDisponibles();
    }

    public Produit getProduitById(Long id) {
        return produitDAO.findById(id);
    }

    public List<Produit> getProduitsByCategorie(String categorie) {
        return produitDAO.findByCategorie(categorie);
    }

    public List<Produit> rechercherProduits(String keyword) {
        return produitDAO.searchByNom(keyword);
    }

    public Produit ajouterProduit(Produit produit) throws Exception {
        if (produit.getNom() == null || produit.getNom().trim().isEmpty()) {
            throw new Exception("Le nom du produit est obligatoire");
        }

        if (produit.getPrix() == null || produit.getPrix().doubleValue() <= 0) {
            throw new Exception("Le prix doit être supérieur à 0");
        }

        if (produit.getStock() == null || produit.getStock() < 0) {
            throw new Exception("Le stock ne peut pas être négatif");
        }

        produitDAO.save(produit);
        return produit;
    }

    public Produit modifierProduit(Produit produit) {
        return produitDAO.update(produit);
    }

    public void supprimerProduit(Long id) {
        produitDAO.delete(id);
    }

    public boolean verifierDisponibilite(Long produitId, int quantite) {
        Produit produit = produitDAO.findById(produitId);
        return produit != null && produit.getStock() >= quantite;
    }
}