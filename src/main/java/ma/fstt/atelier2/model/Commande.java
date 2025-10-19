package ma.fstt.atelier2.model;
import java.io.Serializable;
import jakarta.persistence.*;
import java.util.*;
@Entity
@Table(name = "commandes")
public class Commande implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Date dateCommande;

    @Column(nullable = false)
    private double montantTotal;

    @ManyToOne
    @JoinColumn(name = "internaute_id", nullable = false)
    private Internaute internaute;

    // Constructeurs
    public Commande() {
        this.dateCommande = new Date();
    }

    public Commande(Internaute internaute, double montantTotal) {
        this.internaute = internaute;
        this.montantTotal = montantTotal;
        this.dateCommande = new Date();
    }

    public Long getId() {
        return id;
    }

    public Date getDateCommande() {
        return dateCommande;
    }

    public double getMontantTotal() {
        return montantTotal;
    }

    public void setMontantTotal(double montantTotal) {
        this.montantTotal = montantTotal;
    }

    public Internaute getInternaute() {
        return internaute;
    }

    public void setInternaute(Internaute internaute) {
        this.internaute = internaute;
    }

}
