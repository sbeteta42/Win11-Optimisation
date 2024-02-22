# Win11-Optimisation
Script batch pour optimiser Windows 11

Ce dépôt contient une script batch pour Windows 11 conçus pour otimiser les performances. 
Le script effectuent diverses actions

### Actions Effectuées

1. **Création d'un point de restautration du système :**
   - A faire ABSOLUMENT ! pour ne pas avoir de probèmes par la suite...

2. **Désactivation du protocole IPV6 :**
    - Désactiver l'IPv6 peut résoudre des problèmes de connexion Wi-Fi® et LAN sans fil, tels que des pertes ou échecs de connexion.
      
3. **Optimiser les paramètres réseaux :**

4. **Effacement des fichiers temporaires :**
    - La suppression des fichiers temporaires est un moyen simple mais efficace d'optimiser les performances de votre ordinateur, de libérer de l'espace de stockage et de réduire le risque d'erreurs et de plantages.
      
5. **Défragmentation du disque dur:**
   - Plus un disque dur est fragmenté, plus votre appareil devient lent.
   - Dans ce cas, une défragmentation s'impose pour optimiser les performances de votre ordinateur
     
7. **Désactiver le mode jeu et la barre de jeu :**
   - ou pas.. selon votre besoin. Cependant certaines fonctionnalités du mode de jeu pourraient affecter la performance.
   - Nous suggérons de désactiver cette fonctionnalité si vous avez des problèmes de performance.

8. **Désactivation l'indexation sur tous les lecteurs :**
   - Les temps d'accès aux SSD étant minimes et sans communes mesures avec ceux des disques durs, vous pouvez désactiver l'indexation.
     
9. **Désactivation l'hibernation du pc:**
   - Je vous le recommende fortement ; de nombreux utilisateurs de Windows ont rapporté des problèmes où leur ordinateur ne parvenait pas à sortir du mode hibernation, entraînant l’impossibilité d’accéder au bureau ou de se connecter au PC Windows.

10. **Désactivation de  la télémétrie et la collecte de données :**
   - Windows 10 et 11, comme de nombreux systèmes d’exploitation modernes, intègre des fonctions de télémétrie et de collecte de données. Elles visent à améliorer l’expérience de l’utilisateur en collectant des données sur les habitudes d’utilisation, les erreurs, et bien plus.
   - Toutefois, pour diverses raisons, notamment les préoccupations en matière de protection de la vie privée et de conformité réglementaire, les professionnels de l’informatique et les entreprises MSP doivent souvent contrôler ces fonctions

11. **Désactivation des conseils/suggestions Windows :**
    - Dans les faits, cet affichage est souvent assez peu pertinent.
    - Résultats des courses, les recommandations affichées dans le menu Démarrer occupent l’espace inutilement quand vous pourriez choisir d’y épingler un plus grand nombre d’applications utilisées au quotidien.

12. **Désactivation du groupe résidentiel ? :**
    - Désactive MSHOME et WORKGROUP si vous ne voulez pas partager ou qu'on accède à votre pc
      
13. **Désactivation de l'invite des touches rémanentes :**
    - Empèche le hack sur sethc.exe 

14. **Désactivation de Superfetch :**
    - Superfetch peut consommer beaucoup de ressources CPU et de RAM, ce qui peut entraîner une utilisation de votre disque jusqu'à 100 %, augmenter la température du processeur et diminuer la vitesse de votre ordinateur.

15. **Désactivation du spooler d'impression :**
    - Le Spooleur d’impression (Print Spooler en anglais) du système d’exploitation Microsoft Windows est un service permettant la gestion des tâches d’impression. L’exécutable de ce service est spoolsv.exe et ce service est actif par défaut sur la plupart des systèmes Microsoft Windows.
    - Il a été impacté par un grand nombre de vulnérabilités au cours des dernières années, et constituait le vecteur de propagation du virus Stuxnet.
    - Afin de pallier ces vulnérabilités, il est généralement conseillé de désactiver le service du Spooleur d’impression sur les pcs qui ne l’utilisent pas. 

16. **Désactiver le service Windows Insider :** 
    - Vous avez rejoint le programme Windows Insider mais maintenant vous souhaitez ne plus recevoir de nouvelle version d’évaluation et de test de Windows 10 ou Windows 11.
Pour cela, il faut demander à arrêter Windows Insider afin de le désactiver et ne plus recevoir les builds preview. Ou executer mon script...

17. **Désactiver l'hôte du service de diagnostic :**
    - La désactivation du service de stratégie de diagnostic Windows évite certaines opérations d'E/S sur le système de fichiers et peut réduire la croissance du disque virtuel d'un Instant Clone ou d'un clone lié.(vmware,hyper-V)
    - Ne désactivez pas le service de stratégie de diagnostic Windows si vos utilisateurs ont besoin des outils de diagnostic sur leurs postes de travail 

18. **Désactiver BITS (Background Intelligent Transfer Service):**
    - Le service de transfert intelligent en arrière-plan (BITS, Background Intelligent Transfer Service) est utilisé par les programmeurs et les administrateurs système pour télécharger ou charger des fichiers depuis ou vers des serveurs web HTTP et des partages de fichiers SMB.
    - BITS prend en considération le coût du transfert, ainsi que l’utilisation du réseau afin que le travail de premier plan de l’utilisateur ait le moins d’impact possible. BITS gère également les intersuptions réseau, la mise en pause et la reprise automatique des transferts, même après un redémarrage.
    - BITS inclut des applets de commande PowerShell pour la création et la gestion des transferts, ainsi que l’utilitaire de ligne de commande BitsAdmin.


### Notes Importantes

- Ce script doit être exécuté avec des privilèges administratifs.
- Assurez-vous d'avoir une sauvegarde avant d'appliquer des changements, car certaines modifications peuvent affecter le comportement du système.

### Remarque Importante

- **Assurez-vous d'avoir une sauvegarde avant d'appliquer des changements**, car certaines modifications peuvent affecter le comportement du système.
