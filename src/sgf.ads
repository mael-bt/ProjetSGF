-- SGF --

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with arbre; 
package SGF is

         type dossiers_fichiers is record 
                  isdossier : Boolean;         --true s'il s'agit d'un d'un dossier 
                  nom : Unbounded_String;
                  taille : Integer;
                  droits : Unbounded_String;
         end record;
         
         est_fichier : exception;
         est_dossier : exception;
         dossier_manquant : exception;
         fichier_manquant : exception;
         dossier_fichier_manquant : exception;
         impossible : exception;
         
         -- Nom : isegaux
         -- Sémantique : fonction permettant de comparer deux records (type dossiers_fichiers) en comparant si les noms sont égaux 
         -- Paramètres :
         -- a : in ; Type : dossiers_fichiers 
         -- b : in ; Type : dossiers_fichiers
         -- Résultat : retourne un booléen
         -- Pré : /
         -- Post : retourne true si a et b ont le même nom
         -- Exception : /

         function isegaux (a : in dossiers_fichiers ; b : in dossiers_fichiers) return Boolean;
          
         package sgf_arbre is new arbre(dossiers_fichiers, isEqual => isegaux);
         use sgf_arbre;
         
         -- Nom : formatage_disque
         -- Sémantique : Cette procedure permet de formater le disque en crééant un dossier racine 
         -- Paramètres : 
         -- Abr_total : in out ; Type : sgf_arbre.arbre
         -- Résultat : /
         -- Pré : /
         -- Post : la procedure formater le disque en crééant un dossier identifier par /
         -- Exception : /
         
         procedure formatage_disque (Abr_total : in out sgf_arbre.arbre);
         
         -- Nom : repertoire_travail (PWD)
         -- Sémantique : renvoie le chemin d'accès du repertoire de travail  
         -- Paramètres : 
         -- Abr_total : in ; Type : sgf_arbre.arbre
         -- nom : in ; Type Unbounded_String
         -- Résultat : /
         -- Pré : /
         -- Post : renvoie le chemin du fichier ou dossier spécifié 
         -- Exception : arbre vide
         
         procedure repertoire_travail (Abr_total : in sgf_arbre.arbre ; nom : in Unbounded_String);
         
         -- Nom : creation_fichier (TOUCH)
         -- Sémantique : créer un fichier avec une taille fixe de 5
         -- Paramètres :
         -- Abr_total : in ; Type : sgf_arbre.arbre
         -- nom_fichier : in ; Type : Unbounded_String
         -- nom : in ; Type : unbounded_String
         -- Résultat : /
         -- Pré : le fichier doit avoir un nom se terminant par .txt
         -- Post : isDossier = false 
         -- Exception : dossier manquant
         
         procedure creation_fichier (Abr_total : in sgf_arbre.arbre ; nom : in Unbounded_String ; nom_fichier : in Unbounded_String); 
         
         -- Nom : creation_dossier (MKDIR)
         -- Sémantique : créer un dossier avec une taille fixe de 10  
         -- Paramètres :
         -- Abr_total : in ; Type : sgf_arbre.arbre
         -- nom_dossier : in ; Type : Unbounded_String
         -- nom : in ; Type : unbounded_String
         -- Résultat : /
         -- Pré : /
         -- Post : isDossier = True 
         -- Exception : dossier manquant 
         
         procedure creation_dossier (Abr_total : in sgf_arbre.arbre ; nom : in Unbounded_String ; nom_dossier : in Unbounded_String);
         
         -- Nom : taille_fichier (TXT)
         -- Sémantique : modifier la taille d'un fichier   
         -- Paramètres :
         -- Abr_total : in ; Type : sgf_arbre.arbre
         -- Taille : in ; Type : Integer 
         -- nom : in ; Type : unbounded_String
         -- Résultat : Integer 
         -- Pré : /
         -- Post : /
         -- Exception : est dossier 
         
         function taille_fichier (Abr_total : in sgf_arbre.arbre ; nom : in Unbounded_String ; Taille : in Integer) return Integer;
         
         -- Nom : navigation (CD)
         -- Sémantique : permet de se déplacer dans l'arborescence en utilisant la commande cd   
         -- Paramètres :
         -- Abr_total : in ; Type : sgf_arbre.arbre 
         -- nom : in ; Type : unbounded_String
         -- Résultat : retourne un arbre 
         -- Pré : /
         -- Post : /
         -- Exception : 
         -- si le nom du dossier n'est pas trouvé dans l'arborescence renvoie "bash: cd: nom: No such file or directory"
         -- arbre vide 
         -- est fichier
         
         function navigation (Abr_total : in sgf_arbre.arbre ; nom : in Unbounded_String) return sgf_arbre.arbre;
         
         -- Nom : affichage_dossier_courant (LS)
         -- Sémantique : affiche tous les fils du dossier courant spécifié  
         -- Paramètres :
         -- Abr_total : in sgf_arbre.arbre
         -- nom : in ; Type : unbounded_String
         -- Résultat : /
         -- Pré : /
         -- Post : /
         -- Exception : 
         -- arbre vide
         
         procedure affichage_dossier_courant (nom : in Unbounded_String ; Abr_total : in sgf_arbre.arbre);
         
         -- Nom : affichage_modif_droits (LS-L)
         -- Sémantique : Correspond à la commande ls -l qui permets d'afficher les droits des users sur un fichier ou dossier spécifie et permet aussi de modifier les droits  
         -- Paramètres :
         -- Abr_total : in ; Type : sgf_arbre.arbre
         -- nom : in ; Type : unbounded_String
         -- Résultat : /
         -- Pré : /
         -- Post : /
         -- Exception : dossier fichier manquant 
         
         procedure affichage_modif_droits (nom : in Unbounded_String ; Abr_total : in sgf_arbre.arbre);
         
         -- Nom : suppression_fichier (RM)
         -- Sémantique : permet de supprimer un fichier correspond à la commande rm
         -- Paramètres :
         -- Abr_total : in ; Type : sgf_arbre.arbre
         -- nom : in ; Type : unbounded_String
         -- Résultat : /
         -- Pré : /
         -- Post : /
         -- Exception : 
         -- est dossier
         -- fichier manquant 
         
         procedure suppression_fichier (nom : in Unbounded_String ; Abr_total : in out sgf_arbre.arbre);
         
         -- Nom : suppression_dossier (RM-R)
         -- Sémantique : permet de supprimer un dossier correspond à la commande rm -r 
         -- Paramètres :
         -- nom : in ; Type : unbounded_String
         -- Résultat : /
         -- Pré : /
         -- Post : /
         -- Exception : 
         -- est fichier 
         -- dossier manquant
         
         procedure suppression_dossier (nom : in Unbounded_String ; Abr_total : in out sgf_arbre.arbre);
         
         -- Nom : deplacer (MV)
         -- Sémantique : permet de déplacer un dossier ou un fichier dans un autre répertoire
         -- Paramètres :
         -- Abr_total : in out ; Type sgf_arbre.arbre
         -- nom_cible : in ; Type : unbounded_String
         -- dossier_cible : in ; Type : unbounded_String
         -- Résultat : /
         -- Pré : /
         -- Post : /
         -- Exception : 
         -- dossier manquant 
         -- dossier fichier manquant 
         
         procedure deplacer (Abr_total : in out sgf_arbre.arbre ; nom_cible : in Unbounded_String; dossier_cible : in Unbounded_String);
         
         -- Nom : copie_dossier_fichier (CP-R)
         -- Sémantique : copier un fichier ou un dossier vers un autre dossier correspond à la commande cp -r   
         -- Paramètres :
         -- Abr_total : in ; Type : sgf_arbre.arbre
         -- nom : in ; Type : unbounded_String
         -- destination : in ; Type : unbounded_String 
         -- Résultat : /
         -- Pré : /
         -- Post : /
         -- Exception : 
         -- dossier manquant 
         -- dossier fichier manquant
         
         procedure copie_dossier_fichier (nom : in Unbounded_String ; destination : in Unbounded_String ; Abr_total : in sgf_arbre.arbre);
         
         -- Nom : afficher_arborescence (TREE)
         -- Sémantique : procédure permettant d'afficher l'arborescence 
         -- Paramètres :
         -- Abr_total : in ; Type : sgf_arbre.arbre
         -- Résultat : /
         -- Pré : /
         -- Post : /
         -- Exception : /
         
         procedure afficher_arborescence (Abr_total : in sgf_arbre.arbre);
         
         

end SGF;
