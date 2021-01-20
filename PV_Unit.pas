PROGRAM PV;
USES gLib2D, SDL_TTF,SDL, UInter_J, Upari, UListe, UMelange, UPlateau, Utype, UPoint, crt;
//crt
 



VAR
	//LES TABLEAUX
    tabcouleur : array[1..4] of string = ('coeur','pique','trefle','carreaux');
    tabnombre  : array[1..13] of integer = (2,3,4,5,6,7,8,9,10,11,12,13,14);
    tabcarte   : tableau2d ;//array[1..4,1..13] of carte ;
    tabcarte2  : tableau ; 
    
    J1,J2,J3,J4,J5, tabC : tableau; //jeu des joueurs et carte poser sur le plateau
	P, Preal, TabPoint : tabplateau; //tableau des parie, des plis realiser et des points
	
	//LES CARTES
    carte_gagnant : carte;
    
    //LES ENTIER
    nbdeJoueur, nbdeJoueur_H, nbdeJoueur_B, numdeManche, M, MancheTT, i, je, c, V : integer;
    
    //LES LISTE
    Ptr_add : Ptr_noeud;
    
	//L'ATOUR
	at : ATOUT;
	

//Fathima	

(*
-----------------------------------------------------------------------------
-- PROCEDURE         : Remplisage_du_tabl_ranger
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 24/05/2019
--
-- But               : crée le tableau de cartes array 2D avec 3/(4) parametres
-- Remarques         : Aucune
-- Post conditions   : 
-----------------------------------------------------------------------------
*)

PROCEDURE Remplisage_du_tabl_ranger ( var  tabcarte1 : tableau2d);
var
i,j : integer;    
Begin
for i:= 1 to 4 do
  begin
   for j:= 1 to 13 do
   begin
      tabcarte1[i,j].couleur:= tabcouleur[i] ;
      tabcarte1[i,j].nombre:= tabnombre[j];
      tabcarte1[i,j].utilisation := true;
   end;
   end;
 //ecrire(tabcarte1);  
End;

(*
-----------------------------------------------------------------------------
-- PROCEDURE         : Remplisage_img
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 24/05/2019
--
-- But               : associe chaque img à une carte 
-- Remarques         : Aucune
-- Post conditions   : retourne le tableau remplie 
-----------------------------------------------------------------------------
*)

Procedure Remplir_img( var tabcarte1 : tableau2d);

Begin
	tabcarte1[1,1].img:= '02-coeur.png';  tabcarte1[2,1].img:= '02-pique.png' ;  tabcarte1[3,1].img:='02-trefle.png';  tabcarte1[4,1].img:= '02-carreau.png';
	tabcarte1[1,2].img:= '03-coeur.png';  tabcarte1[2,2].img:= '03-pique.png' ;  tabcarte1[3,2].img:='03-trefle.png';  tabcarte1[4,2].img:= '03-carreau.png';
	tabcarte1[1,3].img:= '04-coeur.png';  tabcarte1[2,3].img:= '04-pique.png' ;  tabcarte1[3,3].img:='04-trefle.png';  tabcarte1[4,3].img:= '04-carreau.png';
	tabcarte1[1,4].img:= '05-coeur.png';  tabcarte1[2,4].img:= '05-pique.png' ;  tabcarte1[3,4].img:='05-trefle.png';  tabcarte1[4,4].img:= '05-carreau.png';
	tabcarte1[1,5].img:= '06-coeur.png';  tabcarte1[2,5].img:= '06-pique.png' ;  tabcarte1[3,5].img:='06-trefle.png';  tabcarte1[4,5].img:= '06-carreau.png';
	tabcarte1[1,6].img:= '07-coeur.png';  tabcarte1[2,6].img:= '07-pique.png' ;  tabcarte1[3,6].img:='07-trefle.png';  tabcarte1[4,6].img:= '07-carreau.png';
	tabcarte1[1,7].img:= '08-coeur.png';  tabcarte1[2,7].img:= '08-pique.png' ;  tabcarte1[3,7].img:='08-trefle.png';  tabcarte1[4,7].img:= '08-carreau.png';
	tabcarte1[1,8].img:= '09-coeur.png';  tabcarte1[2,8].img:= '09-pique.png' ;  tabcarte1[3,8].img:='09-trefle.png';  tabcarte1[4,8].img:= '09-carreau.png';
	tabcarte1[1,9].img:= '10-coeur.png';  tabcarte1[2,9].img:= '10-pique.png' ;  tabcarte1[3,9].img:='10-trefle.png';  tabcarte1[4,9].img:= '10-carreau.png';
	tabcarte1[1,10].img:= 'V-coeur.png';  tabcarte1[2,10].img:= 'V-pique.png' ;  tabcarte1[3,10].img:='V-trefle.png';  tabcarte1[4,10].img:= 'D-carreau.png';
	tabcarte1[1,11].img:= 'D-coeur.png';  tabcarte1[2,11].img:= 'D-pique.png' ;  tabcarte1[3,11].img:='D-trefle.png';  tabcarte1[4,11].img:= 'V-carreau.png';
	tabcarte1[1,12].img:= 'R-coeur.png';  tabcarte1[2,12].img:= 'R-pique.png' ;  tabcarte1[3,12].img:='R-trefle.png';  tabcarte1[4,12].img:= 'R-carreau.png';
	tabcarte1[1,13].img:= '01-coeur.png';  tabcarte1[2,13].img:= '01-pique.png' ;  tabcarte1[3,13].img:='01-trefle.png';  tabcarte1[4,13].img:= '01-carreau.png';

End;

(*---------------------------------------------------------------------------
-- PROCEDURE         : Melengement
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 25/05/2019
--
-- But               : les 2 procedure de melangement en un
-- Remarques         :
-- Pré conditions    : Aucune
-- Post conditions   : Aucune
-----------------------------------------------------------------------------
*)

PROCEDURE Melengement;
begin
Remplisage_du_tabl_ranger(tabcarte);
Remplir_img(tabcarte);
Melange_des_cartes1(tabcarte);
Melange_des_cartes2 (tabcarte);
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

(*---------------------------------------------------------------------------
-- PROCEDURE          : Distribution
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : savoir combien de carte il faux distribuer en fonction du nombre de joueur et de la manche  
-- Remarques         : 
-- Pré conditions    : savoir le nombre de joueur / voir melanger les cartes / remplie le tableau 1D / connaitre le nombre de joueur pour conaitre les variable d et f 
-- Post conditions   : appelle la fonction Dist_Joueur
-----------------------------------------------------------------------------
*)
 
Procedure Distribution ( nbdeJoueur, manche : integer; tabcarte2: tableau; VAR J1,J2,J3,J4,J5 : tableau ;VAR at : ATOUT);

Begin
	
	J1 := Dist_Joueur (1, manche, nbdeJoueur , 1 , manche, tabcarte2 );
	Case nbdeJoueur of
		2 : begin
			J2 := Dist_Joueur (2, manche, nbdeJoueur , manche+1, 2*manche , tabcarte2);
			if at.active = TRUE then
				begin
					at.couleur:=tabcarte2[2*manche+1].couleur;
					writeln('la couleur de l`atout est ',at.couleur); 
				end;
			end;
		3 : begin
			J2 := Dist_Joueur (2, manche, nbdeJoueur , manche+1, 2*manche , tabcarte2);
			J3 := Dist_Joueur (3, manche, nbdeJoueur , 2*manche+1, 3*manche, tabcarte2);
			if at.active = TRUE then
			begin
					at.couleur:=tabcarte2[3*manche+1].couleur;
					writeln('la couleur de l`atout est ',at.couleur); 
			end;
		end;
		4 : begin
			J2 := Dist_Joueur (2, manche, nbdeJoueur , manche+1, 2*manche, tabcarte2);
			J3 := Dist_Joueur (3, manche, nbdeJoueur , 2*manche+1, 3*manche, tabcarte2);
			J4 := Dist_Joueur (4, manche, nbdeJoueur , 3*manche+1, 4*manche, tabcarte2);
			if at.active = TRUE then
			begin
					at.couleur:=tabcarte2[4*manche+1].couleur;
					writeln('la couleur de l`atout est ',at.couleur); 
			end;
		end;
		5 : begin
			J2 := Dist_Joueur (2, manche, nbdeJoueur , manche+1, 2*manche, tabcarte2 );
			J3 := Dist_Joueur (3, manche, nbdeJoueur , 2*manche+1, 3*manche, tabcarte2 );
			J4 := Dist_Joueur (4, manche, nbdeJoueur , 3*manche+1, 4*manche ,tabcarte2);
			J5 := Dist_Joueur (5, manche, nbdeJoueur , 4*manche+1, 5*manche ,tabcarte2);
			if at.active = TRUE then
			begin
					at.couleur:=tabcarte2[5*manche+1].couleur;
					writeln('la couleur de l`atout est ',at.couleur); 
			end;
		end;
	else writeln('erreur');
	end;
end;



(*---------------------------------------------------------------------------
-- PROCEDURE         : Debut_pari
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : savoir qui débute les paris en fonction du nombre de joueur et de la manche
-- Remarques         : chaque joueur est associer a un numéraux : Joueur 1 => num 1/ ... Joeur 5 => num 5 
-- Pré conditions    : avoir distribuer les cartes et creer la liste circulaire / connaitre le nombre de joueur / manche
-- Post conditions   : retourne le tableau des paris et le numéraux du joeur qui debute (je)
-----------------------------------------------------------------------------
*)

Procedure Debut_pari (M, J : integer; J1,J2,J3,J4,J5 : tableau; var P : tabplateau; VAR je : integer);	
	
Begin

	case J of
		2 : Begin
				case ( M mod J ) of 
					0 : begin Ordre_pari(at, J2 , Ptr_add, nbdeJoueur, numdeManche, 2 , P ); je := 2; end;
					1 : begin Ordre_pari(at, J1 , Ptr_add, nbdeJoueur, numdeManche, 1 , P ); je := 1; end;
				end;
			end;
		3 : Begin
				case ( M mod J ) of 
					0 : begin Ordre_pari(at, J3 , Ptr_add, nbdeJoueur, numdeManche, 3 , P ); je := 3; end;
					1 : begin Ordre_pari(at, J1 , Ptr_add, nbdeJoueur, numdeManche, 1 , P ); je := 1; end;
					2 : begin Ordre_pari(at, J2 , Ptr_add, nbdeJoueur, numdeManche, 2 , P ); je := 2; end;
				end;
			End;
		4 : Begin
				case ( M mod J ) of 
					0 : begin Ordre_pari(at, J4 , Ptr_add, nbdeJoueur, numdeManche, 4 , P ); je := 4; end;
					1 : begin Ordre_pari(at, J1 , Ptr_add, nbdeJoueur, numdeManche, 1 , P ); je := 1; end;
					2 : begin Ordre_pari(at, J2 , Ptr_add, nbdeJoueur, numdeManche, 2 , P ); je := 2; end;
					3 : begin Ordre_pari(at, J3 , Ptr_add, nbdeJoueur, numdeManche, 3 , P ); je := 3; end;
				end;
			End;
		5 : Begin
				case ( M mod J ) of 
					0 : begin Ordre_pari(at, J5 , Ptr_add, nbdeJoueur, numdeManche, 5 , P ); je := 5; end;
					1 : begin Ordre_pari(at, J1 , Ptr_add, nbdeJoueur, numdeManche, 1 , P ); je := 1; end;
					2 : begin Ordre_pari(at, J2 , Ptr_add, nbdeJoueur, numdeManche, 2 , P ); je := 2; end;
					3 : begin Ordre_pari(at, J3 , Ptr_add, nbdeJoueur, numdeManche, 3 , P ); je := 3; end;
					4 : begin Ordre_pari(at, J4 , Ptr_add, nbdeJoueur, numdeManche, 4 , P ); je := 4; end;
				end;
			End;
	end
End;




(*---------------------------------------------------------------------------
-- PROCEDURE         : Ordre_tour
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : repète la procedure jouer autant de fois qu'il y a de joueur 
-- Remarques         : cherche la tete de la liste et avance dans la liste  
-- Pré conditions    : avoir distribuer les cartes / creer la liste circulaire et avoir emplie le tableau des paris
-- Post conditions   : retourne le tableau des cartes jouer
-----------------------------------------------------------------------------
*)

Procedure Ordre_tour (J : tableau ; Ptr_add : Ptr_noeud; je, nbdeJoueur : integer ; VAR tabC : tableau);
Var
	compt : integer;
	tete,point : Ptr_noeud;
Begin

	Setlength(tabC, nbdejoueur);
	compt:=1;
	tete:=Recherche(J,Ptr_add);
	point:=tete;
	repeat
		
		jouer(point^.valeur,je, nbdeJoueur, numdeManche,tabC);
		point:=point^.suivant;
		if je+1 > nbdejoueur then je:=1
		else je:=je+1;
		compt:=compt+1;
		ClrScr;
	Until compt > nbdeJoueur ; 
	
		
End;

(*---------------------------------------------------------------------------
-- PROCEDURE         : association
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : lance la procedure Ordre_tour avec les valeurs d'entre qui varie en fonction du numéraux du joueur qui debute   
-- Remarques         : chaque joueur est associer a un numéraux : Joueur 1 => num 1/ ... Joeur 5 => num 5
-- Pré conditions    : avoir distribuer les cartes / creer la liste circulaire / avoir remplie le tableau des paris / connaitre le nombre de joueur
-- Post conditions   : lance la procedure Ordre_tour
-----------------------------------------------------------------------------
*)

Procedure association (je, nbdeJoueur, numdeManche : integer;  J1,J2,J3,J4,J5 : tableau; Ptr_add : Ptr_noeud; VAR tabC : tableau);

Begin

	case je of
		1 : Ordre_tour(J1, Ptr_add, je, nbdejoueur, tabC );
		2 : Ordre_tour(J2, Ptr_add, je, nbdejoueur, tabC );
		3 : Ordre_tour(J3, Ptr_add, je, nbdejoueur, tabC );
		4 : Ordre_tour(J4, Ptr_add, je, nbdejoueur, tabC );
		5 : Ordre_tour(J5, Ptr_add, je, nbdejoueur, tabC );
	end;
	
End;

//////////////////////////////// Intelligence Artificielle \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

(*---------------------------------------------------------------------------
-- FONCTION          : Savoir_quel_joueur
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 12/06/2019
--
-- But               : ????
-- Remarques         : ????
-- Pré conditions    : ????
-- Post conditions   : ????
-----------------------------------------------------------------------------
*)

FUNCTION Savoir_quel_joueur (var TabC : tableau): integer;
var
	a,i : integer;
Begin
	a:=0;
	for i:=1 to (nbdeJoueur) do
		if TabC[i].nombre<>0 then
		begin
			a:=a+1;
		end;
	Savoir_quel_joueur:=a;
End;

(*---------------------------------------------------------------------------
-- PROCEDURE         : calc_combien_perdre_combien_gagner
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 12/06/2019
--
-- But               : ????
-- Remarques         : ????
-- Pré conditions    : ????
-- Post conditions   : ????
-----------------------------------------------------------------------------
*)

PROCEDURE  calc_combien_perdre_combien_gagner (a, manche : integer; VAR calc1,calc2 : integer)  ;
var
	nbpari,nbparifini: integer;
Begin
	nbpari := P[a];
	nbparifini := Preal[a];
	calc1 := (manche +1)- nbpari; // nombre de paris à perdre
	calc2 := nbpari - nbparifini; // nombre de paris à gagner*

End;

(*---------------------------------------------------------------------------
-- PROCEDURE         : Cartemax_de_TabC
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 12/06/2019
--
-- But               : ????
-- Remarques         : ????
-- Pré conditions    : ????
-- Post conditions   : ????
-----------------------------------------------------------------------------
*)

PROCEDURE Cartemax_de_TabC (tabC : tableau; at : ATOUT; VAR je : integer ; VAR Preal : tabplateau);
Var
	n : integer;
	carte_gagnant,carte_atout : Carte;
Begin
	(* pris de première carte *) // à verifier
	carte_gagnant.couleur:=tabC[je].couleur;
	carte_gagnant.nombre:=tabC[je].nombre;
	for n:=1 to nbdeJoueur do
	begin
		if ( tabC[n].couleur = carte_gagnant.couleur) and (tabC[n].nombre > carte_gagnant.nombre) then
		begin
			carte_gagnant:=tabC[n];
			je:=n;
			//writeln('Test je ',je);----------------------------------------------------
		end;
	end;
	if at.active = TRUE then
	begin
		carte_atout.couleur := at.couleur;
		carte_atout.nombre := 0;
		PremiereCarteAtout (nbdeJoueur, tabC, at, je, carte_atout );
		if carte_atout.nombre > 0 then
		begin
			carte_gagnant:=carte_atout;// qui correspond au signe
		end
	end;
end;

(*---------------------------------------------------------------------------
-- PROCEDURE         : calcule_pari_IA_atout 
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 12/06/2019
--
-- But               : calcule combien de plis doit faire l'ia en fonction de ses atouts
-- Remarques         : seras active uniquement durant la phase assendente
-- Pré conditions    : avoir le jeu de l'IA
-- Post conditions   : retourne le tableau des paris
-----------------------------------------------------------------------------
*)

Procedure calcule_pari_IA_atout (J : tableau; numdeManche, je : integer; VAR P : tabplateau);
Var
	i, compt, S : integer;
Begin
	compt:=0;
	S:=0;
	
	for i:=1 to length(J) do
	begin
		if ( ( J[i].nombre >= 10 ) and ( J[i].couleur <> at.couleur ) ) or ( ( J[i].couleur = at.couleur ) and ( J[i].nombre >= 8 ) ) then compt:=compt+1;
	end;
		
	for i:=1 to length(P) do S:=S+P[i];
	//writeln('somme ',S);
	//writeln('compteur ',compt);
	if compt > (numdeManche+1) - S then P[je] := (numdeManche+1) - S
	else P[je] := compt;
		
end;

(*---------------------------------------------------------------------------
-- PROCEDURE         : calcule_pari_IA
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 12/06/2019
--
-- But               : calcule combien de plis doit faire l'IA 
-- Remarques         : AUCUN
-- Pré conditions    : avoir le jeu de l'IA
-- Post conditions   : retourne le tableau des paris
-----------------------------------------------------------------------------
*)


Procedure calcule_pari_IA (J : tableau; numdeManche, je : integer; VAR P : tabplateau);
Var
	i, compt, S : integer;
Begin
	compt:=0;
	S:=0;
	if at.active = True then calcule_pari_IA_atout (J , numdeManche, je , P )
	else
	begin
	
		for i:=1 to length(J) do
		begin
			if J[i].nombre >= 10 then compt:=compt+1;
		end;
		
		for i:=1 to length(P) do S:=S+P[i];
		//writeln('somme ',S);
		//writeln('compteur ',compt);
		if compt > (numdeManche+1) - S then P[je] := (numdeManche+1) - S
		else P[je] := compt;
		
	end;

End;

(*---------------------------------------------------------------------------
-- PROCEDURE         : calcule_pari_IA
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 12/06/2019
--
-- But               : calcule combien de plis doit faire la dernière IA 
-- Remarques         : AUCUN
-- Pré conditions    : avoir le jeu de l'IA
-- Post conditions   : retourne le tableau des paris
-----------------------------------------------------------------------------
*)

Function Pari_dernier_IA ( point : Ptr_noeud; numdeManche, j : integer; P : tabplateau ) : integer;
Var
	S, i , enchere: integer;

Begin
	S:=0;	
	enchere:=numdeManche+1;
	
	for i:=1 to length(P) do
		begin
			S:=P[i]+S;
		end;
		
	P[j]:=enchere-S;
	Pari_dernier_IA:=P[j];
End;

(*---------------------------------------------------------------------------      
-- PROCEDURE         : Ordre_pari_IA
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 12/06/2019
--
-- But               : active en fonction du premier les procedure de demande de contrat 
-- Remarques         : AUCUN
-- Pré conditions    : avoir le jeu de l'IA / savoir qui est premier
-- Post conditions   : active les procedure de demande de contrat et retourne le tableau des paris
-----------------------------------------------------------------------------
*)

Procedure Ordre_pari_IA (J : tableau ; Ptr_add : Ptr_noeud; nbdeJoueur, numdeManche, je : integer; VAR P : tabplateau);
Var
	tete , point : Ptr_noeud;
	compt, n : integer;
Begin
	setlength(P,nbdeJoueur);
	for n:=1 to nbdeJoueur do P[n]:=0;
	tete:=Recherche(J,Ptr_add);
	point:=tete;
	compt:=1;
	repeat
		ClrScr;
		writeln('le joueur ',je,' pari !');
		if ( je >= 1 ) and ( je <= nbdeJoueur_H ) then 
		begin
			affichejeu(point^.valeur);
			P[je]:=afficher_jeu (at, point^.valeur,numdeManche);
			Verife_pari(numdeManche, je, P);
		end;
		if je > nbdeJoueur_H then
		begin
			affichejeu(point^.valeur);
			calcule_pari_IA(point^.valeur, numdeManche, je ,P);
		end;
		
		if je+1 > nbdeJoueur then je:=1
		else je:=je+1;
		point:=point^.suivant;
		compt:=compt+1;
	until compt > nbdeJoueur-1;
	P[je]:=Pari_dernier_IA(point, numdeManche, je, P);
End;

(*---------------------------------------------------------------------------      
-- PROCEDURE         : PARI_IA
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 12/06/2019
--
-- But               : regarde qui est premier en fonction de la manche et du nombre de joueur  
-- Remarques         : AUCUN
-- Pré conditions    : avoir le jeu de l'IA 
-- Post conditions   : retourne le tableau des paris
-----------------------------------------------------------------------------
*)

PROCEDURE PARI_IA (M, J : integer; J1,J2,J3,J4,J5 : tableau; var P : tabplateau; VAR je : integer);	
Begin
	case J of
		2 : Begin
				case ( M mod J ) of 
					0 : begin je := 2; Ordre_pari_IA(J2 , Ptr_add, nbdeJoueur, numdeManche, 2 , P );  end;
					1 : begin je := 1; Ordre_pari_IA(J1 , Ptr_add, nbdeJoueur, numdeManche, 1 , P );  end;
				end;
			end;
		3 : Begin
				case ( M mod J ) of 
					0 :  begin je := 3; Ordre_pari_IA(J3 , Ptr_add, nbdeJoueur, numdeManche, 3 , P );  end;
					1 :  begin je := 1; Ordre_pari_IA(J1 , Ptr_add, nbdeJoueur, numdeManche, 1 , P );  end;
					2 :  begin je := 2; Ordre_pari_IA(J2 , Ptr_add, nbdeJoueur, numdeManche, 2 , P );  end;
				end;
			End;
		4 : Begin
				case ( M mod J ) of 
					0 :  begin je := 4; Ordre_pari_IA(J4 , Ptr_add, nbdeJoueur, numdeManche, 4 , P );  end;
					1 :  begin je := 1; Ordre_pari_IA(J1 , Ptr_add, nbdeJoueur, numdeManche, 1 , P );  end;
					2 :  begin je := 2; Ordre_pari_IA(J2 , Ptr_add, nbdeJoueur, numdeManche, 2 , P );  end;
					3 :  begin je := 3; Ordre_pari_IA(J3 , Ptr_add, nbdeJoueur, numdeManche, 3 , P );  end;
				end;
			End;
		5 : Begin
				case ( M mod J ) of 
					0 :  begin je := 5; Ordre_pari_IA(J5 , Ptr_add, nbdeJoueur, numdeManche, 5 , P );  end;
					1 :  begin je := 1; Ordre_pari_IA(J1 , Ptr_add, nbdeJoueur, numdeManche, 1 , P );  end;
					2 :  begin je := 2; Ordre_pari_IA(J2 , Ptr_add, nbdeJoueur, numdeManche, 2 , P );  end;
					3 :  begin je := 3; Ordre_pari_IA(J3 , Ptr_add, nbdeJoueur, numdeManche, 3 , P );  end;
					4 :  begin je := 4; Ordre_pari_IA(J4 , Ptr_add, nbdeJoueur, numdeManche, 4 , P );  end;
				end;
			End;
	end
End;


(*-----------------------------------------------*)
(*
FUNCTION perdremini;
verif Tabc
si Atout a été jouer
  jouer sa  meilleur carte
// prendre la carte gagnante pour l'instant
// prendre toutes les cartes inférieur à la carte gagnante pour l'instant
// prendre la max parmis celle-ci;
*)
(*------------------------------------------------*)



(*---------------------------------------------------------------------------      
-- PROCEDURE         : Perdre
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 21/06/2019
--
-- But               : trie le tableau des carte des joueurs dans l'ordre croissant  
-- Remarques         : PERDRE --> Tab[1]  et si GAGNER --> Tab[length(Tab)]
-- Pré conditions    : tabC, J[i] ... complet 
-- Post conditions   : Aucune
-----------------------------------------------------------------------------
*)

PROCEDURE TriBulle ( var Tab : tableau);
Var
	desordre : Boolean;
	i , T : integer;
Begin
	desordre := True;
	while desordre do
	Begin
		desordre := false;
		for i:=1 to  length(Tab)-1 do
		begin
			if Tab[i].nombre>Tab[i+1].nombre then
			begin
			desordre:=True;
			T:=Tab[i].nombre;
			tab[i]:=tab[i+1];
			Tab[i+1].nombre:=T;
			end;
		end;
	end;
End;

(*---------------------------------------------------------------------------      
-- PROCEDURE         : affiche_tableau
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 21/06/2019
--
-- But               : Tester TriInsertion *) // la supprimer une fois qu'on en a plus besoin
(* Remarques         : aucune
-- Pré conditions    : avoir la procedure
-- Post conditions   : Aucune
-----------------------------------------------------------------------------
*) 

Procedure affiche_tableau (Tab : tableau);
Var
	i:integer;
Begin
	writeln('');
	for i:=1 to length(Tab) do
	begin
		write('|_',Tab[i].nombre,'_|');
	end;
End;

(*---------------------------------------------------------------------------      
-- PROCEDURE         : Perdre
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 21/06/2019
--
-- But               : retourne une carte pour l'ordi afin que celui-ci perde.  
-- Remarques         : peut dans certains cas gagner
-- Pré conditions    : tabC, J[i] ... complet 
-- Post conditions   : Aucune
-----------------------------------------------------------------------------
*) 

PROCEDURE Perdre(M, nbdeJoueur : integer; tabC, J : tableau; at : atout; VAR perdante : CARTE; a : integer) ;
VAR//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	compar: Carte;
	taille, nb, b, i  : integer;
	tabchoisir : tableau;
	premier : boolean;
	
Begin
writeln('TESTPERDRE');
	taille := 0; nb := 1; b := 0;
	premier:=TRUE;
	for i:=1 to nbdeJoueur do
	begin
		if tabC[i].utilisation <> False then premier := False; 
	end;
	if premier = False then
	begin
		PremiereCarte (tabC , at,  nbdeJoueur, b , compar );
		if (compar.couleur = at.couleur) then // atout
		begin
			for i:=1 to length(J) do
			begin
				if J[i].nombre <= compar.nombre then
				begin
					taille :=taille+1;
					Setlength(tabchoisir, taille);
					tabchoisir[nb]:=J[i];
					nb:=nb+1;

					TriBulle(tabchoisir);
					perdante:= tabchoisir[taille];
				end;
			end;
		end
		else 
			for i:=1 to length(J) do 
			begin
				if (J[i].couleur = compar.couleur) then // AND (J[i]<= compar.nombre) then 
				begin
					if (J[i].nombre<= compar.nombre) then 
					begin
						taille:= taille +1;
						Setlength(tabchoisir,taille);
						tabchoisir[nb]:= J[i];
						nb:=nb+1;

						TriBulle(tabchoisir);
						perdante:= tabchoisir[taille];
					end
					else  // il n'y a pas de carte en dessous 
					begin
						taille:=taille +1 ; 
						Setlength(tabchoisir, taille);
						tabchoisir[nb]:=J[i];

						TriBulle(tabchoisir);
						perdante:= tabchoisir[taille];
					end;
				end;
			end;
		end
	else
	begin
		TriBulle(J);
		perdante:= J[M];
	end;
end;


(*---------------------------------------------------------------------------      
-- PROCEDURE         : Gagner
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 21/06/2019
--
-- But               : retourne une carte pour l'ordi afin que celui-ci perde.  
-- Remarques         : peut dans certains cas gagner
-- Pré conditions    : tabC, J[i] ... complet 
-- Post conditions   : Aucune
-----------------------------------------------------------------------------
*)

PROCEDURE Gagner( M, nbdeJoueur : integer; tabC, J : tableau; at : atout; VAR gagnante : CARTE; a : integer) ;
VAR
	compar: Carte;
	taille, nb, b, i  : integer;
	tabchoisir : tableau;
	premier : boolean;
	
Begin
Writeln('testGanger', nbdeJoueur);
	taille := 0; nb := 1; b := 0;
	premier:=TRUE;
	for i:=1 to nbdeJoueur do
	begin
		writeln('testG1');
		if tabC[i].utilisation <> False then premier := False;
		writeln('testG2',premier);
	end;
	if premier = False then
	begin
		writeln('testG3');
		PremiereCarte (tabC , at,  nbdeJoueur, b , compar );
		writeln('testG4');
		if (compar.couleur = at.couleur) then // atout
		begin
			for i:=1 to length(J) do
			begin
				if J[i].nombre >= compar.nombre then
				begin
					writeln('testG5');
					taille :=taille+1;
					Setlength(tabchoisir, taille);
					tabchoisir[nb]:=J[i];
					nb:=nb+1;

					TriBulle(tabchoisir);
					writeln('testG6');
					gagnante:= tabchoisir[1];///tabchoisir ne se remplie pas bien
					writeln('testG7', tabchoisir[1].nombre);
				end;
			end;
		end
		else 
		begin
			for i:=1 to length(J) do 
			  if (J[i].couleur = compar.couleur) then // AND (J[i]<= compar.nombre) then 
			  begin
				  if (J[i].nombre >= compar.nombre) then 
				  begin
					taille:= taille +1;
					Setlength(tabchoisir,taille);
					tabchoisir[nb]:= J[i];
					nb:=nb+1;

					TriBulle(tabchoisir);
					gagnante:= tabchoisir[1];
				  end
				  else   // il n'y a pas de carte en dessous 
				  begin
					taille:=taille +1 ; 
					Setlength(tabchoisir, taille);
					tabchoisir[nb]:=J[i];

					TriBulle(tabchoisir);
					gagnante:= tabchoisir[1];
				  end;
			  end; 
		end;
	end
	else
	begin
		TriBulle(J);
		gagnante := J[M];
	end;
end;

Procedure jouer_IA (J : tableau ;M, nbdeJoueur, numdeManche : integer; VAR tabC : tableau ; Preal, P : tabplateau; VAR je : integer);
VAR
	renvoi : CARTE;
Begin
	writeln('test5');
	if Preal[je]=P[je] then Perdre (M, nbdeJoueur , tabC, J, at, renvoi, je)
	else Gagner(M, nbdeJoueur, tabC, J, at, renvoi, je) ;
	tabC[je]:=renvoi;

End;

Procedure joueur_Hum ( VAR J : tableau; je, nbdeJoueur, numdeManche : integer; VAR  tabC : tableau);
VAR
	pos : integer;
Begin
	affiche_tableau(TabC);
	writeln('');
	writeln('le joueur: ',je);
	affichejeu (J);
	
	writeln('donnez la position de la carte que vous voulez jouer dans votre jeu : ');
	read(pos);
	TabC[je]:=J[pos];
	J[pos].utilisation:=False;
	for i:=pos to length (J)-1 do J[i]:=J[i+1];
	J[length (J)].utilisation:=False;
End;

Procedure Ordre_tour_IA (J : tableau ; Ptr_add : Ptr_noeud; M, je, nbdeJoueur,nbdeJoueur_H : integer ; VAR tabC : tableau; Preal, P : tabplateau);
Var
	compt : integer;
	tete,point : Ptr_noeud;
Begin

	Setlength(tabC, nbdejoueur);
	compt:=1;
	tete:=Recherche(J,Ptr_add);
	point:=tete;
	writeln('test2');
	repeat
		if je <= nbdeJoueur_H then joueur_Hum(point^.valeur,je, nbdeJoueur, numdeManche,tabC)
		else jouer_IA(point^.valeur ,M , nbdeJoueur ,numdeManche ,tabC, Preal, P, je);
		writeln('test3');
		point:=point^.suivant;
		if je+1 > nbdejoueur then je:=1
		else je:=je+1;
		compt:=compt+1;
		writeln('test4');
		ClrScr;
	Until compt > nbdeJoueur ; 

End;


Procedure association_IA (M, je, nbdeJoueur, numdeManche : integer;  J1,J2,J3,J4,J5 : tableau; Ptr_add : Ptr_noeud; VAR tabC : tableau; Preal, P : tabplateau);
Begin
	writeln('test1', je);
	case je of
		1 : Ordre_tour_IA(J1, Ptr_add, M, je, nbdejoueur, nbdeJoueur_H, tabC, Preal, P );
		2 : Ordre_tour_IA(J2, Ptr_add, M, je, nbdejoueur, nbdeJoueur_H, tabC, Preal, P );
		3 : Ordre_tour_IA(J3, Ptr_add, M, je, nbdejoueur, nbdeJoueur_H, tabC, Preal, P );
		4 : Ordre_tour_IA(J4, Ptr_add, M, je, nbdejoueur, nbdeJoueur_H, tabC, Preal, P );
		5 : Ordre_tour_IA(J5, Ptr_add, M, je, nbdejoueur, nbdeJoueur_H, tabC, Preal, P );
	end;

End;


(*---------------------------------------------------------------------------      
-- PROCEDURE         : IA
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 21/06/2019
--
-- But               : ????
-- Remarques         : ????
-- Pré conditions    : ???? 
-- Post conditions   : ????
-----------------------------------------------------------------------------
*)

PROCEDURE IA;
BEGIN
	//demande le nombre de joueur humain et le nombre de joueur artificiel et initialise numdeJoueur
	Writeln('Donnez le nombre de Joueur humain');
	read(nbdeJoueur_H);
	Writeln('Donnez le nombre de Joueur artificiel');
	read(nbdeJoueur_B);
	nbdeJoueur:=nbdeJoueur_H + nbdeJoueur_B;
	
	//initialise le nombre de manche max en fonction du nombre de joueur
	MancheTT:=nb_de_joueurs_calc_Manches(nbdeJoueur); 
	writeln('le nombre de manche total sera de ',MancheTT);
	
	//initialise plusieur variable et tableau
	numdeManche:=2;
	at.active:=FAlse;
	Setlength(Preal, nbdeJoueur+1);
	Setlength(TabPoint, nbdeJoueur+1);
	for c:=1 to nbdeJoueur do TabPoint[c]:=0;

	
	
	//debut de la première boucle repeat (MANCHE)
	
	repeat
	writeln('');
	writeln('%%%%%%%%%%%%%%% MANCHE NUMERO ', numdeManche,' %%%%%%%%%%%%%%%');
	writeln('');
	
		//melange les cartes
		Melengement;
		//distribution des cartes à chaque joueur
		tabcarte2:=deuxd_en_und(tabcarte);
		Distribution (nbdeJoueur, numdeManche, tabcarte2, J1,J2,J3,J4,J5, at );
		//initialise la liste chainer circulaire
		Ptr_add:=initialisationNoeud (nbdeJoueur, J1,J2,J3,J4,J5 );
		
		//PARI, interface des paris et affiche le tableau des contrats
		PARI_IA (numdeManche, nbdeJoueur, J1,J2,J3,J4,J5, P, je);
		ClrScr;
		
		Writeln('Table des Contrats : ');
		for i:=1 to nbdeJoueur do
		begin
			writeln('Le joueur' ,i,' doit faire ',P[i],' plis');
		end;
		
		//initialisation de variable
		for c:=1 to nbdeJoueur do Preal[c]:=0;
		M:=numdeManche;
		
		//debut de la seconde boucle repeat (TOUR de Table)
		repeat
		(* cc'et entrre les deux ligne bleu qu ca ne marche pas ------------------------------------------------*)
			//TOUR DE TABLE, interface du jeu et affiche le jeu et l'atout
			writeln('à partir dici , pour le rour de table ca ne marche pas (entre les deux lignes bleux). Si vous voulaer verivier c est dans l unit : PV_Unit  ');
			association_IA(M, je,nbdeJoueur, numdeManche, J1,J2,J3,J4,J5, Ptr_add, tabC, Preal, P);
			affichejeu(tabC);
			writeln('la couleur de l atout est ',at.couleur); 
			writeln('');
			
			//decide qui remporte le plis
			carte_gagnant.couleur:=tabC[je].couleur;
			carte_gagnant.nombre:=tabC[je].nombre;	
			PremiereCarte ( tabC, at, nbdeJoueur, je, carte_gagnant);
			remplie_Preal (tabC , at , carte_gagnant ,  je , Preal );
			
			//reinitialisation de variable
			for c:=1 to nbdeJoueur do tabC[c].utilisation:=False;
			
			M:=M-1;
			
		until(M=0);
		(*----------------------------------------------------------------------------------------------------------*)
		//calcule et affiche les points
		Calcule_Point(P, Preal, TabPoint );
		
		//passer à la manche suivante
		repeat 
		writeln('tapez 1 pour continuer');
		read(c);
		until ( c = 1 );
		
		//reinitialise le numeraux de la manche 
		if (numdeManche+1 <= MancheTT) and (at.active = FALSE) then 
		begin 
			numdeManche := numdeManche+1;	
		end
		else  
		begin
			numdeManche:=numdeManche-1; 
			at.active:=TRUE;
		end;
	ClrScr;	
	until(numdeManche=0) 
	
	

END;

(*---------------------------------------------------------------------------      
-- PROCEDURE         : HUMAIN
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 21/06/2019
--
-- But               : ????  
-- Remarques         : ????
-- Pré conditions    : ????
-- Post conditions   : ????
-----------------------------------------------------------------------------
*)

PROCEDURE HUMAIN;
VAR 
	i : integer;
BEGIN
	//demande le  nombre de joueur
	Writeln('Donnez le nombre de Joueur');
	read(nbdeJoueur);
	//initialise le nombre de manche max en fonction du nombre de joueur
	MancheTT:=nb_de_joueurs_calc_Manches(nbdeJoueur); 
	writeln('le nombre de manche total sera de ',MancheTT);
	
	//initialise plusieur variable et tableau
	numdeManche:=1;
	at.active:=False;
	Setlength(Preal, nbdeJoueur+1);
	Setlength(TabPoint, nbdeJoueur+1);
	for c:=1 to nbdeJoueur do TabPoint[c]:=0;

	
	
	//debut de la première boucle repeat (MANCHE)
		
	repeat
	
	writeln('');
	writeln('%%%%%%%%%%%%%%% MANCHE NUMERO ', numdeManche,' %%%%%%%%%%%%%%%');
	writeln('');
	
		//melange les cartes
		Melengement;
		//distribution des cartes à chaque joueur
		tabcarte2:=deuxd_en_und(tabcarte);
		Distribution (nbdeJoueur, numdeManche, tabcarte2, J1,J2,J3,J4,J5, at );
		//initialise la liste chainer circulaire
		Ptr_add:=initialisationNoeud (nbdeJoueur, J1,J2,J3,J4,J5 );
		//PARI, interface des paris et affiche le tableau des contrats
		
		Debut_pari (numdeManche, nbdeJoueur, J1,J2,J3,J4,J5, P, je);
		ClrScr;
		Writeln('Table des Contrats : ');
		for i:=1 to nbdeJoueur do
		begin
			writeln('Le joueur' ,i,' doit faire ',P[i],' plis');
		end;
		
		//initialisation de variable
		for c:=1 to nbdeJoueur do Preal[c]:=0;
		M:=numdeManche;
		
		//debut de la seconde boucle repeat (TOUR de Table)
			
		repeat 
		    
			//TOUR DE TABLE, interface du jeu et affiche le jeu et l'atout
			
			
			
			association (je, nbdeJoueur, numdeManche , J1,J2,J3,J4,J5 , Ptr_add, tabC);
			affichejeu(tabC);
			writeln('la couleur de l atout est ',at.couleur); 
			writeln('');
			
			//decide qui remporte le plis
			carte_gagnant.couleur:=tabC[je].couleur;
			carte_gagnant.nombre:=tabC[je].nombre;	
			PremiereCarte ( tabC, at, nbdeJoueur, je, carte_gagnant);
			remplie_Preal (tabC , at , carte_gagnant ,  je , Preal );
			
			//reinitialisation de variable
			for c:=1 to nbdeJoueur do tabC[c].utilisation:=False;
			
			M:=M-1;
			
		until(M=0);
		
		//fin de la seconde boucle repeat (TOUR de Table)
		
		//affiche le Recapitulatif de la partie : les enchères et le nombre de plis 
		writeln('');
		writeln('~~~~~~~~~ Recapitulatif de la partie ~~~~~~~~~');
		writeln('');
		for i:=1 to nbdeJoueur do
		begin
			writeln('Le joueur ',i,' devait faire ',P[i],' plis, et il a fait ',Preal[i],' plis ');
		end;
		writeln('');
		
		//calcule et affiche les points
		Calcule_Point(P, Preal, TabPoint );
		
	    //passer à la manche suivante
		repeat 
		writeln('tapez 1 pour continuer');
		read(c);
		until ( c = 1 );
		
		//reinitialise le numeraux de la manche 
		if (numdeManche+1 <= MancheTT) and (at.active = FALSE) then 
		begin 
			numdeManche := numdeManche+1;	
		end
		else  
		begin
			numdeManche:=numdeManche-1; 
			at.active:=TRUE;
		end;
	ClrScr;
	until(numdeManche=0) ;
	
	//fin de la première boucle repeat (MANCHE)
End;



BEGIN //PROGRAMME PRINCIPAL
	
	writeln('--------Version 1 : 100% humain--------');
	writeln('--------Version 2 : avec IA    --------');
	Writeln('a quelle version voulez vous jouer? tapez 1 ou 2');
	
	read(V);
	case V of 
			1 : HUMAIN ;
			2 : IA ; 
			else writeln('tapez 1 ou 2 ');
	end;
	
	
END.

