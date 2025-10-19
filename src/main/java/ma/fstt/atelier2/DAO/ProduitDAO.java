package ma.fstt.atelier2.DAO;

import ma.fstt.atelier2.model.Produit;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@ApplicationScoped
public class ProduitDAO {

    @PersistenceContext(unitName = "EcommercePU")
    private EntityManager em;

    public void save(Produit produit) {
        em.persist(produit);
    }

    public Produit update(Produit produit) {
        return em.merge(produit);
    }

    public void delete(Long id) {
        Produit produit = findById(id);
        if (produit != null) {
            em.remove(produit);
        }
    }

    public Produit findById(Long id) {
        return em.find(Produit.class, id);
    }

    public List<Produit> findAll() {
        return em.createQuery("SELECT p FROM Produit p ORDER BY p.id DESC", Produit.class)
                .getResultList();
    }

    public List<Produit> findByCategorie(String categorie) {
        return em.createQuery(
                        "SELECT p FROM Produit p WHERE p.categorie = :categorie ORDER BY p.nom",
                        Produit.class
                )
                .setParameter("categorie", categorie)
                .getResultList();
    }

    public List<Produit> findDisponibles() {
        return em.createQuery(
                        "SELECT p FROM Produit p WHERE p.stock > 0 ORDER BY p.id DESC",
                        Produit.class
                )
                .getResultList();
    }

    public List<Produit> searchByNom(String keyword) {
        return em.createQuery(
                        "SELECT p FROM Produit p WHERE LOWER(p.nom) LIKE LOWER(:keyword) ORDER BY p.nom",
                        Produit.class
                )
                .setParameter("keyword", "%" + keyword + "%")
                .getResultList();
    }
}