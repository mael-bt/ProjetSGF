-- Arbre de recherche generique --

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Unchecked_Deallocation;

package body arbre is

         procedure free is new Ada.Unchecked_Deallocation (Object => noeud , Name => arbre);

         procedure initialiser (Abr : out arbre) is
         begin
                  Abr := null;  -- initialise un arbre a nul
         end initialiser;

         function arbre_est_vide (Abr : in arbre) return Boolean is
                  B : Boolean := False;
         begin
                  if Abr = null then  -- si l'arbre est nul
                           B := true;  -- on retourne B a true
                  else
                           null;  -- si l'arbre est non nul on ne fait rien
                  end if;
                  return B;
         end arbre_est_vide;

         function valeur_racine (Abr : in arbre) return T_Element_arbre is
                  T : T_Element_arbre;
         begin
                  if arbre_est_vide(Abr => Abr) then  -- si l'arbre est vide -> exception
                           raise arbre_vide;
                  else
                           T := Abr.all.element;  -- sinon on retourne la valeur contenue dans le noeud racine de l'arbre donne
                  end if;
                  return T;
         end valeur_racine;

         function arbre_sans_fils (Abr : in arbre) return Boolean is
                  B : Boolean := False;
         begin
                  if arbre_est_vide(Abr => Abr) then  -- si l'arbre est vide -> exception
                           raise arbre_vide;
                  else
                           if Abr.all.fils_ainee = null then  -- si le noeud racine de l'arbre donnee n'a pas de pointeur vers un fils on retourne true
                                    B := true;
                           else
                                    null;  -- sinon rien
                           end if;
                  end if;
                  return B;
         end arbre_sans_fils;

         function Rechercher (Abr : in arbre ; element : in T_Element_arbre) return arbre is
                  p : arbre;
         begin
                  p := new noeud;     -- on créer un noeud qui permettra de retourner l'arbre genere par la recherche
                  if arbre_est_vide(Abr => Abr) or else isEqual(Abr.all.element,element) then     -- on retourne arbre donnee si celui ci est nul ou si on a trouvé la valeur
                           return Abr;
                  else
                           p := Rechercher (Abr.all.frere, element);  -- le nouveau noeud devient l'arbre sorti par la recherche du frere
                           if not arbre_est_vide(p) then
                                    return p;              -- si cette arbre n'est pas vide on le retourne sinon on continue à chercher avec le fils ainee
                           else
                                    return Rechercher (Abr.all.fils_ainee, element);
                           end if;
                  end if;
         end Rechercher;

         function est_racine (Abr : in arbre) return Boolean is
                  B : Boolean := False;
         begin
                  if Abr.all.pere = null then  -- si le noeud racine de l'arbre donnee a un pointeur vers le pere a nul alors on retourne true
                           B := true;
                  else
                           null;  -- sinon rien
                  end if;
                  return B;
         end est_racine;

         procedure Modifier (Abr : in out arbre ; nouvelle_donnee : in T_Element_arbre) is
         begin
                  if arbre_est_vide(Abr => Abr) then  -- si l'arbre est vide -> exception
                           raise arbre_vide;
                  else
                           Abr.all.element := nouvelle_donnee;  -- sinon la valeur contenue dans le noeud racine de cette arbre est modifiee par la donnee utilisateur
                  end if;
         end Modifier;

         procedure afficher (Abr : in arbre ; niv : in Integer) is
                  temp : arbre;
         begin
                  if Abr /= null then  -- si l'arbre est nul -> rien
                           if niv = 0 then  -- si le niv donnee est 0 (le niv 0 permet la premiere fois d'afficher la racine avec une indentation nulle)
                                    afficher_generique(Abr.all.element);  -- on affiche l'element
                           elsif niv = 3 then  -- si le niv est de 3 on met une indentation et on affiche l'element cela permet d'obtenir une arborescence
                                    Put("|----");
                                    afficher_generique(Abr.all.element);
                           else
                                    for i in 3..niv loop  -- on met des espaces en fonction du niv dans l'arborescence
                                             Put(" ");
                                    end loop;
                                    Put("|----");  -- on indente
                                    afficher_generique(Abr.all.element);  -- et on affiche l'element
                           end if;
                           new_line;
                           temp := Abr.all.fils_ainee;  -- après avoir affiche la racine
                           while temp /= null loop
                                    afficher (temp, niv + 3);  -- on affiche le fils ainee en appelant recursivement afficher avec niv 3 ce qui permet de passer dans la deuxième règle
                                    temp := temp.all.frere;  -- puis on affiche les freres
                           end loop;
                  else
                           null;
                  end if;

         end afficher;

         procedure inserer_fils (Abr : in out arbre ; Abr_inseree : in out arbre) is
         begin
                  if arbre_est_vide(Abr => Abr) then      -- si l'arbre dans lequel on veut la branche est vide -> exception
                           raise arbre_vide;
                  elsif arbre_est_vide(Abr => Abr_inseree) then     -- si l'arbre que l'on va inserer est vide -> exception
                           raise arbre_a_inser_vide;
                  elsif arbre_est_vide(Abr => Abr.all.fils_ainee) then   -- si l'arbre dans lequel on veut inserer n'a pas de fils
                           Abr.all.fils_ainee := Abr_inseree;   -- le pointeur fils ainee pointe sur l'arbre a inserer
                           Abr_inseree.all.pere := Abr;        -- et le pointeur pere de l'arbre inserer pointe lui sur l'arbre dans lequel on a inserer
                  else
                           Abr_inseree.all.frere := Abr.all.fils_ainee;   -- sinon l'arbre inserer devient le fils ainee de l'arbre global et
                           Abr_inseree.all.pere := Abr;                   -- l'ancien fils ainee devient son premier frere
                           Abr.all.fils_ainee := Abr_inseree;
                  end if;
         end inserer_fils;

         procedure supprimer (Abr : in out arbre ; donnee : in T_Element_arbre) is
                  temp : arbre;
         begin
                  if not arbre_est_vide(Abr => Abr) then  -- si l'arbre est nul -> exception
                           if isEqual(Abr.all.element,donnee) then  -- si la valeur a supprimer est egale à la valeure enregistree
                                    if arbre_est_vide(Abr => Abr.all.frere) then  -- et si l'arbre n'a pas de frere
                                             free(Abr);  -- on peut liberer avec la fonction free le noeud
                                    else
                                             temp := Abr.all.frere;  -- si l'arbre a des freres la variable temp pointe vers les freres
                                             free(Abr);  -- on peut donc liberer le noeud et ses potentiels fils
                                             Abr := temp;  -- on remet en place les freres
                                    end if;
                           else
                                    if not arbre_est_vide(Abr => Abr.all.frere) then  -- si la donnee n'est pas trouve
                                             supprimer (Abr.all.frere, donnee);  -- on rappelle la fonction en testant le premier frere et ainsi de suite par recursivité
                                    end if;
                                    supprimer (Abr.all.fils_ainee, donnee);  -- si la recherche dans les freres ne donne rien on cherche dans les fils
                           end if;
                  end if;
         end supprimer;

         function inserer_element (donnee : in T_Element_arbre) return arbre is
                  Abr : arbre;
         begin
                  Abr := new noeud;  -- on créer un nouvel enregistrement
                  Abr.all.element := donnee;  -- l'element generique prend la valeur donnee
                  Abr.all.frere := null;  -- on initialise le pointeur sur le frere a nul
                  Abr.all.pere := null;  -- pareil pour le pere
                  Abr.all.fils_ainee := null;  -- et pour le fils ainee
                  return Abr;
         end inserer_element;

         function retourne_pere (Abr : in arbre) return T_Element_arbre is
                  result : T_Element_arbre;
         begin
                  if not arbre_est_vide(Abr) then  -- si l'arbre est vide -> exception
                           if arbre_est_vide(Abr => Abr.all.pere) then  -- si le pointeur pere est nul
                                    result := Abr.all.element;  -- alors on retourne la valeur generique enregistre dans le noeud
                           else
                                    result := Abr.all.pere.element;  -- sinon on retourne la valeur generique du pere de ce noeud
                           end if;
                  else
                           raise arbre_vide;
                  end if;
                  return result;
         end retourne_pere;

         procedure retourne_fils (Abr : in arbre)  is
                  temp : arbre;
         begin
                  if not arbre_est_vide(Abr) then  -- si l'arbre est vide -> exception
                           if not arbre_est_vide(Abr => Abr.all.fils_ainee) then  -- si l'arbre n'a pas de fils -> exception
                                    afficher_generique(Abr.all.fils_ainee.element); -- dans un premier on affiche la valeur du fils ainee
                                    temp := Abr.all.fils_ainee;-- on sauvegarde le pointeur sur le fils dans une variable temporaire
                                    temp := temp.all.frere; -- on passe au frere du noeud fils ainé
                                    while temp /= null loop  -- puis on boucle
                                             afficher_generique (temp.all.element);  -- dans un premier on affiche la valeur du premier frère
                                             temp := temp.all.frere;  -- puis on passe au frère suivant et ainsi de suite jusqu'à sortir de la boucle quand il n'y a plus de frères
                                    end loop;
                           else
                                    raise pas_de_fils;
                           end if;
                  else
                           raise arbre_vide;
                  end if;
         end retourne_fils;

         function retour_fils_ainee (Abr: in arbre) return T_Element_arbre is
         begin
                  if not arbre_est_vide(Abr => Abr) then  -- si l'arbre est nul -> exception
                           if arbre_est_vide(Abr => Abr.all.fils_ainee) then  -- si le pointeur du fils ainee est nul
                                    return Abr.all.element;  -- alors on retourne l'element enregistre dans le noeud
                           else
                                    return Abr.all.fils_ainee.element;  -- sinon on retourne l'element du fils ainee de ce noeud
                           end if;
                  else
                           raise arbre_vide;
                  end if;
         end retour_fils_ainee;

end arbre;


