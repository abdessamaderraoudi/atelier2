# 📘 RAPPORT DE PROJET - Application E-Commerce JEE

## 📋 Informations Générales

| Élément | Description |
|---------|-------------|
| **Titre du projet** | Application E-Commerce avec JEE |
| **Technologie principale** | Jakarta EE 10 (JEE) |
| **Framework de persistance** | JPA avec EclipseLink |
| **Gestion des dépendances** | CDI (Contexts and Dependency Injection) |
| **Base de données** | MySQL 8.0+ |
| **Serveur d'application** | WildFly 27+ |
| **Architecture** | Architecture en couches (MVC) |
| **Version** | 1.0-SNAPSHOT |

---
<img width="1913" height="973" alt="Capture d’écran 2025-10-19 215802" src="https://github.com/user-attachments/assets/1220f1d1-55d6-43fe-8d86-d8c994a55e80" /><img width="1918" height="841" alt="Capture d’écran 2025-10-19 220003" src="https://github.com/user-attachments/assets/9beab68e-2555-4051-aa98-63c0306f566b" />
<img width="1917" height="966" alt="Capture d’écran 2025-10-19 215943" src="https://github.com/user-attachments/assets/c6679f7f-bd96-432c-9f86-364790869179" />
<img width="1915" height="970" alt="Capture d’écran 2025-10-19 215903" src="https://github.com/user-attachments/assets/3a0574b7-e258-4098-a1f1-ce132c543ca6" />
<img width="1918" height="967" alt="image" src="https://github.com/user-attachments/assets/5631bf29-0ffa-480f-82e3-56c720746942" />


## 🎯 Objectifs du Projet

### Objectif Principal
Développer une application web e-commerce complète permettant aux utilisateurs de consulter des produits, de les ajouter à un panier et de gérer leurs achats en ligne.

### Objectifs Spécifiques
1. ✅ Implémenter un système d'authentification et d'inscription des utilisateurs
2. ✅ Créer un catalogue de produits dynamique avec recherche
3. ✅ Développer un système de gestion de panier d'achat
4. ✅ Mettre en place une architecture MVC respectant les bonnes pratiques JEE
5. ✅ Utiliser CDI pour l'injection de dépendances
6. ✅ Implémenter la persistance des données avec JPA/EclipseLink
7. ✅ Créer une interface utilisateur responsive avec Bootstrap 5

---

## 🏗️ Architecture du Projet

### Architecture Globale

```
┌─────────────────────────────────────────────────────────┐
│                    Couche Présentation                   │
│              (JSP + JSTL + Bootstrap 5)                  │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐              │
│  │index.jsp │  │login.jsp │  │panier.jsp│              │
│  └──────────┘  └──────────┘  └──────────┘              │
└────────────────────┬────────────────────────────────────┘
                     │ HTTP Request/Response
┌────────────────────▼────────────────────────────────────┐
│                  Couche Contrôleur                       │
│                    (Servlets)                            │
│  ┌──────────────┐ ┌────────────┐ ┌─────────────┐       │
│  │Internaute    │ │Produit     │ │Panier       │       │
│  │Servlet       │ │Servlet     │ │Servlet      │       │
│  └──────────────┘ └────────────┘ └─────────────┘       │
└────────────────────┬────────────────────────────────────┘
                     │ CDI @Inject
┌────────────────────▼────────────────────────────────────┐
│                 Couche Service                           │
│              (Logique Métier)                            │
│  ┌──────────────┐ ┌────────────┐ ┌─────────────┐       │
│  │Internaute    │ │Produit     │ │Panier       │       │
│  │Service       │ │Service     │ │Service      │       │
│  └──────────────┘ └────────────┘ └─────────────┘       │
└────────────────────┬────────────────────────────────────┘
                     │ CDI @Inject
┌────────────────────▼────────────────────────────────────┐
│                   Couche DAO                             │
│              (Accès aux Données)                         │
│  ┌──────────────┐ ┌────────────┐ ┌─────────────┐       │
│  │Internaute    │ │Produit     │ │Panier       │       │
│  │DAO           │ │DAO         │ │DAO          │       │
│  └──────────────┘ └────────────┘ └─────────────┘       │
└────────────────────┬────────────────────────────────────┘
                     │ JPA/EntityManager
┌────────────────────▼────────────────────────────────────┐
│                 Couche Persistance                       │
│            (JPA avec EclipseLink)                        │
│  ┌──────────┐ ┌─────────┐ ┌────────┐ ┌──────────┐     │
│  │Internaute│ │Produit  │ │Panier  │ │Ligne     │     │
│  │(Entity)  │ │(Entity) │ │(Entity)│ │Panier    │     │
│  └──────────┘ └─────────┘ └────────┘ └──────────┘     │
└────────────────────┬────────────────────────────────────┘
                     │ JDBC
┌────────────────────▼────────────────────────────────────┐
│                 Base de Données                          │
│                    MySQL 8.0+                            │
└─────────────────────────────────────────────────────────┘
```

### Architecture en Couches

#### 1. **Couche Présentation (View)**
- **Technologies** : JSP, JSTL, Bootstrap 5, Font Awesome
- **Responsabilités** :
    - Affichage des données aux utilisateurs
    - Capture des entrées utilisateur
    - Interface responsive et moderne
- **Composants** :
    - Pages JSP pour chaque fonctionnalité
    - Fragments réutilisables (header, footer)
    - Formulaires HTML5

#### 2. **Couche Contrôleur (Controller)**
- **Technologies** : Servlets Jakarta EE
- **Responsabilités** :
    - Réception des requêtes HTTP
    - Validation des données d'entrée
    - Appel des services métier
    - Gestion de la navigation
    - Gestion des sessions
- **Composants** :
    - `InternauteServlet` : Gestion des utilisateurs
    - `ProduitServlet` : Gestion des produits
    - `PanierServlet` : Gestion du panier
    - Filtres : `EncodingFilter`, `PanierCountFilter`

#### 3. **Couche Service (Business Logic)**
- **Technologies** : CDI, Annotations Jakarta EE
- **Responsabilités** :
    - Implémentation de la logique métier
    - Validation des règles métier
    - Orchestration des opérations
    - Gestion des transactions (@Transactional)
- **Composants** :
    - `InternauteService` : Authentification, inscription
    - `ProduitService` : Gestion du catalogue
    - `PanierService` : Gestion des achats

#### 4. **Couche DAO (Data Access Object)**
- **Technologies** : JPA, EntityManager
- **Responsabilités** :
    - Opérations CRUD sur les entités
    - Requêtes personnalisées (JPQL)
    - Abstraction de l'accès aux données
- **Composants** :
    - `InternauteDAO` : Opérations sur les utilisateurs
    - `ProduitDAO` : Opérations sur les produits
    - `PanierDAO` : Opérations sur les paniers

#### 5. **Couche Entités (Model)**
- **Technologies** : JPA Annotations
- **Responsabilités** :
    - Représentation des données
    - Mapping objet-relationnel
    - Relations entre entités
- **Composants** :
    - `Internaute` : Utilisateurs de l'application
    - `Produit` : Catalogue de produits
    - `Panier` : Paniers d'achat
    - `LignePanier` : Articles dans le panier

---

## 📊 Modèle de Données

### Diagramme Entité-Association

```
┌─────────────────┐
│   INTERNAUTE    │
├─────────────────┤
│ PK id           │
│    nom          │
│    prenom       │
│ UK email        │
│    password     │
│    telephone    │
│    adresse      │
└────────┬────────┘
         │
         │ 1
         │
         │ N
┌────────▼────────┐
│     PANIER      │
├─────────────────┤
│ PK id           │
│ FK internaute_id│
│    date_creation│
│    date_modif   │
│    statut       │
└────────┬────────┘
         │
         │ 1
         │
         │ N
┌────────▼────────┐         ┌─────────────────┐
│  LIGNE_PANIER   │    N    │    PRODUIT      │
├─────────────────┤◄────────┤─────────────────┤
│ PK id           │    1    │ PK id           │
│ FK panier_id    │         │    nom          │
│ FK produit_id   │─────────│    description  │
│    quantite     │         │    prix         │
│    prix_unitaire│         │    stock        │
└─────────────────┘         │    imageUrl     │
                            │    categorie    │
                            └─────────────────┘
```

### Description des Tables

#### Table : `internautes`
| Colonne | Type | Contraintes | Description |
|---------|------|-------------|-------------|
| id | BIGINT | PK, AUTO_INCREMENT | Identifiant unique |
| nom | VARCHAR(50) | NOT NULL | Nom de famille |
| prenom | VARCHAR(50) | NOT NULL | Prénom |
| email | VARCHAR(100) | UNIQUE, NOT NULL | Adresse email (login) |
| password | VARCHAR(255) | NOT NULL | Mot de passe |
| telephone | VARCHAR(20) | NULL | Numéro de téléphone |
| adresse | VARCHAR(200) | NULL | Adresse postale |

#### Table : `produits`
| Colonne | Type | Contraintes | Description |
|---------|------|-------------|-------------|
| id | BIGINT | PK, AUTO_INCREMENT | Identifiant unique |
| nom | VARCHAR(255) | NOT NULL | Nom du produit |
| description | TEXT | NULL | Description détaillée |
| prix | DECIMAL(10,2) | NOT NULL | Prix unitaire |
| stock | INT | NOT NULL | Quantité en stock |
| imageUrl | VARCHAR(255) | NULL | URL de l'image |
| categorie | VARCHAR(50) | NULL | Catégorie du produit |

#### Table : `paniers`
| Colonne | Type | Contraintes | Description |
|---------|------|-------------|-------------|
| id | BIGINT | PK, AUTO_INCREMENT | Identifiant unique |
| internaute_id | BIGINT | FK, NOT NULL | Référence à l'utilisateur |
| date_creation | DATETIME | NOT NULL | Date de création |
| date_modification | DATETIME | NOT NULL | Dernière modification |
| statut | VARCHAR(20) | NOT NULL | ACTIF/COMMANDE/ABANDONNE |

#### Table : `lignes_panier`
| Colonne | Type | Contraintes | Description |
|---------|------|-------------|-------------|
| id | BIGINT | PK, AUTO_INCREMENT | Identifiant unique |
| panier_id | BIGINT | FK, NOT NULL | Référence au panier |
| produit_id | BIGINT | FK, NOT NULL | Référence au produit |
| quantite | INT | NOT NULL | Quantité commandée |
| prix_unitaire | DECIMAL(10,2) | NOT NULL | Prix au moment de l'ajout |

### Relations et Cardinalités

- **Internaute ↔ Panier** : One-to-Many (1:N)
    - Un internaute peut avoir plusieurs paniers
    - Un panier appartient à un seul internaute

- **Panier ↔ LignePanier** : One-to-Many (1:N)
    - Un panier contient plusieurs lignes
    - Une ligne appartient à un seul panier

- **Produit ↔ LignePanier** : One-to-Many (1:N)
    - Un produit peut être dans plusieurs paniers
    - Une ligne fait référence à un seul produit

---

## 🔧 Technologies Utilisées

### Backend
| Technologie | Version | Usage |
|-------------|---------|-------|
| **Java** | 11+ | Langage de programmation principal |
| **Jakarta EE** | 10.0.0 | Spécifications JEE (Servlets, CDI, JPA) |
| **EclipseLink** | 4.0.2 | Implémentation JPA |
| **MySQL Connector** | 8.0.33 | Driver JDBC pour MySQL |
| **Maven** | 3.6+ | Gestion des dépendances et build |

### Frontend
| Technologie | Version | Usage |
|-------------|---------|-------|
| **JSP** | 3.1 | Pages dynamiques côté serveur |
| **JSTL** | 3.0.0 | Bibliothèque de tags pour JSP |
| **Bootstrap** | 5.3.0 | Framework CSS responsive |
| **Font Awesome** | 6.4.0 | Icônes |
| **HTML5** | - | Structure des pages |
| **CSS3** | - | Styles personnalisés |

### Infrastructure
| Composant | Version | Usage |
|-----------|---------|-------|
| **WildFly** | 27+ | Serveur d'application Jakarta EE |
| **MySQL** | 8.0+ | Système de gestion de base de données |

---

## ⚙️ Fonctionnalités Implémentées

### 1. Gestion des Utilisateurs (Module Internaute)

#### 1.1 Inscription
- ✅ Formulaire d'inscription avec validation
- ✅ Vérification de l'unicité de l'email
- ✅ Validation des champs obligatoires (nom, prénom, email, mot de passe)
- ✅ Validation de la longueur du mot de passe (minimum 6 caractères)
- ✅ Confirmation du mot de passe

**Code clé** :
```java
@Transactional
public Internaute inscrire(Internaute internaute) throws Exception {
    if (internauteDAO.emailExists(internaute.getEmail())) {
        throw new Exception("Cet email est déjà utilisé");
    }
    // Validations...
    internauteDAO.save(internaute);
    return internaute;
}
```

#### 1.2 Authentification
- ✅ Formulaire de connexion (email + mot de passe)
- ✅ Vérification des credentials
- ✅ Création et gestion de session
- ✅ Stockage des informations utilisateur en session

**Code clé** :
```java
public Internaute authentifier(String email, String password) {
    Internaute internaute = internauteDAO.findByEmail(email);
    if (internaute != null && internaute.getPassword().equals(password)) {
        return internaute;
    }
    return null;
}
```

#### 1.3 Gestion de Session
- ✅ Déconnexion (invalidation de session)
- ✅ Protection des pages nécessitant une authentification
- ✅ Affichage du nom de l'utilisateur dans le header
- ✅ Redirection automatique vers login si non authentifié

### 2. Gestion des Produits (Module Produit)

#### 2.1 Affichage du Catalogue
- ✅ Liste de tous les produits disponibles
- ✅ Affichage des informations : nom, description, prix, stock
- ✅ Images des produits
- ✅ Badges de statut (stock limité, rupture)
- ✅ Interface responsive en grille

#### 2.2 Recherche de Produits
- ✅ Barre de recherche par nom de produit
- ✅ Recherche insensible à la casse
- ✅ Affichage du mot-clé recherché
- ✅ Résultats instantanés

**Code clé** :
```java
public List<Produit> rechercherProduits(String keyword) {
    return produitDAO.searchByNom(keyword);
}
```

#### 2.3 Détails du Produit
- ✅ Page dédiée pour chaque produit
- ✅ Affichage complet des informations
- ✅ Indication de disponibilité en stock
- ✅ Formulaire d'ajout au panier intégré
- ✅ Validation de la quantité (max = stock disponible)

### 3. Gestion du Panier (Module Panier)

#### 3.1 Ajout au Panier
- ✅ Ajout de produits avec quantité
- ✅ Vérification de la disponibilité en stock
- ✅ Mise à jour automatique si produit déjà dans le panier
- ✅ Sauvegarde du prix au moment de l'ajout
- ✅ Messages de confirmation/erreur

**Code clé** :
```java
public void ajouterProduit(Long internauteId, Long produitId, int quantite) {
    Panier panier = getPanierActif(internauteId);
    LignePanier ligneExistante = // recherche...
    if (ligneExistante != null) {
        ligneExistante.setQuantite(quantite + existante);
    } else {
        LignePanier nouvelleLigne = new LignePanier(produit, quantite);
        panier.ajouterLigne(nouvelleLigne);
    }
    panierDAO.update(panier);
}
```

#### 3.2 Visualisation du Panier
- ✅ Affichage de tous les articles
- ✅ Images miniatures des produits
- ✅ Prix unitaire et sous-total par ligne
- ✅ Total général du panier
- ✅ Compteur d'articles total
- ✅ Badge de compteur dans le header

#### 3.3 Modification du Panier
- ✅ Modification de la quantité d'un article
- ✅ Vérification du stock lors de la modification
- ✅ Suppression d'un article
- ✅ Vidage complet du panier
- ✅ Recalcul automatique des totaux

#### 3.4 Persistance du Panier
- ✅ Sauvegarde automatique en base de données
- ✅ Un panier actif par utilisateur
- ✅ Conservation des paniers entre les sessions
- ✅ Statut de panier (ACTIF, COMMANDE, ABANDONNE)

### 4. Interface Utilisateur

#### 4.1 Design et Ergonomie
- ✅ Interface responsive (mobile, tablette, desktop)
- ✅ Design moderne avec Bootstrap 5
- ✅ Navigation intuitive
- ✅ Header et footer cohérents sur toutes les pages
- ✅ Fil d'Ariane (breadcrumb) sur les pages de détail

#### 4.2 Feedback Utilisateur
- ✅ Messages de succès (vert)
- ✅ Messages d'erreur (rouge)
- ✅ Confirmations pour actions critiques
- ✅ Indicateurs de chargement
- ✅ Badges et icônes informatifs

#### 4.3 Accessibilité
- ✅ Formulaires avec labels appropriés
- ✅ Boutons avec icônes explicites
- ✅ Contrastes de couleurs suffisants
- ✅ Structure HTML sémantique

---

## 🗂️ Structure des Packages

```
ma.fstt.atelier2/
├── model/                    # Entités JPA
│   ├── Internaute.java      # Entité utilisateur
│   ├── Produit.java         # Entité produit
│   ├── Panier.java          # Entité panier
│   └── LignePanier.java     # Entité ligne de panier
│
├── DAO/                      # Data Access Objects
│   ├── InternauteDAO.java   # Accès données internaute
│   ├── ProduitDAO.java      # Accès données produit
│   └── PanierDAO.java       # Accès données panier
│
├── service/                  # Services métier
│   ├── InternauteService.java  # Logique métier internaute
│   ├── ProduitService.java     # Logique métier produit
│   └── PanierService.java      # Logique métier panier
│
├── servlet/                  # Contrôleurs
│   ├── InternauteServlet.java  # Contrôleur internaute
│   ├── ProduitServlet.java     # Contrôleur produit
│   ├── PanierServlet.java      # Contrôleur panier
│   └── HomeServlet.java        # Servlet d'accueil
│
└── filter/                   # Filtres HTTP
    ├── EncodingFilter.java     # Encodage UTF-8
    └── PanierCountFilter.java  # Compteur panier
```

---

## 📝 Patterns et Bonnes Pratiques

### Design Patterns Utilisés

#### 1. **MVC (Model-View-Controller)**
- **Model** : Entités JPA
- **View** : Pages JSP
- **Controller** : Servlets

#### 2. **DAO (Data Access Object)**
```java
@ApplicationScoped
public class ProduitDAO {
    @PersistenceContext
    private EntityManager em;
    
    public Produit findById(Long id) {
        return em.find(Produit.class, id);
    }
}
```

#### 3. **Service Layer**
```java
@ApplicationScoped
@Transactional
public class ProduitService {
    @Inject
    private ProduitDAO produitDAO;
    
    public List<Produit> getProduitsDisponibles() {
        return produitDAO.findDisponibles();
    }
}
```

#### 4. **Dependency Injection (CDI)**
```java
@Inject
private ProduitService produitService;
```

#### 5. **Front Controller**
- Chaque servlet gère un module complet
- Routage basé sur le paramètre `action`

### Bonnes Pratiques Appliquées

#### 1. **Séparation des Préoccupations**
- Chaque couche a une responsabilité unique
- Pas de logique métier dans les servlets
- Pas de code SQL dans les services

#### 2. **Gestion des Transactions**
```java
@Transactional  // Gestion automatique des transactions
public void ajouterProduit(...) { }
```

#### 3. **Gestion des Exceptions**
```java
try {
    // Opération
} catch (Exception e) {
    request.setAttribute("error", e.getMessage());
    // Redirection
}
```

#### 4. **Validation des Données**
- Validation côté serveur systématique
- Validation côté client (HTML5)
- Messages d'erreur explicites

#### 5. **Sécurité**
- Vérification de session avant opérations sensibles
- Pas d'exposition des IDs sensibles
- Validation des entrées utilisateur

---

## 🚀 Installation et Déploiement

### Prérequis
- JDK 11 ou supérieur
- Maven 3.6+
- MySQL 8.0+
- WildFly 27+ (ou GlassFish, Payara)
- IDE (IntelliJ IDEA, Eclipse, NetBeans)

### Étapes d'Installation

#### 1. Cloner/Télécharger le projet
```bash
git clone <repository-url>
cd atelier2
```

#### 2. Configurer MySQL
```sql
CREATE DATABASE IF NOT EXISTS ecommerce_db 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

#### 3. Exécuter le script d'initialisation
```bash
mysql -u root -p ecommerce_db < sql/init.sql
```

#### 4. Configurer la source de données
Dans `web.xml`, vérifier :
```xml
<data-source>
    <n>java:app/jdbc/EcommerceDS</n>
    <server-name>localhost</server-name>
    <port-number>3306</port-number>
    <database-name>ecommerce_db</database-name>
    <user>root</user>
    <password>votre_password</password>
</data-source>
```

#### 5. Compiler le projet
```bash
mvn clean package
```

#### 6. Déployer sur WildFly
```bash
cp target/atelier2-1.0-SNAPSHOT.war $WILDFLY_HOME/standalone/deployments/
```

#### 7. Démarrer WildFly
```bash
$WILDFLY_HOME/bin/standalone.sh  # Linux/Mac
$WILDFLY_HOME\bin\standalone.bat  # Windows
```

#### 8. Accéder à l'application
```
http://localhost:8080/atelier2-1.0-SNAPSHOT/
```

---

## 🧪 Tests et Validation

### Scénarios de Test

#### Test 1 : Inscription d'un Nouvel Utilisateur
1. Accéder à la page d'inscription
2. Remplir le formulaire avec des données valides
3. Vérifier la redirection vers la page de connexion
4. Vérifier le message de succès

**Résultat attendu** : Utilisateur créé en base de données

#### Test 2 : Connexion
1. Utiliser les identifiants d'un utilisateur existant
2. Se connecter
3. Vérifier la redirection vers l'accueil
4. Vérifier l'affichage du nom dans le header

**Résultat attendu** : Session créée, utilisateur authentifié

#### Test 3 : Consultation du Catalogue
1. Accéder à la page d'accueil
2. Vérifier l'affichage des produits
3. Tester la recherche par mot-clé

**Résultat attendu** : Produits affichés correctement

#### Test 4 : Détails d'un Produit
1. Cliquer sur "Voir détails" d'un produit
2. Vérifier toutes les informations
3. Vérifier le statut de disponibilité

**Résultat attendu** : Informations complètes affichées

#### Test 5 : Ajout au Panier
1. Se connecter
2. Ajouter un produit au panier
3. Vérifier le message de succès
4. Vérifier la mise à jour du compteur

**Résultat attendu** : Produit ajouté, compteur mis à jour

#### Test 6 : Gestion du Panier
1. Accéder au panier
2. Modifier la quantité d'un article
3. Supprimer un article
4. Vider le panier

**Résultat attendu** : Toutes les opérations fonctionnent

### Données de Test

**Utilisateurs** :
- Email: `ahmed.alami@example.com` | Password: `test123`
- Email: `fatima.bennani@example.com` | Password: `test123`

**Produits** : 15 produits variés avec stock

---

## 📊 Résultats et Réalisations

### Fonctionnalités Complétées

| Module | Fonctionnalités | Statut |
|--------|----------------|--------|
| **Authentification** | Inscription, Connexion, Déconnexion | ✅ 100% |
| **Catalogue** | Affichage, Recherche, Détails | ✅ 100% |
| **Panier** | Ajout, Modification, Suppression | ✅ 100% |
| **Interface** | Responsive, Messages, Navigation | ✅ 100% |

### Métriques du Projet

- **Lignes de code Java** : ~2500
- **Lignes de code JSP** : ~1500
- **Nombre de classes** : 17
- **Nombre de tables** : 4
- **Nombre de requêtes JPQL** : 12+

### Points Forts

✅ Architecture claire et maintenable  
✅ Respect des standards Jakarta EE  
✅ Code bien structuré et commenté  
✅ Interface utilisateur moderne  
✅ Gestion robuste des erreurs  
✅ Utilisation correcte de CDI et JPA

---

## 🔮 Améliorations Futures

### Fonctionnalités Additionnelles

1. **Module Commande**
    - Validation du panier
    - Calcul des frais de livraison
    - Historique des commandes
    - Suivi de commande

2. **Module Paiement**
    - Intégration passerelle de paiement
    - Gestion des modes de paiement
    - Confirmation de paiement
    - Factures PDF

3. **Module Administration**
    - Tableau de bord admin
    - Gestion CRUD des produits
    - Gestion des utilisateurs
    - Statistiques et rapports

4. **Fonctionnalités Avancées**
    - Système de notation et avis
    - Liste de souhaits (wishlist)
    - Comparateur de produits
    - Filtres avancés (prix, catégorie)
    - Promotion et codes promo

