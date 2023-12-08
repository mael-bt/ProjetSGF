-- Arbre de recherche generique --

generic
         type T_Element_arbre is private;
         with function isEqual (a : in T_Element_arbre ; b : in T_Element_arbre) return Boolean;

package arbre is

         type arbre is private;


         -- Nom : init
         -- S�mantique : Cette procedure permet de creer un arbre vide
         -- Param�tres :
         -- Abr : out ; Type : arbre
         -- R�sultat : /
         -- Pr� : /
         -- Post : initialise un abre n-aire vide
         -- Exception : /

         procedure initialiser (Abr : out arbre);

         -- Nom : arbre_est_vide
         -- S�mantique : Cette fonction permet de v�rifier si l'arbre est vide
         -- Param�tres :
         -- Abr : in ; Type : arbre
         -- R�sultat : retourne un bool�en
         -- Pr� : /
         -- Post : retourne true si l'arbre est vide
         -- Exception : /

         function arbre_est_vide (Abr : in arbre) return Boolean;

         -- Nom : valeur_racine
         -- S�mantique : Cette fonction retourne la valeur contenu dans la racine d'un arbre Abr
         -- Param�tres :
         -- Abr : in ; Type : arbre
         -- R�sultat : retourne un T_�l�ment_arbre
         -- Pr� : /
         -- Post : /
         -- Exception : arbre est vide

         function valeur_racine (Abr : in arbre) return T_Element_arbre;

         -- Nom : arbre_sans_fils
         -- S�mantique : Cette fonction permet de v�rifier si l'arbre n'a pas de fils
         -- Param�tres :
         -- Abr : in ; Type : arbre
         -- R�sultat : retourne true si l'arbre n'a pas de fils
         -- Pr� : /
         -- Post : retourne true si l'arbre n'a pas de fils
         -- Exception : arbre est vide

         function arbre_sans_fils (Abr : in arbre) return Boolean;

         -- Nom : Rechercher
         -- S�mantique : Cette fonction permet de rechercher dans l'arbre un �l�ment
         -- et elle renvoie l'arbre dont l'�l�ment est la racine, si l'�l�ment n'est pas pr�sent elle renvoie un arbre vide
         -- Param�tres :
         -- Abr : in ; Type : arbre
         -- element : in ; Type : T_Element_arbre
         -- R�sultat : retourne un arbre dont l'�l�ment cherch� est la racine
         -- Pr� : /
         -- Post : /
         -- Exception : /

         function Rechercher (Abr : in arbre ; element : in T_Element_arbre) return arbre;

         -- Nom : est_racine
         -- S�mantique : Cette fonction permet de v�rifier si l'arbre est sans p�re
         -- Param�tres :
         -- Abr : in ; Type : arbre
         -- R�sultat :retourne true si l'arbre n'a pas de p�re
         -- Pr� : /
         -- Post : retourne vrai si pas de p�re
         -- Exception : /

         function est_racine (Abr : in arbre) return Boolean;

         -- Nom : Modifier
         -- S�mantique : Cette proc�dure permet de modifier dans l'�l�ment � la racine de l'arbre
         -- Param�tres :
         -- Abr : in out ; Type : arbre
         -- nouvelle_donnee : in ; Type : T_Element_arbre
         -- R�sultat : /
         -- Pr� : /
         -- Post : /
         -- Exception : arbre est vide

         procedure Modifier (Abr : in out arbre ; nouvelle_donnee : in T_Element_arbre);

         -- Nom : afficher
         -- S�mantique : Cette procedure generique permet d'afficher le contenu complet d'un arbre
         -- Param�tres :
         -- Abr : in ; Type : arbre
         -- niv : in ; Type : Integer
         -- R�sultat : /
         -- Pr� : /
         -- Post : /
         -- Exception : /
         generic
                  with procedure afficher_generique (e : in T_Element_arbre);
         procedure afficher (Abr : in arbre ; niv : in Integer);

         -- Nom : inserer_fils
         -- S�mantique : Cette procedure permet d'inserer un arbre en tant que premier fils d'un arbre
         -- l'ancien fils ainee devient un fr�re
         -- Param�tres :
         -- Abr : in out ; Type : arbre
         -- Abr_inseree : in out ; Type : arbre
         -- R�sultat : /
         -- Pr� : /
         -- Post : nouveau fils
         -- Exception : arbre est vide ; arbre a inser vide

         procedure inserer_fils (Abr : in out arbre ; Abr_inseree : in out arbre);

         -- Nom : supprimer
         -- S�mantique : Cette proc�dure permet de supprimer le fils correspondant � la donnee specifiee
         -- Param�tres :
         -- Abr : in out ; Type : arbre
         -- donnee : in ; Type : T_Element_arbre
         -- R�sultat : /
         -- Pr� : /
         -- Post : arbre fils supprimer ainsi que ces potentiels propres fils
         -- Exception : /

         procedure supprimer (Abr : in out arbre ; donnee : in T_Element_arbre);

         -- Nom : inserer_element
         -- S�mantique : Cette fonction permet de cr�er un arbre avec une donn�e.
         -- Param�tres :
         -- donnee : in ; Type : T_Element_arbre
         -- R�sultat : retourne un arbre
         -- Pr� : /
         -- Post : /
         -- Exception : /

         function inserer_element (donnee : in T_Element_arbre) return arbre;

         -- Nom : retourne_pere
         -- S�mantique : Cette fonction permet de retourner la valeur sp�cifi�e dans le noeud p�re s'il n'y pas de p�re on renvoie la valeur
         -- qui est dans la racine.
         -- Param�tres :
         -- Abr : in ; Type : arbre
         -- R�sultat : retourne un element g�n�rique
         -- Pr� : /
         -- Post : /
         -- Exception : arbre est vide

         function retourne_pere (Abr : in arbre) return T_Element_arbre;

         -- Nom : retourne_fils
         -- S�mantique : Cette procedure permet de retourner l'arbre dont la racine est le fils specifie
         -- Param�tres :
         -- Abr : in ; Type : arbre
         -- R�sultat : /
         -- Pr� : /
         -- Post : /
         -- Exception : arbre est vide ; pas de fils

         generic
                  with procedure afficher_generique (e : in T_Element_arbre);
         procedure retourne_fils (Abr : in arbre);

         -- Nom : retour_fils
         -- S�mantique : Cette fonction permet de retourner la valeur du fils ainee ou s'il le noeud n'a pas de fils la valeur stockee dans le noeud
         -- Param�tres :
         -- Abr : in ; Type : arbre
         -- R�sultat : retourne un element
         -- Pr� : /
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
