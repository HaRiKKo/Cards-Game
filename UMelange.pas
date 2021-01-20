UNIT UMelange;
Interface
USES crt, Utype;

			
			


VAR
	tabcarte1 : tableau2d;
	outil : carte;
	nbdeJoueur : integer;

PROCEDURE Melange_des_cartes1 ( var  tabcarte1:tableau2d );
PROCEDURE Melange_des_cartes2 ( var  tabcarte1:tableau2d );
FUNCTION nb_de_joueurs_calc_Manches(nbdeJoeur : integer): integer ;
FUNCTION Dist_Joueur (joueur, manche, nbdeJoueur, d , f : integer; tabcarte2 : tableau) : tableau;


Implementation
Uses sysutils;

(*
-----------------------------------------------------------------------------
-- PROCEDURE         : Melange_des_cartes1
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 25/05/2019
--
-- But               : 1er melange des cartes
-- Remarques         :
-- Pré conditions    : Aucune
-- Post conditions   : utiliser
-----------------------------------------------------------------------------
*)

PROCEDURE Melange_des_cartes1 (var  tabcarte1:tableau2d);
var
i,j,a,b: integer;
begin
randomize;
for i:=1 to 4 do
   for j:=1 to 13 do
        if (tabcarte1[i,j].utilisation = true ) then
          begin
           a:=1;
           b:=1;
           a:= random(4)+1;
           b:=  random(13)+1;
           if (tabcarte1[a,b].utilisation = true) then
            begin
            outil:=tabcarte1[a,b];
            tabcarte1[a,b]:=tabcarte1[i,j];
            tabcarte1[a,b].utilisation := false;
            tabcarte1[i,j]:= outil;
            tabcarte1[i,j].utilisation := false;
            end;
          end;
end;


(*---------------------------------------------------------------------------
-- PROCEDURE         : Melange_des_cartes2
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 25/05/2019
--
-- But               : 2nd melanges des cartes
-- Remarques         :
-- Pré conditions    : Aucune
-- Post conditions   : Aucune
-----------------------------------------------------------------------------
*)

PROCEDURE Melange_des_cartes2 ( var  tabcarte1:tableau2d);
var i,j,x,y: integer;
begin
randomize;
for i:=1 to 4 do
   for j:=1 to 13 do
   begin
   if (tabcarte1[i,j].utilisation = true ) then
   begin
    for x:=1 to 4 do
      for y:=1 to 13 do
      if (tabcarte1[x,y].utilisation = true )then
        begin
         outil:=tabcarte1[i,j];
         tabcarte1[i,j]:=tabcarte1[x,y];
         tabcarte1[i,j].utilisation := false;
         tabcarte1[x,y]:=outil;
         tabcarte1[x,y].utilisation:= false;
        end;
      end;
   end;
end;


(*---------------------------------------------------------------------------
-- FUNCTION          : nb_de_joueurs_calc_Manches
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 25/05/2019
--
-- But               : avoir le nombre de joueur et de manche par phase par la meme occasion.
-- Remarques         :
-- Pré conditions    : connaitre le nombre de joueur
-- Post conditions   : Aucune
-----------------------------------------------------------------------------
*)

FUNCTION nb_de_joueurs_calc_Manches(nbdeJoeur : integer): integer ;
var
 manche, m: integer;

begin
	
 if(nbdeJoeur=2)or(nbdeJoeur=3)or(nbdeJoeur=4)or(nbdeJoeur=5) then
   begin
	if (52mod(nbdeJoeur)=0) then
	  begin
	  manche:= (52 div nbdeJoeur);
	  end
	else
	  begin
	  m:=52 mod(nbdeJoeur);
	  manche:=(52-m) div nbdeJoeur;

	  end;
	  end
 else
  writeln('erreur, le nombre de joueurs ne peut être que 2,3,4,ou bien 5');

	//writeln(manche);
  nb_de_joueurs_calc_Manches:=manche;
end;


(*---------------------------------------------------------------------------
-- FUNCTION          : Dist_Joueur
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : distribue les cartes a chaque joueur 
-- Remarques         : vas distribuer de la 'd' ème care a la 'f' ème carte du tableau 1D
-- Pré conditions    : avoir melanger les cartes / remplie le tableau 1D / connaitre le nombre de joueur pour conaitre les variable d et f
-- Post conditions   : retourne le jeu des joueur
-----------------------------------------------------------------------------
*)

Function Dist_Joueur (joueur, manche, nbdeJoueur, d , f : integer; tabcarte2 : tableau) : tableau;
Var
	i, n : integer;
	J : tableau;
Begin
	Setlength(J,manche+1);
	n:=1;
	for i:=d to f do
	begin
		J[n]:=tabcarte2[i];
		n:=n+1;
	end;
	writeln('le joueur numero ',joueur);
	Dist_Joueur:=J;
end;



END.
