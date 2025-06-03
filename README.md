# Segmentation Client pour un E-commerce – Projet Olist

<p align="center">
  <img src="https://img.shields.io/badge/Python-3.10+-blue?logo=python">
  <img src="https://img.shields.io/badge/Notebook-Jupyter-orange?logo=jupyter">
  <img src="https://img.shields.io/badge/Code%20Style-PEP8-green">
  <img src="https://img.shields.io/badge/License-MIT-lightgrey">
</p>

## Objectif

Fournir à l’équipe **Marketing & Customer Experience** d’[Olist](https://olist.com/)  
une **segmentation exploitable** de l’ensemble des clients :

* différencier bons / moins bons profils (valeur, récence, satisfaction) ;  
* guider les campagnes de fidélisation & de ré-engagement ;  
* proposer un **planning de maintenance** du modèle (fréquence de re-training).

Ce dépôt rassemble **3 notebooks analytiques**, les données pré-traitées,  
ainsi que les requêtes SQL qui alimentent le dashboard interne.

---

## Arborescence

```
.
├── .gitignore
├── 01.notebook_exploration.ipynb           # Analyse exploratoire (EDA)
├── 02.notebook_essais.ipynb                # Tests de clustering (K-Means, DBSCAN…)
├── 03.notebook_simulation.ipynb            # Simulation de stabilité & fréquence MAJ
├── Projet 5.pdf                            # Slide de présentation
├── extract.csv                             # Données brutes (échantillon anonymisé)
├── prepared_customer_data.csv              # Jeu de données prêt pour la modélisation
├── requetes SQL première partie.txt        # Scripts SQL des demandes spécifiques
├── requetes SQL preparatoire.txt           # Scripts SQL pour l'extraction des données
├── requirements.txt                        # Bibliothéques
├── script.sql                              # Scripts SQL des demandes spécifiques (format sql)
└── README.md                               # <- VOUS ÊTES ICI
```

---

## Installation rapide

### Pré‑requis

* Python 3.10 ou supérieur  
* `git`, `pip` et un environnement virtuel (recommandé)

### Setup

```bash
git clone https://github.com/Krock13/AI_Engineer_Projet_5_Segmenter_Des_Clients_Pour_Un_Site_E-commerce.git
cd AI_Engineer_Projet_5_Segmenter_Des_Clients_Pour_Un_Site_E-commerce
python -m venv .venv && source .venv/bin/activate   # Linux/Mac
python -m venv .venv && .\.venv\Scripts\activate   # Windows (cmd)
pip install -r requirements.txt
jupyter lab
```

---

## Résultats clés

| Indicateur | Valeur / Insight |
|------------|------------------|
| **Clusters retenus** | 4 (méthode du coude + Silhouette ≈ 0,53) |
| **Répartition** | 25 874 – 25 171 – 27 811 – 17 239 clients |
| **Variable la plus discriminante** | Récence d’achat |
| **Stabilité (ARI)** | > 0,75 les 6 premières semaines, décroissance sous 0,6 après ~3 mois |
| **Fréquence de re‑training conseillée** | **Trimestrielle** (ou bimensuelle pour les périodes de pics promotionnels) |

<details>
<summary>Profil des segments (extrait)</summary>

* **Cluster 0 – “Premium Recents”** : clients récents, légèrement plus dépensiers, note `avg_review` ≈ 4,24.  
* **Cluster 1 – “Dormants modérés”** : dernière commande > 12 mois ; potentiel de ré‑activation.  
* **Cluster 2 – “Occasionnels”** : récence moyenne, panier plus faible.  
* **Cluster 3 – “Churn”** : inactifs > 18 mois, faible valeur – prioriser campagnes retargeting.  

</details>

---

## Comment reproduire ?

1. **Exploration**  
   Lancez `notebook_exploration.ipynb` pour comprendre la structure RFM, satisfaction, moyens de paiement, etc.  
   Nettoyage : gestion des valeurs manquantes, encodage one‑hot, détection d’outliers.

2. **Modélisation**  
   Ouvrez `notebook_essais.ipynb` :  
   * normalisation (`MinMaxScaler`, `StandardScaler`)  
   * comparaison **K‑Means / DBSCAN / Agglomerative**  
   * visualisation (pairplot, radar‑plot) et interprétation business.

3. **Maintenance**  
   `notebook_simulation.ipynb` simule l’évolution des clusters toutes les 2 semaines  
   et trace l’**Adjusted Rand Index** pour recommander la fréquence de mise à jour.

---

## Pistes d’amélioration

* **Pipeline MLOps** : intégrer `scikit‑learn` + `MLflow` → registry & modèle versionné.  
* **API REST** : exposer un endpoint FastAPI pour scorer un nouveau client en temps réel.  
* **Dashboard BI** : passer de SQL + notebooks à un tableau de bord (Looker / Metabase) alimenté par le modèle en production.  
* **Tests & CI** : ajouter `pytest`, `tox` et un workflow GitHub Actions (flake8, black).

---

## Licence

Ce projet est distribué sous licence **MIT**.

---

> _“Without data you’re just another person with an opinion.”_ – W. Edwards Deming
