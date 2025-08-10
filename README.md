#  Optimisation Windows 11 – Scripts & Tweak Lab 🪄

**Boostez les performances et débarrassez-vous du superflu sur Windows 11**, le tout avec mes scripts d’optimisation, debloat et tuning.

---

![OS](https://img.shields.io/badge/OS-Windows%2011-blue)
![Status](https://img.shields.io/badge/Status-Lab%20Ready-success)
![Language](https://img.shields.io/badge/Language-PowerShell%20%7C%20Batch-yellow)
![License](https://img.shields.io/badge/License-MIT-green)

---

##  Table des matières
1. [Description](#-description)  
2. [Fonctionnalités](#-fonctionnalités)  
3. [Installation & usage](#-installation--usage)  
4. [Sécurité & précautions](#-sécurité--précautions)  
5. [Contribuer](#-contribuer)  
6. [Licence](#-licence)

---

##  Description

Ce dépôt propose une série de **scripts Windows 11** pour optimiser ton système : suppression des applications inutiles, configuration des services, réglages de performance et protection de la vie privée.

---

##  Fonctionnalités

-  **Debloat** : désactivation des applications UWP, télémétrie et services inutiles  
-  **Performance** : tweaks pour la mémoire, le démarrage, les animations et le réseau  
-  **Privacy Enhancements** : bloqueurs de collecte et tracking  
-  **Automatisation** : execution en un clic via script PowerShell ou batch  
-  **Personnalisation** : options modifiables selon tes besoins

---

##  Installation & usage

# 1. Clone le dépôt
```powershell
git clone https://github.com/sbeteta42/Win11-Optimisation.git
cd Win11-Optimisation
```
# 2. Exécution (PowerShell)
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\optimize-win11.ps1 -Mode All
```
- Ce script est prévu pour tourner en tant qu'administrateur.
- Tu peux personnaliser les options si besoin.

# 3. Sécurité & précautions
Crée un point de restauration avant toute modification majeure.

- Revue préalable : relis le script avant de l’exécuter.
- Sauvegarde recommandée (fichiers système, registre...).

DOMAINE PROFESSIONNEL ? Teste d’abord en environnement isolé.

