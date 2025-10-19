package ma.fstt.atelier2.DAO;

import ma.fstt.atelier2.model.Panier;
import ma.fstt.atelier2.model.Panier.StatutPanier;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@ApplicationScoped
public class PanierDAO {

    @PersistenceContext(unitName = "EcommercePU")
    private EntityManager em;

    public void save(Panier panier) {
        em.persist(panier);
    }

    public Panier update(Panier panier) {
        return em.merge(panier);
    }

    public void delete(Long id) {
        Panier panier = findById(id);
        if (panier != null) {
            em.remove(panier);
        }
    }

    public Panier findById(Long id) {
        return em.find(Panier.class, id);
    }

    public List<Panier> findAll() {
        return em.createQuery("SELECT p FROM Panier p", Panier.class)
                .getResultList();
    }

    public Panier findPanierActifByInternaute(Long internauteId) {
        try {
            return em.createQuery(
                            "SELECT p FROM Panier p " +
                                    "LEFT JOIN FETCH p.lignes l " +
                                    "LEFT JOIN FETCH l.produit " +
                                    "WHERE p.internaute.id = :internauteId AND p.statut = :statut",
                            Panier.class
                    )
                    .setParameter("internauteId", internauteId)
                    .setParameter("statut", StatutPanier.ACTIF)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

    public List<Panier> findByInternaute(Long internauteId) {
        return em.createQuery(
                        "SELECT p FROM Panier p WHERE p.internaute.id = :internauteId ORDER BY p.dateCreation DESC",
                        Panier.class
                )
                .setParameter("internauteId", internauteId)
                .getResultList();
    }
}