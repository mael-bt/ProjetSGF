-- Test du module SGF --

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with SGF; use SGF;

procedure sgf_test is

         v1, v2 : sgf_arbre.arbre; --arbre racine
         res_taille : Integer := 0;

begin
         formatage_disque(v1);

         creation_dossier(Abr_total   => v1,
                          nom         => To_Unbounded_String("/"),
                          nom_dossier => To_Unbounded_String("Photos"));

         creation_dossier(Abr_total   => v1,
                          nom         => To_Unbounded_String("/"),
                          nom_dossier => To_Unbounded_String("Divers"));

         creation_dossier(Abr_total   => v1,
                          nom         => To_Unbounded_String("/"),
                          nom_dossier => To_Unbounded_String("N7 1APP"));

         creation_dossier(Abr_total   => v1,
                          nom         => To_Unbounded_String("Photos"),
                          nom_dossier => To_Unbounded_String("winter"));

         creation_dossier(Abr_total   => v1,
                          nom         => To_Unbounded_String("Photos"),
                          nom_dossier => To_Unbounded_String("summer"));

         creation_dossier(Abr_total   => v1,
                          nom         => To_Unbounded_String("summer"),
                          nom_dossier => To_Unbounded_String("2012"));

         creation_dossier(Abr_total   => v1,
                          nom         => To_Unbounded_String("Divers"),
                          nom_dossier => To_Unbounded_String("jeux"));

         creation_dossier(Abr_total   => v1,
                          nom         => To_Unbounded_String("N7 1APP"),
                          nom_dossier => To_Unbounded_String("projet"));

         creation_fichier(Abr_total   => v1,
                          nom         => To_Unbounded_String("N7 1APP"),
                          nom_fichier => To_Unbounded_String("edt.txt"));

         creation_fichier(Abr_total   => v1,
                          nom         => To_Unbounded_String("N7 1APP"),
                          nom_fichier => To_Unbounded_String("alternance.txt"));

         creation_fichier(Abr_total   => v1,
                          nom         => To_Unbounded_String("projet"),
                          nom_fichier => To_Unbounded_String("ada.txt"));

         creation_fichier(Abr_total   => v1,
                          nom         => To_Unbounded_String("winter"),
                          nom_fichier => To_Unbounded_String("faisfroid.txt"));

         Put_Line("");
         Put_Line("----------------------------------------------------------");

         afficher_arborescence (Abr_total => v1);

         Put_Line("");
         Put_Line("----------------------------------------------------------");


         v2 := navigation(Abr_total => v1,
                          nom       => To_Unbounded_String("Photos"));

         affichage_dossier_courant(nom       => To_Unbounded_String("Photos"),
                                   Abr_total => v2);

         Put_Line("");
         Put_Line("----------------------------------------------------------");


         affichage_dossier_courant(nom       => To_Unbounded_String("N7 1APP"),
                                   Abr_total => v1);

         Put_Line("");
         Put_Line("----------------------------------------------------------");


         repertoire_travail(Abr_total => v1,
                            nom       => To_Unbounded_String("faisfroid.txt"));

         Put_Line("");
         Put_Line("----------------------------------------------------------");


         repertoire_travail(Abr_total => v1,
                            nom       => To_Unbounded_String("jeux"));

         Put_Line("");
         Put_Line("----------------------------------------------------------");


         suppression_fichier(nom       => To_Unbounded_String("faisfroid.txt"),
                             Abr_total => v1);

         afficher_arborescence(Abr_total => v1);


         Put_Line("");
         Put_Line("----------------------------------------------------------");


         suppression_fichier(nom       => To_Unbounded_String("ada.txt"),
                             Abr_total => v1);

         afficher_arborescence(Abr_total => v1);


         Put_Line("");
         Put_Line("----------------------------------------------------------");


         suppression_dossier(nom       => To_Unbounded_String("summer"),
                             Abr_total => v1);

         afficher_arborescence(Abr_total => v1);


         Put_Line("");
         Put_Line("----------------------------------------------------------");


         suppression_dossier(nom       => To_Unbounded_String("Divers"),
                             Abr_total => v1);

         afficher_arborescence(Abr_total => v1);


         Put_Line("");
         Put_Line("----------------------------------------------------------");


         creation_dossier(Abr_total   => v1,
                          nom         => To_Unbounded_String("winter"),
                          nom_dossier => To_Unbounded_String("summer"));

         creation_dossier(Abr_total   => v1,
                          nom         => To_Unbounded_String("/"),
                          nom_dossier => To_Unbounded_String("Divers"));

         creation_dossier(Abr_total   => v1,
                          nom         => To_Unbounded_String("Divers"),
                          nom_dossier => To_Unbounded_String("jeux"));


         creation_fichier(Abr_total   => v1,
                          nom         => To_Unbounded_String("projet"),
                          nom_fichier => To_Unbounded_String("ada.txt"));

         creation_fichier(Abr_total   => v1,
                          nom         => To_Unbounded_String("winter"),
                          nom_fichier => To_Unbounded_String("faisfroid.txt"));


         afficher_arborescence(Abr_total => v1);


         deplacer(Abr_total     => v1,
                  nom_cible     => To_Unbounded_String("Photos"),
                  dossier_cible => To_Unbounded_String("Divers"));


         afficher_arborescence(Abr_total => v1);


         Put_Line("");
         Put_Line("----------------------------------------------------------");

         suppression_dossier(nom       => To_Unbounded_String("winter"),
                             Abr_total => v1);


         afficher_arborescence(Abr_total => v1);


         Put_Line("");
         Put_Line("----------------------------------------------------------");


         deplacer(Abr_total     => v1,
                  nom_cible     => To_Unbounded_String("ada.txt"),
                  dossier_cible => To_Unbounded_String("/"));


         afficher_arborescence(Abr_total => v1);

         Put_Line("");
         Put_Line("----------------------------------------------------------");



         res_taille := taille_fichier (Abr_total => v1,
                        nom       => To_Unbounded_String("alternance.txt"),
                        Taille    => 2);

         Put(Integer'Image(res_taille));


         Put_Line("");
         Put_Line("----------------------------------------------------------");


         affichage_modif_droits(nom       => To_Unbounded_String("projet"),
                                Abr_total => v1);

         Put_Line("");
         Put_Line("----------------------------------------------------------");


         copie_dossier_fichier(nom         => To_Unbounded_String("N7 1APP"),
                               destination => To_Unbounded_String("Divers"),
                               Abr_total   => v1);


         afficher_arborescence(Abr_total => v1);


         Put_Line("");
         Put_Line("----------------------------------------------------------");


         suppression_fichier(nom       => To_Unbounded_String("ada.txt"),
                             Abr_total => v1);


         afficher_arborescence(Abr_total => v1);


         Put_Line("");
         Put_Line("----------------------------------------------------------");

end sgf_test;
