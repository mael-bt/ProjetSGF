--TP 12 et 13 --
generic
         type T_Element is private;

package liste_chaine is

         type T_Liste is private;
         liste_vide : exception;
         data_not_found : exception;


         -- Nom : creer_liste_vide
         -- S�mantique : Cette fonction permet de cr�er une liste vide
         -- Param�tres :  aucun
         -- R�sultat : retourne une liste vide
         -- Pr� : /
         -- Post : est_vide (l) vaut vrai
         -- Exception : /
         procedure creer_liste_vide (l : in out T_Liste);

         -- Nom : est_vide
         -- S�mantique : Cette fonction permet de tester si une liste est vide ou non
         -- Param�tres :  1 donn�e type liste
         -- R�sultat : retourne un bool�en
         -- Pr� : /
         -- Post : /
         -- Exception : /
         function est_vide (l : in T_Liste) return Boolean;

         -- Nom : inserer_en_tete
         -- S�mantique : Ins�rer l'�l�ment nouveau en t�te de la liste 1 (1 vide ou non vide)
         -- Param�tres :  1 donn�e/r�sultat type liste
         --               nouveau donn�e type entier
         -- Pr� : /
         -- Post : nouveau appartient � la liste
         -- Exception : /
         procedure inserer_en_tete (l : in out T_Liste ; a : in T_Element);

         -- Nom : afficher_liste (sous_programme r�cursif)
         -- S�mantique : Afficher les �l�ments de la liste 1
         -- Param�tres :  1 donn�e type liste
         -- Pr� : /
         -- Post : /
         -- Exception : /

         generic
                  with procedure afficher_gen (un_type : in T_Element);
         procedure afficher_liste (l : in T_Liste);

         -- Nom : rechercher (sous-programme it�rative)
         -- S�mantique : recherche si e est pr�sent dans la liste, retourne son adresse ou null si la liste est vide ou si e n'appartient pas � la liste
         -- Param�tres :  1 donn�e type liste
         --               e donn�e type entier
         -- R�sultat : liste(l : in T_Liste ; nouveau : in Integer ; data : in Integer)
         -- Pr� : /
         -- Post : /
         -- Exception : /
         function rechercher (l : in T_Liste ; a : in T_Element) return T_Liste;

         -- Nom : inserer_apres (sous-programme it�rative)
         -- S�mantique : ins�re dans la liste 1 (liste vide ou non vide), l'�l�ment nouveau, apr�s la valeur data
         -- Param�tres :  1 donn�e/r�sultat type liste
         --               nouveau donn�e type entier
         --               data donn�e type entier
         -- Pr� : /
         -- Post : nouveau appartient � la liste
         -- Exception : data n'est pas dans la liste
         --             la liste est vide
         procedure inserer_apres (l : in T_Liste ; nouveau : in T_Element ; data : in T_Element);

         -- Nom : inserer_avant (sous-programme it�rative)
         -- S�mantique : ins�re dans la liste 1 (liste vide ou non vide) l'�l�ment nouveau, avant la valeur data
         -- Param�tres :  1 donn�e/r�sultat type liste
         --               nouveau donn�e type entier
         --               data donn�e type entier
         -- Pr� : /
         -- Post : nouveau appartient � la liste
         -- Exception : data n'est pas dans la liste
         --             la liste est vide
         procedure inserer_avant (l : in out T_Liste ; nouveau : in T_Element ; data : in T_Element);

         -- Nom : enlever
         -- S�mantique : enlever un �l�ment e de la liste 1 (liste vide ou non vide)
         -- Param�tres :  1 donn�e/r�sultat type liste
         --               e donn�e type entier
         -- Pr� : /
         -- Post : e appartient pas � la liste
         -- Exception : /
         procedure enlever (l : in out T_Liste ; e : in T_Element);

private

         Type T_Cellule;

         Type T_Liste is access T_Cellule;

         Type T_Cellule is record
                  element : T_Element;
                  suivant : T_Liste;
         end record;

end liste_chaine;
