package ma.fstt.atelier2.service;

import ma.fstt.atelier2.DAO.InternauteDAO;
import ma.fstt.atelier2.model.Internaute;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;

@ApplicationScoped
@Transactional
public class InternauteService {

    @Inject
    private InternauteDAO internauteDAO;

    /**
     * Inscription d'un nouvel internaute
     */
    public Internaute inscrire(Internaute internaute) throws Exception {
        // Vérifier si l'email existe déjà
        if (internauteDAO.emailExists(internaute.getEmail())) {
            throw new Exception("Cet email est déjà utilisé");
        }

        // Valider les données
        if (internaute.getNom() == null || internaute.getNom().trim().isEmpty()) {
            throw new Exception("Le nom est obligatoire");
        }

        if (internaute.getPrenom() == null || internaute.getPrenom().trim().isEmpty()) {
            throw new Exception("Le prénom est obligatoire");
        }

        if (internaute.getEmail() == null || internaute.getEmail().trim().isEmpty()) {
            throw new Exception("L'email est obligatoire");
        }

        if (internaute.getPassword() == null || internaute.getPassword().length() < 6) {
            throw new Exception("Le mot de passe doit contenir au moins 6 caractères");
        }

        // Sauvegarder l'internaute
        internauteDAO.save(internaute);
        return internaute;
    }

    /**
     * Authentification d'un internaute
     */
    public Internaute authentifier(String email, String password) {
        Internaute internaute = internauteDAO.findByEmail(email);

        if (internaute != null && internaute.getPassword().equals(password)) {
            return internaute;
        }

        return null;
    }

    /**
     * Récupérer un internaute par son ID
     */
    public Internaute getInternauteById(Long id) {
        return internauteDAO.findById(id);
    }

    /**
     * Mettre à jour les informations d'un internaute
     */
    public Internaute updateInternaute(Internaute internaute) {
        return internauteDAO.update(internaute);
    }
}