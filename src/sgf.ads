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
         -- S�mantique : fonction permettant de comparer deux records (type dossiers_fichiers) en comparant si les noms sont �gaux 
         -- Param�tres :
         -- a : in ; Type : dossiers_fichiers 
         -- b : in ; Type : dossiers_fichiers
         -- R�sultat : retourne un bool�en
         -- Pr� : /
         -- Post : retourne true si a et b ont le m�me nom
         -- Exception : /

         function isegaux (a : in dossiers_fichiers ; b : in dossiers_fichiers) return Boolean;
          
         package sgf_arbre is new arbre(dossiers_fichiers, isEqual => isegaux);
         use sgf_arbre;
         
         -- Nom : formatage_disque
         -- S�mantique : Cette procedure permet de formater le disque en cr��ant un dossier racine 
         -- Param�tres : 
         -- Abr_total : in out ; Type : sgf_arbre.arbre
         -- R�sultat : /
         -- Pr� : /
         -- Post : la procedure formater le disque en cr��ant un dossier identifier par /
         -- Exception : /
         
         procedure formatage_disque (Abr_total : in out sgf_arbre.arbre);
         
         -- Nom : repertoire_travail (PWD)
         -- S�mantique : renvoie le chemin d'acc�s du repertoire de travail  
         -- Param�tres : 
         -- Abr_total : in ; Type : sgf_arbre.arbre
         -- nom : in ; Type Unbounded_String
         -- R�sultat : /
         -- Pr� : /
         -- Post : renvoie le chemin du fichier ou dossier sp�cifi� 
         -- Exception : arbre vide
         
         procedure repertoire_travail (Abr_total : in sgf_arbre.arbre ; nom : in Unbounded_String);
         
         -- Nom : creation_fichier (TOUCH)
         -- S�mantique : cr�er un fichier avec une taille fixe de 5
         -- Param�tres :
         -- Abr_total : in ; Type : sgf_arbre.arbre
         -- nom_fichier : in ; Type : Unbounded_String
         -- nom : in ; Type : unbounded_String
         -- R�sultat : /
         -- Pr� : le fichier doit avoir un nom se terminant par .txt
         -- Post : isDossier = false 
         -- Exception : dossier manquant
         
         procedure creation_fichier (Abr_total : in sgf_arbre.arbre ; nom : in Unbounded_String ; nom_fichier : in Unbounded_String); 
         
         -- Nom : creation_dossier (MKDIR)
         -- S�mantique : cr�er un dossier avec une taille fixe de 10  
         -- Param�tres :
         -- Abr_total : in ; Type : sgf_arbre.arbre
         -- nom_dossier : in ; Type : Unbounded_String
         -- nom : in ; Type : unbounded_String
         -- R�sultat : /
         -- Pr� : /
         -- Post : isDossier = True 
         -- Exception : dossier manquant 
         
         procedure creation_dossier (Abr_total : in sgf_arbre.arbre ; nom : in Unbounded_String ; nom_dossier : in Unbounded_String);
         
         -- Nom : taille_fichier (TXT)
         -- S�mantique : modifier la taille d'un fichier   
         -- Param�tres :
         -- Abr_total : in ; Type : sgf_arbre.arbre
         -- Taille : in ; Type : Integer 
         -- nom : in ; Type : unbounded_String
         -- R�sultat : Integer 
         -- Pr� : /
         -- Post : /
         -- Exception : est dossier 
         
         function taille_fichier (Abr_total : in sgf_arbre.arbre ; nom : in Unbounded_String ; Taille : in Integer) return Integer;
         
         -- Nom : navigation (CD)
         -- S�mantique : permet de se d�placer dans l'arborescence en utilisant la commande cd   
         -- Param�tres :
         -- Abr_total : in ; Type : sgf_arbre.arbre 
         -- nom : in ; Type : unbounded_String
         -- R�sultat : retourne un arbre 
         -- Pr� : /
         -- Post : /
         -- Exception : 
         -- si le nom du dossier n'est pas trouv� dans l'arborescence renvoie "bash: cd: nom: No such file or directory"
         -- arbre vide 
         -- est fichier
         
         function navigation (Abr_total : in sgf_arbre.arbre ; nom : in Unbounded_String) return sgf_arbre.arbre;
         
         -- Nom : affichage_dossier_courant (LS)
         -- S�mantique : affiche tous les fils du dossier courant sp�cifi�  
         -- Param�tres :
         -- Abr_total : in sgf_arbre.arbre
         -- nom : in ; Type : unbounded_String
         -- R�sultat : /
         -- Pr� : /
         -- Post : /
         -- Exception : 
         -- arbre vide
         
         procedure affichage_dossier_courant (nom : in Unbounded_String ; Abr_total : in sgf_arbre.arbre);
         
         -- Nom : affichage_modif_droits (LS-L)
         -- S�mantique : Correspond � la commande ls -l qui permets d'afficher les droits des users sur un fichier ou dossier sp�cifie et permet aussi de modifier les droits  
         -- Param�tres :
         -- Abr_total : in ; Type : sgf_arbre.arbre
         -- nom : in ; Type : unbounded_String
         -- R�sultat : /
         -- Pr� : /
         -- Post : /
         -- Exception : dossier fichier manquant 
         
         procedure affichage_modif_droits (nom : in Unbounded_String ; Abr_total : in sgf_arbre.arbre);
         
         -- Nom : suppression_fichier (RM)
         -- S�mantique : permet de supprimer un fichier correspond � la commande rm
         -- Param�tres :
         -- Abr_total : in ; Type : sgf_arbre.arbre
         -- nom : in ; Type : unbounded_String
         -- R�sultat : /
         -- Pr� : /
         -- Post : /
         -- Exception : 
         -- est dossier
         -- fichier manquant 
         
         procedure suppression_fichier (nom : in Unbounded_String ; Abr_total : in out sgf_arbre.arbre);
         
         -- Nom : suppression_dossier (RM-R)
         -- S�mantique : permet de supprimer un dossier correspond � la commande rm -r 
         -- Param�tres :
         -- nom : in ; Type : unbounded_String
         -- R�sultat : /
         -- Pr� : /
         -- Post : /
         -- Exception : 
         -- est fichier 
         -- dossier manquant
         
         procedure suppression_dossier (nom : in Unbounded_String ; Abr_total : in out sgf_arbre.arbre);
         
         -- Nom : deplacer (MV)
         -- S�mantique : permet de d�placer un dossier ou un fichier dans un autre r�pertoire
         -- Param�tres :
         -- Abr_total : in out ; Type sgf_arbre.arbre
         -- nom_cible : in ; Type : unbounded_String
         -- dossier_cible : in ; Type : unbounded_String
         -- R�sultat : /
         -- Pr� : /
         -- Post : /
         -- Exception : 
         -- dossier manquant 
         -- dossier fichier manquant 
         
         procedure deplacer (Abr_total : in out sgf_arbre.arbre ; nom_cible : in Unbounded_String; dossier_cible : in Unbounded_String);
         
         -- Nom : copie_dossier_fichier (CP-R)
         -- S�mantique : copier un fichier ou un dossier vers un autre dossier correspond � la commande cp -r   
         -- Param�tres :
         -- Abr_total : in ; Type : sgf_arbre.arbre
         -- nom : in ; Type : unbounded_String
         -- destination : in ; Type : unbounded_String 
         -- R�sultat : /
         -- Pr� : /
         -- Post : /
         -- Exception : 
         -- dossier manquant 
         -- dossier fichier manquant
         
         procedure copie_dossier_fichier (nom : in Unbounded_String ; destination : in Unbounded_String ; Abr_total : in sgf_arbre.arbre);
         
         -- Nom : afficher_arborescence (TREE)
         -- S�mantique : proc�dure permettant d'afficher l'arborescence 
         -- Param�tres :
         -- Abr_total : in ; Type : sgf_arbre.arbre
         -- R�sultat : /
         -- Pr� : /
         -- Post : /
         -- Exception : /
         
         procedure afficher_arborescence (Abr_total : in sgf_arbre.arbre);
         
         

end SGF;
