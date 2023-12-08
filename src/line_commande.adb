-- Affichage en ligne de commande -- 

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with SGF; use SGF;

package body line_commande is
         
         b1 : sgf_arbre.arbre;
         b2 : sgf_arbre.arbre;
         taille : Integer;
         res_taille : Integer;
         
         procedure Terminal is 
                  
                  commande : String(1..100);
                  fini : Boolean := False;
                  longueur_commande : Integer;
                  a1 : sgf_arbre.arbre;
         begin
                  New_Line;
                  formatage_disque(b1);
                  put_line("                         Bienvenue dans la liste des commandes du SGF :                       ");
                  put_line("mkdir");
                  put_line("touch");
                  put_line("rm");
                  put_line("rrm                  correspond a la commande rm -r");  
                  put_line("mv");
                  put_line("ls");
                  put_line("cpr                  correspond a la commande cp -r");
                  put_line("lls                  correspond a la commande ls -l"); 
                  Put_Line("rls                  correspond a la commande ls -r");
                  put_line("cd");
                  put_line("pwd");
                  put_line("tree");
                  put_line("txt");
                  put_line("shutdown");
                  New_Line;
                  While not fini loop
                           Put("user@PC:~$ ");
                           Get_Line(commande,longueur_commande);
                           If commande(1..8) = "shutdown" then
                                    fini := true;
                           Else
                                    commande_line(commande          => commande,
                                                  longueur_commande => longueur_commande);
                                    fini := false;
                           End If;
                  End Loop;
                  New_Line;
                  Put_Line("Le programme est termine pour le relancer taper dans votre terminal ./main");
                  New_Line;
         end Terminal;
         
         procedure commande_line (commande : in String ; longueur_commande : in Integer) is 
                  nom : Unbounded_String;
                  nom1 : Unbounded_String;
         begin
                  if commande(commande'First..commande'First + 4) = "mkdir" then 
                           Put_Line("Donner le nom du dossier a creer : ");
                           nom := To_Unbounded_String(Get_Line);
                           Put_Line("Donner le nom du dossier ou vous voulez le creer : ");
                           nom1 := To_Unbounded_String(Get_Line);
                           creation_dossier(Abr_total   => b1,
                                            nom         => nom1,
                                            nom_dossier => nom);
                  elsif commande(commande'First..commande'First + 4) = "touch" then
                           Put_Line("Donner le nom du fichier a creer : ");
                           nom := To_Unbounded_String(Get_Line);
                           Put_Line("Donner le nom du dossier ou vous voulez le creer : ");
                           nom1 := To_Unbounded_String(Get_Line);
                           creation_fichier(Abr_total   => b1,
                                            nom         => nom1,
                                            nom_fichier => nom);
                  elsif commande(commande'First..commande'First + 1) = "rm" then
                           Put_Line("Donner le nom du fichier a supprimer : ");
                           nom := To_Unbounded_String(Get_Line);
                           suppression_fichier(nom       => nom,
                                               Abr_total => b1);
                  elsif commande(commande'First..commande'First + 1) = "mv" then
                           Put_Line("Donner le nom du dossier ou fichier a deplacer : ");
                           nom := To_Unbounded_String(Get_Line);
                           Put_Line("Donner le nom du dossier ou vous voulez le deplacer : ");
                           nom1 := To_Unbounded_String(Get_Line);
                           deplacer(Abr_total     => b1,
                                    nom_cible     => nom,
                                    dossier_cible => nom1);
                  elsif commande(commande'First..commande'First + 1) = "ls" then
                           Put_Line("Donner le nom du dossier : ");
                           nom := To_Unbounded_String(Get_Line);
                           Put_Line("=====");
                           affichage_dossier_courant(nom       => nom,
                                                     Abr_total => b1);  
                  elsif commande(commande'First..commande'First + 3) = "tree" then
                           afficher_arborescence(b1);
                  elsif commande(commande'First..commande'First + 2) = "pwd" then 
                           Put_Line("Donner le nom du dossier ou fichier dont vous voulez connaitre le chemin : ");
                           nom := To_Unbounded_String(Get_Line);
                           repertoire_travail(Abr_total => b1,
                                              nom       => nom);
                           New_Line;
                  elsif commande(commande'First..commande'First + 1) = "cd" then 
                           Put_Line("Donner le nom du dossier : ");
                           nom := To_Unbounded_String(Get_Line);
                           b2 := navigation(Abr_total => b1,
                                            nom       => nom);
                  elsif commande(commande'First..commande'First + 2) = "txt" then
                           Put_Line("Donner le nom du fichier a modifier : ");
                           nom := To_Unbounded_String(Get_Line);
                           Put_Line("Donner la taille que vous voulez ajouter : ");
                           Get(taille);
                           res_taille := taille_fichier(Abr_total => b1,
                                                        nom       => nom,
                                                        Taille    => taille);
                           Put_Line(To_String(nom) & "----" & Integer'Image(res_taille));
                  elsif commande(commande'First..commande'First + 2) = "rrm" then
                           Put_Line("Donner le nom du dossier a supprimer : ");
                           nom := To_Unbounded_String(Get_Line);
                           suppression_dossier(nom       => nom,
                                               Abr_total => b1);
                  elsif commande(commande'First..commande'First + 2) = "cpr" then
                           Put_Line("Donner le nom du dossier ou fichier que vous souhaitez copier : ");
                           nom := To_Unbounded_String(Get_Line);
                           Put_Line("Donner le nom du dossier ou vous voulez coller : ");
                           nom1 := To_Unbounded_String(Get_Line);
                           copie_dossier_fichier(nom         => nom,
                                                 destination => nom1,
                                                 Abr_total   => b1);
                  elsif commande(commande'First..commande'First + 2) = "lls" then 
                           Put_Line("Donner le nom du dossier ou fichier pour lequel vous souhaitez connaitre les droits : ");
                           nom := To_Unbounded_String(Get_Line);
                           affichage_modif_droits(nom       => nom,
                                                  Abr_total => b1);
                           New_Line;
                  elsif commande(commande'First..commande'First + 2) = "rls" then
                           Put_Line("Donner le nom du dossier : ");
                           nom := To_Unbounded_String(Get_Line);
                           b2 := navigation(Abr_total => b1,
                                            nom       => nom);
                           New_Line;
                           New_Line;
                           afficher_arborescence(Abr_total => b2);
                           New_Line;
                  else 
                           Put_Line("Commande erronee, veuillez reessayer ? ");
                           
                  end if;
                  
         end commande_line;
         

         

end line_commande;
