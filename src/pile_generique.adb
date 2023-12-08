with Ada.Text_IO; use Ada.Text_IO;

package body Pile_Generique is

         procedure Empiler (P : in out Pile ; V : in Element) is
                  E : Element_Pile;
         begin
                  E.Valeur := V;
                  E.Suivant := P.Tete;
                  P.Tete := new Element_Pile'(E);
                  P.Taille := P.Taille + 1;
         end;

         function Depiler (P : in out Pile) return Element is
                  E : Element_Pile;
         begin
                  if P.Tete = null then
                           raise Pile_Vide;
                  else
                           E := P.Tete.all;
                           P.Tete := P.Tete.Suivant;
                           P.Taille := P.Taille - 1;
                           return E.Valeur;
                  end if;
         end;

         function Sommet (P : in Pile) return Element is
         begin
                  if P.Tete = null then
                           raise Pile_Vide;
                  else
                           return P.Tete.all.Valeur;
                  end if;
         end;

         function Est_Vider (P : in Pile) return Boolean is
         begin
                  return P.Tete = null;
         end;


end Pile_Generique;
