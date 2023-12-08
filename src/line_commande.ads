-- Affichage en ligne de commande -- 

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with SGF; use SGF;

package line_commande is
         
         
         -- Nom : terminal
         -- Sémantique : Cette procedure permet d'utiliser le sgf en ligne de commande en appelant la procedure commande_line
         -- Paramètres : /
         -- Résultat : /
         -- Pré : /
         -- Post : /
         -- Exception : /
         
         procedure terminal;
         
         -- Nom : commande_line
         -- Sémantique : Cette procedure permet d'utiliser le sgf en faisant appel au differentes fonctions et procedures
         -- Paramètres : /
         -- Résultat : /
         -- Pré : /
         -- Post : /
         -- Exception : /
         
         procedure commande_line (commande : in string ; longueur_commande : Integer);

   

end line_commande;
