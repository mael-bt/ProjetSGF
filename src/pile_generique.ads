-- package générique pile --

generic
         type Element is private; 

package Pile_Generique is

         type Element_Pile is record
                  Valeur : Element;
                  Suivant : access Element_Pile;
         end record;

         type Pile is record
                  Tete : access Element_Pile;
                  Taille : Integer;
         end record;
         
         -- Nom : Empiler
         -- Sémantique : Cette procedure permet d'empiler un element generique dans la pile 
         -- Paramètres :
         -- P : in out ; Type : Pile 
         -- V : in ; Type : Element
         -- Résultat : /
         -- Pré : /
         -- Post : a chaque element empiler la pile augmente de 1
         -- Exception : /

         procedure Empiler (P : in out Pile ; V : in Element);
         
         -- Nom : Depiler
         -- Sémantique : Cette fonction permet de depiler un l'element en tete de la pile et de retourner sa valeur 
         -- Paramètres :
         -- P : in out ; Type : Pile 
         -- Résultat : retourne l'element generique correspondant à la tete de pile
         -- Pré : /
         -- Post : a chaque element depiler la pile baisse de 1
         -- Exception : /
   
         function Depiler (P : in out Pile) return Element;
         
         -- Nom : Sommet
         -- Sémantique : Cette fonction permet de retourner la valeur de la tete de pile 
         -- Paramètres :
         -- P : in ; Type : Pile 
         -- Résultat : retourne un element generique 
         -- Pré : /
         -- Post : /
         -- Exception : /
   
         function Sommet (P : in Pile) return Element;
         
         -- Nom : est_vider
         -- Sémantique : Cette fonction permet de savoir si la pile est vide 
         -- Paramètres :
         -- P : in ; Type : Pile 
         -- Résultat : retourne un booleen 
         -- Pré : /
         -- Post : retourne true si la pile est vide 
         -- Exception : /
   
         function Est_Vider (P : in Pile) return Boolean;
   

         Pile_Vide: exception;


end Pile_Generique;
