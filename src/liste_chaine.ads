--TP 12 et 13 --
generic
         type T_Element is private;

package liste_chaine is

         type T_Liste is private;
         liste_vide : exception;
         data_not_found : exception;


         -- Nom : creer_liste_vide
         -- Sémantique : Cette fonction permet de créer une liste vide
         -- Paramètres :  aucun
         -- Résultat : retourne une liste vide
         -- Pré : /
         -- Post : est_vide (l) vaut vrai
         -- Exception : /
         procedure creer_liste_vide (l : in out T_Liste);

         -- Nom : est_vide
         -- Sémantique : Cette fonction permet de tester si une liste est vide ou non
         -- Paramètres :  1 donnée type liste
         -- Résultat : retourne un booléen
         -- Pré : /
         -- Post : /
         -- Exception : /
         function est_vide (l : in T_Liste) return Boolean;

         -- Nom : inserer_en_tete
         -- Sémantique : Insérer l'élément nouveau en tête de la liste 1 (1 vide ou non vide)
         -- Paramètres :  1 donnée/résultat type liste
         --               nouveau donnée type entier
         -- Pré : /
         -- Post : nouveau appartient à la liste
         -- Exception : /
         procedure inserer_en_tete (l : in out T_Liste ; a : in T_Element);

         -- Nom : afficher_liste (sous_programme récursif)
         -- Sémantique : Afficher les éléments de la liste 1
         -- Paramètres :  1 donnée type liste
         -- Pré : /
         -- Post : /
         -- Exception : /

         generic
                  with procedure afficher_gen (un_type : in T_Element);
         procedure afficher_liste (l : in T_Liste);

         -- Nom : rechercher (sous-programme itérative)
         -- Sémantique : recherche si e est présent dans la liste, retourne son adresse ou null si la liste est vide ou si e n'appartient pas à la liste
         -- Paramètres :  1 donnée type liste
         --               e donnée type entier
         -- Résultat : liste(l : in T_Liste ; nouveau : in Integer ; data : in Integer)
         -- Pré : /
         -- Post : /
         -- Exception : /
         function rechercher (l : in T_Liste ; a : in T_Element) return T_Liste;

         -- Nom : inserer_apres (sous-programme itérative)
         -- Sémantique : insère dans la liste 1 (liste vide ou non vide), l'élément nouveau, après la valeur data
         -- Paramètres :  1 donnée/résultat type liste
         --               nouveau donnée type entier
         --               data donnée type entier
         -- Pré : /
         -- Post : nouveau appartient à la liste
         -- Exception : data n'est pas dans la liste
         --             la liste est vide
         procedure inserer_apres (l : in T_Liste ; nouveau : in T_Element ; data : in T_Element);

         -- Nom : inserer_avant (sous-programme itérative)
         -- Sémantique : insère dans la liste 1 (liste vide ou non vide) l'élément nouveau, avant la valeur data
         -- Paramètres :  1 donnée/résultat type liste
         --               nouveau donnée type entier
         --               data donnée type entier
         -- Pré : /
         -- Post : nouveau appartient à la liste
         -- Exception : data n'est pas dans la liste
         --             la liste est vide
         procedure inserer_avant (l : in out T_Liste ; nouveau : in T_Element ; data : in T_Element);

         -- Nom : enlever
         -- Sémantique : enlever un élément e de la liste 1 (liste vide ou non vide)
         -- Paramètres :  1 donnée/résultat type liste
         --               e donnée type entier
         -- Pré : /
         -- Post : e appartient pas à la liste
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
