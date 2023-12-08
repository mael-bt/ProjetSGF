-- Arbre de recherche generique --

generic
         type T_Element_arbre is private;
         with function isEqual (a : in T_Element_arbre ; b : in T_Element_arbre) return Boolean;

package arbre is

         type arbre is private;


         -- Nom : init
         -- Sémantique : Cette procedure permet de creer un arbre vide
         -- Paramètres :
         -- Abr : out ; Type : arbre
         -- Résultat : /
         -- Pré : /
         -- Post : initialise un abre n-aire vide
         -- Exception : /

         procedure initialiser (Abr : out arbre);

         -- Nom : arbre_est_vide
         -- Sémantique : Cette fonction permet de vérifier si l'arbre est vide
         -- Paramètres :
         -- Abr : in ; Type : arbre
         -- Résultat : retourne un booléen
         -- Pré : /
         -- Post : retourne true si l'arbre est vide
         -- Exception : /

         function arbre_est_vide (Abr : in arbre) return Boolean;

         -- Nom : valeur_racine
         -- Sémantique : Cette fonction retourne la valeur contenu dans la racine d'un arbre Abr
         -- Paramètres :
         -- Abr : in ; Type : arbre
         -- Résultat : retourne un T_élément_arbre
         -- Pré : /
         -- Post : /
         -- Exception : arbre est vide

         function valeur_racine (Abr : in arbre) return T_Element_arbre;

         -- Nom : arbre_sans_fils
         -- Sémantique : Cette fonction permet de vérifier si l'arbre n'a pas de fils
         -- Paramètres :
         -- Abr : in ; Type : arbre
         -- Résultat : retourne true si l'arbre n'a pas de fils
         -- Pré : /
         -- Post : retourne true si l'arbre n'a pas de fils
         -- Exception : arbre est vide

         function arbre_sans_fils (Abr : in arbre) return Boolean;

         -- Nom : Rechercher
         -- Sémantique : Cette fonction permet de rechercher dans l'arbre un élément
         -- et elle renvoie l'arbre dont l'élément est la racine, si l'élément n'est pas présent elle renvoie un arbre vide
         -- Paramètres :
         -- Abr : in ; Type : arbre
         -- element : in ; Type : T_Element_arbre
         -- Résultat : retourne un arbre dont l'élément cherché est la racine
         -- Pré : /
         -- Post : /
         -- Exception : /

         function Rechercher (Abr : in arbre ; element : in T_Element_arbre) return arbre;

         -- Nom : est_racine
         -- Sémantique : Cette fonction permet de vérifier si l'arbre est sans père
         -- Paramètres :
         -- Abr : in ; Type : arbre
         -- Résultat :retourne true si l'arbre n'a pas de père
         -- Pré : /
         -- Post : retourne vrai si pas de père
         -- Exception : /

         function est_racine (Abr : in arbre) return Boolean;

         -- Nom : Modifier
         -- Sémantique : Cette procédure permet de modifier dans l'élément à la racine de l'arbre
         -- Paramètres :
         -- Abr : in out ; Type : arbre
         -- nouvelle_donnee : in ; Type : T_Element_arbre
         -- Résultat : /
         -- Pré : /
         -- Post : /
         -- Exception : arbre est vide

         procedure Modifier (Abr : in out arbre ; nouvelle_donnee : in T_Element_arbre);

         -- Nom : afficher
         -- Sémantique : Cette procedure generique permet d'afficher le contenu complet d'un arbre
         -- Paramètres :
         -- Abr : in ; Type : arbre
         -- niv : in ; Type : Integer
         -- Résultat : /
         -- Pré : /
         -- Post : /
         -- Exception : /
         generic
                  with procedure afficher_generique (e : in T_Element_arbre);
         procedure afficher (Abr : in arbre ; niv : in Integer);

         -- Nom : inserer_fils
         -- Sémantique : Cette procedure permet d'inserer un arbre en tant que premier fils d'un arbre
         -- l'ancien fils ainee devient un frère
         -- Paramètres :
         -- Abr : in out ; Type : arbre
         -- Abr_inseree : in out ; Type : arbre
         -- Résultat : /
         -- Pré : /
         -- Post : nouveau fils
         -- Exception : arbre est vide ; arbre a inser vide

         procedure inserer_fils (Abr : in out arbre ; Abr_inseree : in out arbre);

         -- Nom : supprimer
         -- Sémantique : Cette procédure permet de supprimer le fils correspondant à la donnee specifiee
         -- Paramètres :
         -- Abr : in out ; Type : arbre
         -- donnee : in ; Type : T_Element_arbre
         -- Résultat : /
         -- Pré : /
         -- Post : arbre fils supprimer ainsi que ces potentiels propres fils
         -- Exception : /

         procedure supprimer (Abr : in out arbre ; donnee : in T_Element_arbre);

         -- Nom : inserer_element
         -- Sémantique : Cette fonction permet de créer un arbre avec une donnée.
         -- Paramètres :
         -- donnee : in ; Type : T_Element_arbre
         -- Résultat : retourne un arbre
         -- Pré : /
         -- Post : /
         -- Exception : /

         function inserer_element (donnee : in T_Element_arbre) return arbre;

         -- Nom : retourne_pere
         -- Sémantique : Cette fonction permet de retourner la valeur spécifiée dans le noeud père s'il n'y pas de père on renvoie la valeur
         -- qui est dans la racine.
         -- Paramètres :
         -- Abr : in ; Type : arbre
         -- Résultat : retourne un element générique
         -- Pré : /
         -- Post : /
         -- Exception : arbre est vide

         function retourne_pere (Abr : in arbre) return T_Element_arbre;

         -- Nom : retourne_fils
         -- Sémantique : Cette procedure permet de retourner l'arbre dont la racine est le fils specifie
         -- Paramètres :
         -- Abr : in ; Type : arbre
         -- Résultat : /
         -- Pré : /
         -- Post : /
         -- Exception : arbre est vide ; pas de fils

         generic
                  with procedure afficher_generique (e : in T_Element_arbre);
         procedure retourne_fils (Abr : in arbre);

         -- Nom : retour_fils
         -- Sémantique : Cette fonction permet de retourner la valeur du fils ainee ou s'il le noeud n'a pas de fils la valeur stockee dans le noeud
         -- Paramètres :
         -- Abr : in ; Type : arbre
         -- Résultat : retourne un element
         -- Pré : /
         -- Post : /
         -- Exception : arbre est vide

         function retour_fils_ainee (Abr: in arbre) return T_Element_arbre;



         arbre_vide : exception;
         pas_de_fils : exception;
         arbre_a_inser_vide : exception;

private
         type noeud;
         type arbre is access noeud;
         type noeud is record
                  element : T_Element_arbre;
                  frere : arbre;
                  fils_ainee : arbre;
                  pere : arbre;
         end record;
end arbre;
