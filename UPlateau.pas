UNIT UPlateau;
Interface
USES gLib2D, SDL_TTF, SDL, UInter_J, Utype ;

VAR
	numdeManche, nbdeJoueur : integer;
	J, TabC : tableau;

Procedure jouer ( VAR J : tableau; je, nbdeJoueur, numdeManche : integer; tabC : tableau);

Implementation
USES sysutils;

(*---------------------------------------------------------------------------
-- PROCEDURE         : jouer
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : vas afficher le second interface et vas demander la position de la carte
-- Remarques         : affichage personnaliser en fonction du nombre de joueur 
-- Pré conditions    : avoir distribuer les cartes et creer la liste circulaire / connaitre le numéraux du joueur qui joue
-- Post conditions   : retourne le tableau des cartes posé sur la table 
-----------------------------------------------------------------------------
*)

Procedure jouer ( VAR J : tableau; je, nbdeJoueur, numdeManche : integer; tabC : tableau);
Var
	pos, x, y : integer;
	jeu : boolean;

	
Begin

	writeln('');
	writeln('le joueur: ',je);
	affichejeu (J);
	gClear(BLACK);
	jeu:=TRUE;
	
	while jeu=TRUE do
	begin

	gFillRect(100,50, G_SCR_W -200,G_SCR_H-100, ACAJOU);
	gFillRect(-250 + G_SCR_W div 2, -200 + G_SCR_H div 2, 500, 400, EPINARD );
    
    x := 50; 
    y := 50; 
    
    case nbdeJoueur of
    
		2 : begin
		J_interface ( numdeManche,G_SCR_W div (2)-(10*numdeManche),y,0 ,20,0,80,100); 
		Interface_joueur (J, numdeManche,G_SCR_W div (2)-(10*numdeManche),G_SCR_H -y,0 ,20,0,80,100);
		Plateau (J , numdeManche,G_SCR_W div (2),G_SCR_H div (2),0,0,0,80,100 , TabC);
		end;
		3 : begin 
		J_interface ( numdeManche,x+25,G_SCR_H div (2)-(10*numdeManche),90 ,0,20,80,100);
		J_interface ( numdeManche,G_SCR_W div (2)-(10*numdeManche),y,0 ,20,0,80,100); 
		Interface_joueur (J, numdeManche,G_SCR_W div (2)-(10*numdeManche),G_SCR_H -y,0 ,20,0,80,100);
		Plateau (J , numdeManche,300,G_SCR_H div (2),0,200,0,80,100 , TabC);
		end;
		4 : begin 
		J_interface ( numdeManche,x+25,G_SCR_H div (2)-(10*numdeManche),90 ,0,20,80,100);
		J_interface ( numdeManche,G_SCR_W div (2)-(10*numdeManche),y,0 ,20,0,80,100); 
		J_interface ( numdeManche,G_SCR_W-75,G_SCR_H div (2)-(10*numdeManche),90 ,0,20,80,100);  
		Interface_joueur (J, numdeManche,G_SCR_W div (2)-(10*numdeManche),G_SCR_H -y,0 ,20,0,80,100);
		Plateau (J , numdeManche,200,G_SCR_H div (2),0,200,0,80,100 , TabC);
		end;
		5 : begin
		UInter_J.J_interface ( numdeManche,x+25,y+105 ,135 ,15,-15,80,100); 
		UInter_J.J_interface ( numdeManche,x+570,y-25 ,45 ,15,15,80,100); 
		UInter_J.J_interface ( numdeManche,x+130,y+525 ,45 ,-15,-15,80,100); 
		UInter_J.J_interface ( numdeManche,x+675,y+405  ,135 ,-15,15,80,100);
		UInter_J.Interface_joueur (J, numdeManche,G_SCR_W div (2)-(10*numdeManche),G_SCR_H -y,0 ,20,0,80,100);
		UInter_J.Plateau (J , numdeManche,205,G_SCR_H div (2),0,130,0,80,100 , TabC);
		end;
		else  writeln('Erreur nombre de joueur entre 2 et 5');
		end;
		//interface_Parie(parie,numdeManche,P);
		
	gFlip();
	
	writeln('donnez la position de la carte que vous voulez jouer dans votre jeu : ');
	read(pos);
	TabC[je]:=J[pos];
	J[pos].utilisation:=False;
		
	if  (pos > 0)  and  (pos < length(J))  then jeu:=FALSE;
	
	end;
	for i:=pos to length (J)-1 do J[i]:=J[i+1];
	J[length (J)].utilisation:=False;
	
	//Setlength(J,n-1);
	
End;



END.
