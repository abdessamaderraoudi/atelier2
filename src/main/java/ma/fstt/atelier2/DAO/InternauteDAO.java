package ma.fstt.atelier2.DAO;


import ma.fstt.atelier2.model.Internaute;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.util.List;

@ApplicationScoped
public class InternauteDAO {

    @PersistenceContext(unitName = "EcommercePU")
    private EntityManager em;

    public void save(Internaute internaute) {
        em.persist(internaute);
    }

    public Internaute update(Internaute internaute) {
        return em.merge(internaute);
    }

    public void delete(Long id) {
        Internaute internaute = findById(id);
        if (internaute != null) {
            em.remove(internaute);
        }
    }

    public Internaute findById(Long id) {
        return em.find(Internaute.class, id);
    }

    public List<Internaute> findAll() {
        return em.createQuery("SELECT i FROM Internaute i", Internaute.class)
                .getResultList();
    }

    public Internaute findByEmail(String email) {
        try {
            return em.createQuery(
                            "SELECT i FROM Internaute i WHERE i.email = :email",
                            Internaute.class
                    )
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

    public boolean emailExists(String email) {
        Long count = em.createQuery(
                        "SELECT COUNT(i) FROM Internaute i WHERE i.email = :email",
                        Long.class
                )
                .setParameter("email", email)
                .getSingleResult();
        return count > 0;
    }
}