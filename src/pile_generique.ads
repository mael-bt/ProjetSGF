-- package g�n�rique pile --

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
         -- S�mantique : Cette procedure permet d'empiler un element generique dans la pile 
         -- Param�tres :
         -- P : in out ; Type : Pile 
         -- V : in ; Type : Element
         -- R�sultat : /
         -- Pr� : /
         -- Post : a chaque element empiler la pile augmente de 1
         -- Exception : /

         procedure Empiler (P : in out Pile ; V : in Element);
         
         -- Nom : Depiler
         -- S�mantique : Cette fonction permet de depiler un l'element en tete de la pile et de retourner sa valeur 
         -- Param�tres :
         -- P : in out ; Type : Pile 
         -- R�sultat : retourne l'element generique correspondant � la tete de pile
         -- Pr� : /
         -- Post : a chaque element depiler la pile baisse de 1
         -- Exception : /
   
         function Depiler (P : in out Pile) return Element;
         
         -- Nom : Sommet
         -- S�mantique : Cette fonction permet de retourner la valeur de la tete de pile 
         -- Param�tres :
         -- P : in ; Type : Pile 
         -- R�sultat : retourne un element generique 
         -- Pr� : /
         -- Post : /
         -- Exception : /
   
         function Sommet (P : in Pile) return Element;
         
         -- Nom : est_vider
         -- S�mantique : Cette fonction permet de savoir si la pile est vide 
         -- Param�tres :
         -- P : in ; Type : Pile 
         -- R�sultat : retourne un booleen 
         -- Pr� : /
         -- Post : retourne true si la pile est vide 
         -- Exception : /
   
         function Est_Vider (P : in Pile) return Boolean;
   

         Pile_Vide: exception;


end Pile_Generique;
