with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

package body liste_chaine is

         procedure creer_liste_vide (l : in out T_Liste) is
         begin
                  l:= new T_Cellule;
                  l := null;
         end creer_liste_vide;

         function est_vide (l : in T_Liste) return Boolean is
         begin
                  return l = null;
         end est_vide;

         procedure inserer_en_tete (l : in out T_Liste ; a : in T_Element) is
                  temp : T_Liste;
         begin
                  temp := l ;
                  l := new T_Cellule;
                  l.all.element := a;
                  l.all.suivant := temp;
         end inserer_en_tete;

         procedure afficher_liste (l : in T_Liste) is
         begin
                  if not est_vide(l) then
                           Put_Line("");
                           Put_Line("===========");
                           Put_Line("");
                           Afficher_gen(l.all.element);
                           afficher_liste(l.all.suivant);
                  end if;
         end afficher_liste;

         function rechercher (l : in T_Liste ; a : in T_Element) return T_Liste is
                  R_liste : T_Liste;
                  temp : T_Liste;
         begin
                  if est_vide(l) then
                           return null;
                  else
                           temp := l;
                           while temp /= null loop
                                    if temp.all.element = a then
                                             R_liste := temp;
                                             return R_liste;
                                    end if;
                                    temp := temp.all.suivant;
                           end loop;
                           return null;
                  end if;
         end rechercher;


         procedure inserer_apres (l : in T_Liste ; nouveau : in T_Element ; data : in T_Element) is
                  adresse_data : T_Liste;
         begin
                  if not est_vide(l) then
                           adresse_data := rechercher(l,data);
                           if adresse_data = null then
                                    raise data_not_found;
                           else
                                    adresse_data.all.suivant := new T_Cellule'(nouveau, adresse_data.all.suivant);
                           end if;
                  else
                           raise liste_vide;
                  end if;
         end inserer_apres;


         procedure inserer_avant (l : in out T_Liste ; nouveau : in T_Element ; data : in T_Element) is
                  addresse_data : T_Liste;
                  temp: T_Liste;

         begin
                  temp := l;
                  if est_vide(l) then
                           raise liste_vide;
                  elsif l.all.element = data then
                           inserer_en_tete(l, nouveau);
                  else
                           while temp /= null and temp.all.element /= data loop
                                    addresse_data := temp;
                                    temp := temp.all.suivant;
                           end loop;
                           if temp = null then
                                    raise data_not_found;
                           else
                                    addresse_data.all.suivant := new T_Cellule'(nouveau, temp);
                           end if;
                  end if;
         end inserer_avant;




         procedure enlever (l : in out T_Liste ; e : in T_Element) is

                  addresse_data : T_Liste;
                  temp_list : T_Liste;
                  temp : T_Element;

         begin
                  if not est_vide(l) then
                           addresse_data := rechercher(l,e);

                           if addresse_data = null then
                                    raise data_not_found;
                           else
                                    temp_list := l;
                                    while temp_list.all.suivant /= addresse_data loop
                                             temp := temp_list.all.element;
                                             temp_list := temp_list.all.suivant;
                                    end loop;
                                    temp_list.all.suivant := addresse_data.all.suivant;
                           end if;
                  else
                           raise liste_vide;
                  end if;
         end enlever;


end liste_chaine;
