-- SGF --

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with arbre; 
with Pile_Generique;

package body SGF is
         
         procedure affiche_sgf_string (e : in dossiers_fichiers) is
         begin
                  Put_Line(To_String(e.nom));
         end affiche_sgf_string;
         
         package Pile_gen is new Pile_Generique(Unbounded_String);
         use Pile_gen;
         
         procedure afficher_fils is new sgf_arbre.retourne_fils(afficher_generique => affiche_sgf_string);
         
         procedure afficher_gen is new sgf_arbre.afficher(afficher_generique => affiche_sgf_string);
         
         procedure formatage_disque (Abr_total : in out sgf_arbre.arbre) is
                  v : dossiers_fichiers;
         begin
                  v.nom := To_Unbounded_String("/");  -- On créer un dossier "/" pour symboliser la racine
                  v.isdossier := true;  -- On passe le booléen à true pour montrer qu'il s'agit d'un dossier
                  initialiser(Abr => Abr_total);  -- on initialise avec la procedure de l'arbre qui créée un noeud Abr vide 
                  Abr_total := inserer_element(donnee => v);  -- puis on insère l'element dans le noeud 
         end formatage_disque;
         
         procedure repertoire_travail (Abr_total : in sgf_arbre.arbre ; nom : in Unbounded_String) is 
                  v : dossiers_fichiers;
                  temp : sgf_arbre.arbre; 
                  pile : Pile_gen.Pile;
         begin
                  v.nom := nom; 
                  if not arbre_est_vide(Abr => Abr_total) then  -- si arbre est vide -> exception 
                           temp := Abr_total;  -- sinon on garde l'arbre dans une variable temp 
                           temp := Rechercher(Abr     => temp,
                                              element => v);  -- ce qui va nous permettre de rechercher l'element v dans l'arbre
                           if not arbre_est_vide(Abr => temp) then  
                                    Empiler (P => pile,
                                             V => v.nom);  -- on empile le nom du dossier dont on cherche le chemin si temp est non nul
                           end if;  -- ainsi le nom du dossier sera donc au fond de la pile au moment de dépiler
                           while not est_racine(Abr => temp) loop  -- tant que temp a un pere on boucle ce qui va permettre de remonter jusqu'à la racine  
                                    v := retourne_pere(Abr => temp);  -- on recupere l'element stocker dans le noeud pere 
                                    Empiler(P => pile,
                                            V => v.nom);  -- et on empile cet element dans notre pile 
                                    temp := Rechercher(Abr     => Abr_total,
                                                       element => v);  -- le rechercher permet de passer à l'arbre supérieur à chaque fois 
                           end loop;
                  else
                           raise arbre_vide;
                  end if;
      
                  while not Est_Vider(P => pile) loop  -- tant que la pile n'est pas vide  
                           if v.nom /= "/" then  -- on met un / entre les noms qui sont dépiler pour construire le chemin jusqu'à ce qu'on arrive à la racine 
                                    Put("/");
                           end if;
                           v.nom := Depiler(P => pile);  -- on dépile le sommet de la pile puis on l'affiche et ainsi de suite 
                           Put(To_String(v.nom));
                  end loop;
                  
         end repertoire_travail;
         
         procedure creation_fichier (Abr_total : in sgf_arbre.arbre ; nom : in Unbounded_String; nom_fichier : in Unbounded_String) is
                  temp1, temp2 : sgf_arbre.arbre;
                  v : dossiers_fichiers;
                  a : dossiers_fichiers;
         begin
                  a.nom := nom;  -- on stocke le nom du dossier dans lequel on veut créer le fichier 
                  
                  v.nom := nom_fichier;  -- on stocke le nom du fichier 
                  v.taille := 5;  -- on lui attribue la taille min
                  v.isdossier := false;  -- le booléen est à false puisque c'est un fichier
                  v.droits := To_Unbounded_String("-rw-r--r--");  -- on donne les droits
                  temp1 := inserer_element(donnee => v);  -- on créer un noeud dont la valeur enregistrée est le nom du fichier 
                  temp2 := Rechercher(Abr     => Abr_total,
                                      element => a);  -- on cherche ensuite le dossier dans lequel on souhaite insérer
                  
                  if not arbre_est_vide(Abr => temp2) then  -- si l'arbre temp2 est vide -> exception  
                           inserer_fils(Abr         => temp2,
                                        Abr_inseree => temp1);  -- sinon on peut insérer en tant que fils aînée de temp2 l'arbre temp1 
                  else
                           raise dossier_manquant;
                  end if;
         end creation_fichier;
         
         function navigation (Abr_total : in sgf_arbre.arbre ; nom : in Unbounded_String) return sgf_arbre.arbre is 
                  v : dossiers_fichiers;
                  temp : sgf_arbre.arbre;
                  res : sgf_arbre.arbre;
         begin
                  v.nom := nom;
                  if arbre_est_vide(Abr => Abr_total) then  -- si arbre est vide -> exception 
                           raise arbre_vide;
                  else
                           if arbre_sans_fils(Abr => Abr_total) then  -- sinon si l'arbre est sans fils -> exception
                                    raise est_fichier;
                           else
                                    temp := Rechercher(Abr     => Abr_total,
                                                       element => v);  -- sinon on recherche l'arbre dont la racine contient le nom du dossier cherché 
                                    if arbre_est_vide(Abr => temp) then  -- si cette arbre est vide on met une indication à l'utilisateur 
                                             Put_Line("bash: cd: " & To_String(nom) & ": No such file or directory");
                                    else
                                             res := temp;  -- sinon on retourne l'arbre trouvé
                                    end if;
                           end if;
                  end if;
                  return res;
         end navigation;
         
         procedure affichage_dossier_courant (nom : in Unbounded_String ; Abr_total : in sgf_arbre.arbre) is
                  v : dossiers_fichiers;
                  a : sgf_arbre.arbre;
         begin
                  v.nom := nom;  -- on stocke le nom du dossier pour lequel on veut afficher 
                  a := Rechercher(Abr     => Abr_total,
                                  element => v);  -- on recherche l'arbre dont la racine contient le nom du dossier          
                  if not arbre_est_vide(Abr => a) then  -- si arbre est vide -> exception  
                           afficher_fils(a);  -- sinon on affiche les fils de l'arbre retourné par la recherche  
                  else
                           raise arbre_vide;
                  end if;
         end affichage_dossier_courant;
                  

                  
         procedure suppression_fichier (nom : in Unbounded_String ; Abr_total : in out sgf_arbre.arbre) is
                  v : dossiers_fichiers;
                  temporaire : sgf_arbre.arbre;
         begin
                  v.nom := nom;  -- on stocke le nom du fichier que l'on veut supprimer
                  temporaire := Rechercher(Abr     => Abr_total,
                                           element => v);  -- on recherche l'arbre dont la racine contient le nom du fichier à supprimer
                  if arbre_est_vide(temporaire) then 
                           raise fichier_manquant;
                  else
                           v := valeur_racine(Abr => temporaire);  -- on obtient la valeur contenu dans la racine de l'arbre temporaire 
                           if v.isdossier = false then  -- cela permet de vérifier s'il s'agit d'un dossier ou d'un fichier, si c'est un dossier -> exception 
                                    supprimer(Abr    => Abr_total,
                                              donnee => v);  -- sinon on peut supprimer le noeud contenant le fichier a supprimé
                           else
                                    raise est_dossier;
                           end if;
                  end if;
         end suppression_fichier;
         
         procedure suppression_dossier (nom : in Unbounded_String ; Abr_total : in out sgf_arbre.arbre) is 
                  v : dossiers_fichiers;
                  temporaire : sgf_arbre.arbre;
         begin
                  v.nom := nom;  -- on stocke le nom du dossier que l'on veut supprimer
                  temporaire := Rechercher(Abr     => Abr_total,
                                           element => v);  -- on recherche l'arbre dont la racine contient le nom du dossier à supprimer
                  if arbre_est_vide(temporaire) then 
                           raise dossier_manquant;
                  else
                           v := valeur_racine(Abr => temporaire);  -- on obtient la valeur contenue dans la racine de l'arbre temporaire 
                           if v.isdossier = true then  -- cela permet de vérifier s'il s'agit d'un dossier ou d'un fichier, si c'est un fichier -> exception
                                    supprimer(Abr    => Abr_total,
                                              donnee => v);  -- sinon on peut supprimer le noeud contenant le dossier à supprimer ses fils seront également supprimés
                           else
                                    raise est_fichier;
                           end if;
                  end if;
         end suppression_dossier;
         
         procedure afficher_arborescence (Abr_total : in sgf_arbre.arbre) is
         begin
                  afficher_gen(Abr_total, 0);
         end afficher_arborescence;
         
         procedure creation_dossier (Abr_total : in sgf_arbre.arbre ; nom : in Unbounded_String ; nom_dossier : in Unbounded_String) is 
                  v : dossiers_fichiers;
                  a : dossiers_fichiers;
                  temp1, temp2 : sgf_arbre.arbre;
         begin
                  a.nom := nom;  -- on stocke le nom du dossier dans lequel on veut créer le dossier 
                  
                  v.nom := nom_dossier;  -- on stocke le nom du dossier 
                  v.taille := 10;  -- on lui attribue la taille min
                  v.isdossier := true;  -- le booléen est à true puisque c'est un dossier
                  v.droits := To_Unbounded_String("drw-r--r--");  -- on lui donne les droits
                  temp1 := inserer_element(donnee => v);  -- on créer un noeud dont la valeur enregistrée est le nom du dossier à créer
                  temp2 := Rechercher(Abr     => Abr_total,
                                      element => a);  -- on chercher ensuite le dossier dans lequel on souhaite insérer
                  
                  if not arbre_est_vide(Abr => temp2) then  -- si l'arbre temp2 est vide -> exception
                           inserer_fils(Abr         => temp2,
                                        Abr_inseree => temp1);  -- sinon on peut insérer en tant que fils aînée de temp2 l'arbre temp1
                  else
                           raise dossier_manquant;
                  end if;
                  
         end creation_dossier;
         
         procedure deplacer (Abr_total : in out sgf_arbre.arbre ; nom_cible : in Unbounded_String; dossier_cible : in Unbounded_String) is
                  arbre_temp : sgf_arbre.arbre;
                  dest : sgf_arbre.arbre;
                  temp : sgf_arbre.arbre;
                  a : dossiers_fichiers;
                  v : dossiers_fichiers;
         
         begin
                  a.nom := nom_cible;  -- on stocke le nom du fichier ou dossier que l'on souhaite déplacer
                  arbre_temp := Rechercher(Abr     => Abr_total,
                                           element => a);  -- on recherche l'arbre dont la racine contient le nom du fichier ou dossier 
                  if arbre_est_vide(Abr => arbre_temp) then  -- si l'arbre retourné par la recherche est nul -> exception
                           raise dossier_fichier_manquant;
                  else
                           v.nom := dossier_cible;  -- sinon on stocke dans une autre variable le dossier dans lequel on veut déplacer
                           dest := Rechercher(Abr     => Abr_total,
                                              element => v);  -- on cherche l'arbre dont la racine contient le nom du dossier de destination 
                           if arbre_est_vide(Abr => dest) then  -- si l'arbre retourné est vide -> exception 
                                    raise dossier_manquant;
                           else
                                    temp := inserer_element(donnee => a);  -- sinon on créée un noeud dont le nom enregistré est le nom du fichier ou dossier à déplacer
                                    if not arbre_sans_fils(Abr => arbre_temp) then  -- si l'arbre a un ou des fils  
                                             arbre_temp := Rechercher(Abr     => Abr_total,
                                                                      element => retour_fils_ainee(Abr => arbre_temp));  -- on sauvegarde l'arbre fils (s'il en a un) du noeud que l'on veut déplacer
                                             inserer_fils(Abr         => temp,
                                                          Abr_inseree => arbre_temp);  -- et on réinsère cette arbre en tant que fils aînée au noeud créée
                                    else 
                                             supprimer(Abr    => Abr_total,
                                                       donnee => a);  -- sinon s'il n'a pas de fils on peut supprimer directement 
                                    end if;
                           end if;
                           inserer_fils(Abr         => dest,
                                        Abr_inseree => temp);  -- ensuite on insère en tant que fils le noeud créée et ses potentiels fils dans le dossier de destination
                  end if;
         end deplacer;
         
         function taille_fichier (Abr_total : in sgf_arbre.arbre ; nom : in Unbounded_String ; Taille : in Integer) return Integer is  
                  v : dossiers_fichiers;
                  temp : sgf_arbre.arbre;
         begin
                  v.nom := nom;  -- on stocke le nom du fichier que l'on veut modifier
                  temp := Rechercher(Abr     => Abr_total, 
                                     element => v);  -- on recherche l'arbre dont la racine contient le nom du fichier 
                  v := valeur_racine(Abr => temp);  -- on cherche la valeur enregistrée dans la racine de l'arbre retourné
                  if v.isdossier = false then  -- si c'est un dossier -> exception 
                           return v.taille + Taille;  -- on retourne la taille initiale du fichier qu'on incrémente de la valeur souhaitée         
                  else
                           raise est_dossier;
                  end if;
         end taille_fichier;
         
         
         procedure affichage_modif_droits (nom : in Unbounded_String ; Abr_total : in sgf_arbre.arbre) is 
                  temp : sgf_arbre.arbre;
                  v : dossiers_fichiers;
                  new_droits : Unbounded_String;
                  modif : String(1..10);
                  longueur_modif : Integer;
         begin
                  v.nom := nom;  -- on stocke le nom du dossier ou du fichier pour lequel on veut afficher les droits
                  temp := Rechercher(Abr     => Abr_total,
                                     element => v);  -- on recherche l'arbre dont la racine contient le nom du dossier ou fichier 
                  if arbre_est_vide(Abr => temp) then  -- si l'arbre retourné est vide -> exception
                           raise dossier_fichier_manquant;
                  else 
                           v := valeur_racine(Abr => temp);  -- sinon on retourne l'element enregistré dans le racine de cette arbre
                           Put(To_String(v.droits) & Integer'Image(v.taille) & " user " & To_String(v.nom));  -- on affiche les droits 
                  end if;
                  New_Line;
                  Put_Line(" Do you want to modify it ? y/n ");
                  Get_Line(modif,longueur_modif);
                  if modif(1..1) = "y" then 
                           if v.isdossier = true then   -- si l'utilisateur veut modifier les droits et que l'on a un dossier 
                                    Put_Line("Nouveau droit de la forme 'drwxrwxrwx' : ");
                                    new_droits := To_Unbounded_String(Get_Line);  -- on recupère les nouveaux droits 
                                    v.droits := new_droits;  -- et on les enregistre
                           elsif v.isdossier = false then 
                                    Put_Line("Nouveau droit de la forme '-rwxrwxrwx' : ");  -- si l'utilisateur veut modifier les droits et que l'on a un fichier
                                    new_droits := To_Unbounded_String(Get_Line);  -- on recupère les nouveaux droits 
                                    v.droits := new_droits;  -- et on les enregistre 
                           end if;
                  elsif modif(1..1) = "n" then  -- si l'utilisateur ne veut pas modifier alors rien 
                           null;
                  end if;
         end affichage_modif_droits;
         
         procedure copie_dossier_fichier (nom : in Unbounded_String ; destination : in Unbounded_String ; Abr_total : in sgf_arbre.arbre) is 
                  temp, temp1 : sgf_arbre.arbre;
                  dest : sgf_arbre.arbre;
                  a : dossiers_fichiers;
                  v : dossiers_fichiers;
         begin
                  a.nom := nom;  -- on stocke le nom du dossier ou du fichier à copier 
                  temp1 := Rechercher(Abr     => Abr_total,
                                      element => a);  -- on recherche l'arbre dont la racine contient le nom du dossier ou fichier à copier
                  if arbre_est_vide(Abr => temp1) then  -- si cette arbre est vide -> exception 
                           raise dossier_fichier_manquant;
                  else
                           v.nom := destination;  -- on stocke le nom du dossier de destination 
                           dest := Rechercher(Abr     => Abr_total,
                                              element => v);  -- on recherche l'arbre dont la racine contient le nom du dossier de destination 
                           if arbre_est_vide(Abr => dest) then  -- si cette arbre est vide -> exception 
                                    raise dossier_manquant;
                           else
                                    temp := inserer_element(a);  -- sinon on insère le nom dossier ou fichier à copier dans un nouveau noeud 
                                    temp1 := Rechercher(Abr     => Abr_total,
                                                        element => retour_fils_ainee(temp1));  -- on sauvegarde l'arbre fils (s'il en a un) du noeud que l'on veut copier coller
                                    inserer_fils(Abr         => temp,
                                                 Abr_inseree => temp1);  -- on insère dans le nouveau noeud et en tant que fils ainée l'arbre de sauvegarde des fils temp1
                                    inserer_fils(Abr         => dest,
                                                 Abr_inseree => temp);  -- ensuite on insère en tant que fils le noeud créée et ses potentiels fils dans le dossier de destination du copier coller 
                           end if;
                  end if;
         end copie_dossier_fichier;
        
         
         function isegaux (a : in dossiers_fichiers ; b : in dossiers_fichiers) return Boolean is
         begin
                  return a.nom = b.nom;  -- permet de comparer deux types abstraits (dossiers_fichiers) ici on compare juste les noms des deux records a et b
         end isegaux;  -- retourne true si a et b ont le même nom
  
         
end SGF;
