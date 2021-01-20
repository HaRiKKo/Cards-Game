UNIT Upari;
Interface
Uses 
    gLib2D, SDL_TTF,SDL, UInter_J, UListe, Utype, crt;


VAR 
	nbdeJoueur, numdeManche ,i , jj : integer;
	J : tableau;
	P : tabplateau;
	point : Ptr_noeud;
	at : ATOUT;
	
	
Procedure Verife_pari(numdeManche , jj : integer; var P : tabplateau);		
Procedure Ordre_pari (at : ATOUT; J : tableau ; Ptr_add : Ptr_noeud; nbdeJoueur, numdeManche, i: integer; VAR P : tabplateau);


Implementation
USES sysutils;

(*---------------------------------------------------------------------------
-- PROCEDURE         : Verife_pari
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : vérifier les paris
-- Remarques         : la somme des parie egale a la somme des cartes dans la main + 1
-- Pré conditions    : avoir distribuer et afficher les cartes  
-- Post conditions   : remplie et retourne le tableau des plis
-----------------------------------------------------------------------------
*)

Procedure Verife_pari(numdeManche , jj : integer; var P : tabplateau);
VAR
	S, i, enchere : integer;
Begin
	
	S:=0;
	enchere:=numdeManche+1;
	for i:=1 to length(P) do
		begin
			S:=P[i]+S;
		end;
	writeln('la somme ',S);
	if S > enchere then
	begin
		
		Writeln('pari invalide : donnez un nombre entre 0 et ', enchere-(S-P[jj])); 
		read(P[jj]);
	end;

End;




(*---------------------------------------------------------------------------
-- PROCEDURE         : Ordre_pari
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : repète la fonction afficher jeu autant de fois qu'il y a de joueur 
-- Remarques         : cherche la tete de la liste et avance dans la liste  
-- Pré conditions    : avoir distribuer les cartes et creer la liste circulaire 
-- Post conditions   : retourne le tableau des paris
-----------------------------------------------------------------------------
*)

Procedure Ordre_pari (at : ATOUT; J : tableau ; Ptr_add : Ptr_noeud; nbdeJoueur, numdeManche, i: integer; VAR P : tabplateau);
Var
	tete , point : Ptr_noeud;
	compt,n : integer;
	
Begin
	setlength(P,nbdeJoueur);
	
	for n:=1 to nbdeJoueur do P[n]:=0;
	tete:=Recherche(J,Ptr_add);
	point:=tete;
	compt:=1;
	repeat
		
		writeln('le joueur ',i,' pari !');
		affichejeu(point^.valeur);
		P[i]:=afficher_jeu (at, point^.valeur,numdeManche);
		Verife_pari(numdeManche, i, P);
		if i+1 > nbdejoueur then i:=1
		else i:=i+1;
		point:=point^.suivant;
		compt:=compt+1;
		ClrScr;
		
	until compt > nbdeJoueur-1;
	P[i]:=Pari_dernier( point, numdeManche, i, P );

End; 

   
END.
