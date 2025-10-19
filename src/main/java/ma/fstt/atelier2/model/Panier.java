package ma.fstt.atelier2.model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "paniers")
public class Panier implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "internaute_id", nullable = false)
    private Internaute internaute;

    @OneToMany(mappedBy = "panier", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<LignePanier> lignes = new ArrayList<>();

    @Column(name = "date_creation")
    private LocalDateTime dateCreation;

    @Column(name = "date_modification")
    private LocalDateTime dateModification;

    @Enumerated(EnumType.STRING)
    @Column(length = 20)
    private StatutPanier statut = StatutPanier.ACTIF;

    // Constructeurs
    public Panier() {
        this.dateCreation = LocalDateTime.now();
        this.dateModification = LocalDateTime.now();
    }

    public Panier(Internaute internaute) {
        this();
        this.internaute = internaute;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Internaute getInternaute() {
        return internaute;
    }

    public void setInternaute(Internaute internaute) {
        this.internaute = internaute;
    }

    public List<LignePanier> getLignes() {
        return lignes;
    }

    public void setLignes(List<LignePanier> lignes) {
        this.lignes = lignes;
    }

    public LocalDateTime getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(LocalDateTime dateCreation) {
        this.dateCreation = dateCreation;
    }

    public LocalDateTime getDateModification() {
        return dateModification;
    }

    public void setDateModification(LocalDateTime dateModification) {
        this.dateModification = dateModification;
    }

    public StatutPanier getStatut() {
        return statut;
    }

    public void setStatut(StatutPanier statut) {
        this.statut = statut;
    }

    // Méthodes utilitaires
    public void ajouterLigne(LignePanier ligne) {
        lignes.add(ligne);
        ligne.setPanier(this);
        this.dateModification = LocalDateTime.now();
    }

    public void retirerLigne(LignePanier ligne) {
        lignes.remove(ligne);
        ligne.setPanier(null);
        this.dateModification = LocalDateTime.now();
    }

    public BigDecimal getTotal() {
        return lignes.stream()
                .map(LignePanier::getSousTotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public int getNombreArticles() {
        return lignes.stream()
                .mapToInt(LignePanier::getQuantite)
                .sum();
    }

    public enum StatutPanier {
        ACTIF, COMMANDE, ABANDONNE
    }
}