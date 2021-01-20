UNIT UInter_J;
Interface
USES gLib2D, SDL_TTF,SDL, Utype;
	
		
VAR
	//Les tableaux
	J, TabC, Jeu, tab : tableau;
	tabl : tableau2d;
	//Les entiers
	numdeManche, M, x, y, rot, p, i, w, h, je : integer;
	//Les images
	image_J, image, image_Autre : gImage;
	//L'atout
	at : ATOUT;
	

Procedure Interface_joueur ( Jeu : tableau; M,x,y,rot,p,i,w,h : integer );
Procedure J_interface ( M,x,y,rot,j,i,w,h : integer);
Procedure Plateau (Jeu : tableau; M,x,y,rot,j,i,w,h : integer; TabC : tableau);
Procedure affichejeu (Var J : tableau);
Function afficher_jeu (at : ATOUT;J : tableau; numdeManche:integer):integer;
Function Pari_dernier (point : Ptr_noeud; numdeManche, jj : integer; P : tabplateau): integer;
PROCEDURE ecrire2d (tabl : tableau2d);
Procedure ecrire1d ( tab : tableau);
FUNCTION deuxd_en_und( tabcarte : tableau2d): tableau;

Implementation
USES sysutils;


(*
-----------------------------------------------------------------------------
-- PROCEDURE         : Interface_joueur
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 24/05/2019
--
-- But               : affiche les cartes du joueur
-- Remarques         : Aucune
-- Pré condition     : connaitre le nombre de joueur, avois trier et distribuer les cartes
-- Post conditions   : place les cartes
----------------------------------------------------------------------------
*)

Procedure Interface_joueur ( Jeu : tableau; M, x, y, rot, p, i, w, h : integer );
var 
	n, alpha : integer;
Begin
	alpha := 255;
	for n:=1 to length(Jeu) do
	begin
		if Jeu[n].utilisation=True then
		begin
			image_J := gTexLoad(Jeu[n].img);
			gBeginRects(image_J);
                gSetCoordMode(G_CENTER);
                gSetAlpha(alpha);
                gSetScaleWH(w, h);
                gSetCoord(x, y);
                gSetRotation(rot);
                gAdd();
            gEnd();
			x:=x+p;
			y:=y+i;	
		end;
	end;				
End;

(*
-----------------------------------------------------------------------------
-- PROCEDURE         :  J_interface
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 24/05/2019
--
-- But               : affiche les dos bleus
-- Remarques         : Aucune
-- Pré condition     : connaitre le nombre de joueur
-- Post conditions   : place les cartes
----------------------------------------------------------------------------
*)

Procedure J_interface ( M,x,y,rot,j,i,w,h : integer);
   VAR n,alpha : integer;
Begin
    alpha := 255;
	for n:= 1 to M do 
		begin
			image := gTexLoad('dos-bleu.png');
			gBeginRects(image);
                gSetCoordMode(G_CENTER);
                gSetAlpha(alpha);
                gSetScaleWH(w, h);
                gSetCoord(x, y);
                gSetRotation(rot);
                gAdd();
            gEnd();
			x:=x+j;
			y:=y+i;	
		end;
End;

(*
-----------------------------------------------------------------------------
-- PROCEDURE         : Plateau
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 24/05/2019
--
-- But               : affiche les cartes sur le plateau
-- Remarques         : Aucune
-- Pré condition     : avoir des carte sur le plateau
-- Post conditions   : place les cartes
----------------------------------------------------------------------------
*)

Procedure Plateau (Jeu : tableau; M,x,y,rot,j,i,w,h : integer; TabC : tableau);
Var 
	n, alpha : integer;

Begin
	alpha := 255;
	for n:=1 to length(TabC) do
	begin
		if ( TabC[n].nombre<>0 ) and (tabC[n].utilisation = TRUE) then
		begin
			image_Autre := gTexLoad(TabC[n].img);
			gBeginRects(image_Autre);
                gSetCoordMode(G_CENTER);
                gSetAlpha(alpha);
                gSetScaleWH(w, h);
                gSetCoord(x, y);
                gSetRotation(rot);
                gAdd();
            gEnd();
			x:=x+j;
			y:=y+i;	
		end;
	end;

End;

(*---------------------------------------------------------------------------
-- PROCEDURE         : affichejeu
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : affiche le jeu sur la console si elle est utilisable
-- Remarques         : 
-- Pré conditions    : avoir distribuer les cartes  
-- Post conditions   : affiche les cartes utilisables
-----------------------------------------------------------------------------
*)

Procedure affichejeu (Var J : tableau);
VAR
	i : integer;

Begin
	for i:=1 to length(J) do
		begin
			if J[i].utilisation=True then
			begin
				writeln('');
				write('la couleur: ',J[i].couleur);
				write(' | la valeur : ',J[i].nombre);
				writeln('');
			end;
		end;
End;


(*---------------------------------------------------------------------------
-- FUNCTION          : afficher_jeu
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : affiche les carte de chaque joueur et demande les nombre de plis voulue 
-- Remarques         : affiche l'atout (si il y en a un)
-- Pré conditions    : avoir distribuer les cartes  
-- Post conditions   : retourne le tableau des paris
-----------------------------------------------------------------------------
*)

Function afficher_jeu (at : ATOUT; J : tableau; numdeManche:integer):integer;
Var
	P :integer;
	pari : boolean;
	text_atout, text_image : gImage;
	font : PTTF_Font;
	
Begin

	gClear(BLACK);
	font := TTF_OpenFont('font.ttf', 45);
	text_image := gTextLoad('Donnez votre contrat sur la console', font);
	
	pari:=False;

			While pari=False do
				Begin
				Interface_joueur(J, numdeManche,G_SCR_W div (2)-(25*numdeManche),G_SCR_H div (2),0,50,0,130,150);
				
				gBeginRects(text_image);
					gSetCoordMode(G_CENTER);
					gSetCoord(G_SCR_W div 2, G_SCR_H div 4);
					gSetColor(CHARTREUSE);
					gAdd();
				gEnd();
				
				if at.active = TRUE then 
				Begin
					case at.couleur of 
							'coeur' : text_atout := gTextLoad('La couleur de l`atout est coeur',font);
							'pique' : text_atout := gTextLoad('La couleur de l`atout est pique',font);
							'carreau' : text_atout := gTextLoad('La couleur de l`atout est carreau',font);
							'trefle' : text_atout := gTextLoad('La couleur de l`atout est trefle',font);
				    end;
				    
					gBeginRects(text_atout);
						gSetCoordMode(G_CENTER);
						gSetCoord(G_SCR_W div 2, 450);
						gSetColor(CHARTREUSE);
						gAdd();
					gEnd();
				End;
				gFlip();
				
				writeln('donnez vos plis : ');
				read(P);
			
				if (P>=0) then 
					begin 
						pari:=True;
					end;
				end;
	
	afficher_jeu:=P;
End;

(*---------------------------------------------------------------------------
-- FUNCTION          : Pari_dernier
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : impose les plie au dernier joueur / affiches ses carte 
-- Remarques         : calcule les plis du dernier joueur en fonction des paris deja ennoncer 
     				   et affiche ses cartes et l'atout (si il y en a un)
-- Pré conditions    : avoir distribuer les cartes  
-- Post conditions   : retourne le tableau des paris
-----------------------------------------------------------------------------
*)

Function Pari_dernier (point : Ptr_noeud; numdeManche, jj : integer; P : tabplateau): integer;
Var
	S, i, enchere, t : integer;
	pari : boolean;
	font : PTTF_Font;
	text_image : gImage;
Begin
	gClear(BLACK);
	font := TTF_OpenFont('font.ttf', 45);
	text_image := gTextLoad('Si vous etes pret a jouer tapez 1 sur la console', font);
	
	S:=0;	
	enchere:=numdeManche+1;
	pari := TRUE;
	
	for i:=1 to length(P) do
		begin
			S:=P[i]+S;
		end;
		
	P[jj]:=enchere-S;
	writeln('les plis du joueur ',jj,' doivent être de ',enchere-S);
	
	While pari=TRUE do
			Begin
				
				UINTER_J.Interface_joueur(point^.valeur, numdeManche,G_SCR_W div (2)-(25*numdeManche),G_SCR_H div (2),0,50,0,130,150);
				
				gBeginRects(text_image);
					gSetCoordMode(G_CENTER);
					gSetCoord(G_SCR_W div 2, G_SCR_H div 4);
					gSetColor(CHARTREUSE);
					gAdd();
				gEnd();
			
				gFlip();
				
				writeln('si vous êtes pret à commencer tapez 1 ');
				read(t);
			
				if t=1 then 
				begin
					pari:=FALSE;
				end;
				
			End;
	Pari_dernier:=P[jj]
End;

(*
-----------------------------------------------------------------------------
-- PROCEDURE         : ecrire2d
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 24/05/2019
--
-- But               : verifier les melangements
-- Remarques         : Aucune
-- Post conditions   : ecrie le tableau 2d sur la console
----------------------------------------------------------------------------
*)

PROCEDURE ecrire2d (tabl : tableau2d) ;
var
i,j : integer;
begin
for i:=1 to 4 do
   for j:=1 to 13 do
writeln('|',tabl[i,j].couleur,'|',tabl[i,j].nombre,'|',tabl[i,j].utilisation,'|');

end;  

(*
-----------------------------------------------------------------------------
-- PROCEDURE         : ecrire1d
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 24/05/2019
--
-- But               : verifier les melangements
-- Remarques         : Aucune
-- Post conditions   : ecrie le tableau 1d sur la console
----------------------------------------------------------------------------
*)

Procedure ecrire1d ( tab : tableau);
Var
	i : integer;
Begin
	for i:=1 to length(tab) do 
	begin 
	writeln('|',tab[i].couleur,'|',tab[i].nombre,'|',tab[i].utilisation,'|');
	end;

End;

(*---------------------------------------------------------------------------
-- FUNCTION          : deuxd_en_und
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : avoir le nombre de joueur
-- Remarques         :
-- Pré conditions    : Aucune
-- Post conditions   : Aucune
-----------------------------------------------------------------------------
*)

FUNCTION deuxd_en_und( tabcarte : tableau2d): tableau;
var
i,j,k : integer;
tabcarte2 : tableau;
begin
	//writeln('tableau 1D');
	Setlength(tabcarte2,52);
	k:=1;
    for i:=1 to 4 do
		for j:=1 to 13 do
		begin
			tabcarte2[k]:=tabcarte[i,j];
			tabcarte2[k].utilisation:=TRUE;
			k:=k+1;
		end;
//ecrire1d(tabcarte2);
deuxd_en_und :=  tabcarte2;

end;


END.
