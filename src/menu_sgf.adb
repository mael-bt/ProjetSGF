-- Menu du SGF --

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with SGF; use SGF;

package body menu_sgf is
         
         a1 : sgf_arbre.arbre;
         a2 : sgf_arbre.arbre;
         choix : Integer := 1;
         nom1 : Unbounded_String;
         nom2 : Unbounded_String;
         nom3 : Unbounded_String;
         nom4 : Unbounded_String;
         nom5 : Unbounded_String;
         nom6 : Unbounded_String;
         nom7 : Unbounded_String;
         nom8 : Unbounded_String;
         nom9 : Unbounded_String;
         nom10 : Unbounded_String;
         nom11 : Unbounded_String;
         nom12 : Unbounded_String;
         nom13 : Unbounded_String;
         nom14 : Unbounded_String;
         nom15 : Unbounded_String;
         taille : Integer := 0;
         res_taille : Integer := 0;
         
         procedure main_menu is 
         begin
                  while choix /= 0 loop
                           commande_menu;
                  end loop;
                  if choix = 0 then 
                           Put_Line("Au revoir !");
                  end if;
         end main_menu;
         
         
         procedure commande_menu is 
         begin
                  
                  
                  new_line;
                  put_line("                         Bienvenue dans le menu du SGF                       ");
                  put_line(" 1- Formatage du disque C");
                  put_line(" 2- mkdir");
                  put_line(" 3- touch");
                  put_line(" 4- rm");
                  put_line(" 5- rm -r");
                  put_line(" 6- mv");
                  put_line(" 7- ls");
                  put_line(" 8- cp -r");
                  put_line(" 9- ls -l");
                  put_line(" 10- cd");
                  put_line(" 11- pwd");
                  put_line(" 12- tree");
                  put_line(" 13- txt");
                  put_line(" 14- ls -r");
                  put_line(" 0- Quitter le SGF");



                  new_line;
                  put("Veuillez choisir une fonctionnalitee parmi celles qui figurent sur le menu : ");
                  get(choix);
                  case choix is
                           when 1 => formatage_disque(a1);
                                    Put_Line("Le disque a été formaté");
                                    new_line;
                           when 2 => Put_Line("Donner le nom du dossier a créer : ");
                                    nom1 := To_Unbounded_String(Get_Line);
                                    Skip_Line;
                                    Put_Line("Donner le dossier où vous voulez le créer : ");
                                    nom2 := To_Unbounded_String(Get_Line);
                                    creation_dossier(Abr_total   => a1,
                                                     nom         => nom2,
                                                     nom_dossier => nom1);
                                    New_Line;
                                    afficher_arborescence(a1);
                           when 3 => Put_Line("Donner le nom du fichier txt à créer : ");
                                    nom3 := To_Unbounded_String(Get_Line);
                                    Skip_Line;
                                    Put_Line("Donner le dossier où vous voulez le créer : ");
                                    nom4 := To_Unbounded_String(Get_Line);
                                    creation_fichier(Abr_total   => a1,
                                                     nom         => nom4,
                                                     nom_fichier => nom3);
                                    new_line;
                                    afficher_arborescence(a1);
                           when 4 => Put_Line("Donner le nom du fichier à supprimer : ");
                                    nom5 := To_Unbounded_String(Get_Line);
                                    Skip_Line;
                                    suppression_fichier(nom       => nom5,
                                                        Abr_total => a1);
                                    New_Line;
                           when 5 => Put_Line("Donner le nom du dossier à supprimer : ");
                                    nom6 := To_Unbounded_String(Get_Line);
                                    Skip_Line;
                                    suppression_dossier(nom       => nom6,
                                                        Abr_total => a1);
                                    new_line;
                           when 6 => Put_Line("Donner le nom du dossier ou fichier à déplacer : ");
                                    nom7 := To_Unbounded_String(Get_Line);
                                    Skip_Line;
                                    Put_Line("Donner le nom du dossier où vous voulez le déplacer : ");
                                    nom8 := To_Unbounded_String(Get_Line);
                                    deplacer(Abr_total     => a1,
                                             nom_cible     => nom7,
                                             dossier_cible => nom8);
                                    new_line;
                           when 7 => Put_Line("Donner le nom du dossier : ");
                                    nom9 := To_Unbounded_String(Get_Line);
                                    Skip_Line;
                                    affichage_dossier_courant(nom       => nom9,
                                                              Abr_total => a1);
                                    new_line;
                           when 8 => Put_Line("Donner le nom du dossier ou fichier que vous souhaitez copier : ");
                                    nom10 := To_Unbounded_String(Get_Line);
                                    Skip_Line;
                                    Put_Line("Donner le nom du dossier où vous voulez coller : ");
                                    nom11 := To_Unbounded_String(Get_Line);
                                    copie_dossier_fichier(nom         => nom10,
                                                          destination => nom11,
                                                          Abr_total   => a1);
                                    new_line;
                           when 9 => Put_Line("Donner le nom du dossier ou fichier pour lequel vous souhaitez connaitre les droits : ");
                                    nom12 := To_Unbounded_String(Get_Line);
                                    Skip_Line;
                                    affichage_modif_droits(nom       => nom12,
                                                           Abr_total => a1);
                                    new_line;
                           when 10 => Put_Line("Donner le nom du dossier : ");
                                    nom13 := To_Unbounded_String(Get_Line);
                                    Skip_Line;
                                    a2 := navigation(Abr_total => a1,
                                                     nom       => nom13);
                                    new_line;
                           when 11 => Put_Line("Donner le nom du dossier ou fichier dont vous voulez connaitre le chemin : ");
                                    nom14 := To_Unbounded_String(Get_Line);
                                    Skip_Line;
                                    repertoire_travail(Abr_total => a1,
                                                       nom       => nom14);
                                    new_line;
                           when 12 => afficher_arborescence(Abr_total => a1);
                                    New_Line;
                           when 13 => Put_Line("Donner le nom du fichier à modifier : ");
                                    nom15 := To_Unbounded_String(Get_Line);
                                    Skip_Line;
                                    Get(taille);
                                    Skip_Line;
                                    res_taille := taille_fichier(Abr_total => a1,
                                                                 nom       => nom15,
                                                                 Taille    => taille);
                                    Put_Line(Integer'Image(res_taille));
                                    new_line;
                           when 14 => Put_Line("Donner le nom du dossier : ");
                                    nom13 := To_Unbounded_String(Get_Line);
                                    Skip_Line;
                                    a2 := navigation(Abr_total => a1,
                                                     nom       => nom13);
                                    afficher_arborescence(a2);
                                    New_Line;
                           when others => put_line("Ce choix ne figure pas dans le menu, veuillez réessayer...");
                  end case;

         end commande_menu;




end menu_sgf;
