-- Test du module generique arbre --

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with arbre;

procedure arbre_test is

         function egalite (a : in Unbounded_String ; b : in Unbounded_String) return Boolean;

         function egalite (a: in Unbounded_String; b: in Unbounded_String) return Boolean is
         begin
                  return a = b;
         end egalite;

         package arbre_string is new arbre(Unbounded_String, egalite);
         use arbre_string;

         procedure affiche_element_string (e : in Unbounded_String) is
         begin
                  Put_Line(To_String(e));
         end affiche_element_string;

         procedure afficher_fils is new arbre_string.retourne_fils(afficher_generique => affiche_element_string);

         procedure afficher_in is new arbre_string.afficher(afficher_generique => affiche_element_string);

         a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11 : arbre_string.arbre;
         isnull : Boolean;
         b : Unbounded_String ;
         res_nb_fils : Integer := 0;

begin
         initialiser(a1);
         isnull := arbre_est_vide(a1);
         Put_Line("------------------------------");
         Put(Boolean'Image(isnull));
         Put_Line("");
         Put_Line("------------------------------");
         a1 := inserer_element(To_Unbounded_String("/"));
         b := valeur_racine(a1);
         Put(To_String(b));
         Put_Line("");
         Put_Line("------------------------------");
         isnull := arbre_est_vide(a1);
         Put_Line(Boolean'Image(isnull));
         Put_Line("------------------------------");
         Modifier(a1, To_Unbounded_String("root"));
         a2 := inserer_element(To_Unbounded_String("photos"));
         a3 := inserer_element(To_Unbounded_String("summer"));
         a5 := inserer_element(To_Unbounded_String("divers"));
         a6 := inserer_element(To_Unbounded_String("2012"));
         a7 := inserer_element(To_Unbounded_String("jeux"));
         a8 := inserer_element(To_Unbounded_String("winter"));
         a9 := inserer_element(To_Unbounded_String("N7 1APP"));
         a10 := inserer_element(To_Unbounded_String("projet"));
         inserer_fils(a2, a3);
         inserer_fils(a2, a8);
         inserer_fils(a3, a6);
         inserer_fils(a5, a7);
         inserer_fils(a9, a10);
         inserer_fils(a1, a9);
         inserer_fils(a1, a5);
         inserer_fils(a1,a2);
         afficher_in(a1,0);
         Put_Line("------------------------------");
         a4 := Rechercher(a1,To_Unbounded_String("/"));
         afficher_in(a4,0);
         Put_Line("------------------------------");
         isnull := est_racine(a8);
         Put_Line(Boolean'Image(isnull));
         Put_Line("------------------------------");
         isnull := arbre_sans_fils(a6);
         Put_Line(Boolean'Image(isnull));
         Put_Line("------------------------------");
         isnull := arbre_sans_fils(a3);
         Put_Line(Boolean'Image(isnull));
         Put_Line("------------------------------");
         supprimer (a1, To_Unbounded_String("jeux"));
         afficher_in(a1,0);
         Put_Line("------------------------------");
         supprimer (a1, To_Unbounded_String("N7 1APP"));
         afficher_in(a1,0);
         Put_Line("------------------------------");
         b := retourne_pere(a8);
         Put(To_String(b));
         Put_Line("");
         Put_Line("------------------------------");
         supprimer (a1, To_Unbounded_String("summer"));
         afficher_in(a1,0);
         Put_Line("");
         Put_Line("------------------------------");
         afficher_fils(a1);
         Put_Line("");
         Put_Line("------------------------------");
         a11 := Rechercher(a1,To_Unbounded_String("summer"));
         isnull := arbre_est_vide(a11);
         Put(Boolean'Image(isnull));
end arbre_test;
