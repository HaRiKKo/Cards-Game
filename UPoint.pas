UNIT UPoint;
Interface

USES Utype;

VAR 
	c , nbdeJoueur : integer;

Procedure PremiereCarteAtout (nbdeJoueur : integer; tabC : tableau ; at : ATOUT ; VAR je : integer; VAR carte_atout : carte);
procedure remplie_Preal (tabC : tableau; at : ATOUT; carte_gagnant : Carte; VAR je : integer ; VAR Preal : tabplateau);
Procedure PremiereCarte (tabC : tableau; at : ATOUT; VAR nbdeJoueur, je : integer ; VAR  carte_gagnant : Carte);
Procedure Calcule_Point (P, Preal : tabplateau; Var TabPoint : tabplateau);


Implementation
USES sysutils;

(*---------------------------------------------------------------------------
-- PROCEDURE         : PremiereCarteAtout
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : connaitre la première carte en fonction de l'atout
-- Remarques         : sera activer uniquementy si il y a un l'atout 
-- Pré conditions    : avoir distribuer les cartes / creer la liste circulaire / avoir fait un tour de table et recuperer les cartes / avoir un atout
-- Post conditions   : retourne la premiere carte 
-----------------------------------------------------------------------------
*)

Procedure PremiereCarteAtout (nbdeJoueur : integer; tabC : tableau ; at : ATOUT ; VAR je : integer; VAR carte_atout : carte);
VAR
	n : integer;
	
Begin

	carte_atout.couleur:=at.couleur;
	carte_atout.nombre:=0;
	for n := 1 to nbdeJoueur do
	begin
		if ( tabC[n].couleur = carte_atout.couleur) and (tabC[n].nombre > carte_atout.nombre) then 
			begin
				carte_atout:=tabC[n];
				je:=n;
				
			end;
	end;
	
End;

(*---------------------------------------------------------------------------
-- PROCEDURE         : PremiereCarte
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : remplie le tableau des plis realiser par les joueurs
-- Remarques         :   
-- Pré conditions    : avoir distribuer les cartes / creer la liste circulaire / avoir fait un tour de table et recuperer les cartes  
-- Post conditions   : retourne le tableau des plis et la position du joueur qui débute 
-----------------------------------------------------------------------------
*)

procedure remplie_Preal (tabC : tableau; at : ATOUT; carte_gagnant : Carte; VAR je : integer ; VAR Preal : tabplateau);
VAR
	c : integer;
Begin
	Preal[je]:=Preal[je]+1;
	writeln('########## les joueurs ',je,' gagne le tour. ##########'); 
	repeat 
		writeln('tapez 1 pour continuer');
		read(c);
	until ( c = 1 );

	
End;

(*---------------------------------------------------------------------------
-- PROCEDURE         : PremiereCarte
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : connaitre la première carte  
-- Remarques         :   
-- Pré conditions    : avoir distribuer les cartes / creer la liste circulaire / avoir fait un tour de table et recuperer les cartes  
-- Post conditions   : retourne la premiere carte
-----------------------------------------------------------------------------
*)

Procedure PremiereCarte (tabC : tableau; at : ATOUT; VAR nbdeJoueur, je : integer ; VAR  carte_gagnant : Carte);
Var 
	n : integer;
	carte_atout : Carte;
	
Begin
		
	for n:=1 to nbdeJoueur do
	begin
			if ( tabC[n].couleur = carte_gagnant.couleur) and (tabC[n].nombre > carte_gagnant.nombre) and ( tabC[n].utilisation <> False ) then 
			begin
				carte_gagnant:=tabC[n];
				je:=n;
			end;
	end;
	if at.active = TRUE then
	begin
		carte_atout.couleur := at.couleur;
		carte_atout.nombre := 0;
		PremiereCarteAtout (nbdeJoueur, tabC, at, je, carte_atout );
		if carte_atout.nombre > 0 then 
		begin
			carte_gagnant:=carte_atout;
		end; 
	end;
	
End;

(*---------------------------------------------------------------------------
-- PROCEDURE         : Calcule_Point
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : calcule les points et retourne le tableau des points 
-- Remarques         : 10 point pour celui qui fait sont parie +2* le nombre de plie qu'il devait faire  
-- Pré conditions    : avoir fait ses pari et jouer 
-- Post conditions   : retourne le tableau des points
-----------------------------------------------------------------------------
*)

Procedure Calcule_Point (P, Preal : tabplateau; Var TabPoint : tabplateau);
Var i : integer; 

Begin

	for i:=1 to length(P) do
	begin
		if P[i]=Preal[i] then TabPoint[i]:=TabPoint[i]+10+2*P[i];
		if P[i]>Preal[i] then TabPoint[i]:=TabPoint[i]-(P[i]-Preal[i])*2;
		if P[i]<Preal[i] then TabPoint[i]:=TabPoint[i]-(Preal[i]-P[i])*2;
		writeln('le score du joueur ',i,' est de ',TabPoint[i]);
	end;
	
end;

END.
