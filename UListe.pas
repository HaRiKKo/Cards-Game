UNIT UListe;
Interface
USES Utype;


		


VAR
	J : tableau;
	nbdeJoeur : integer;
	J1,J2,J3,J4,J5 : tableau;
	tete : Ptr_noeud;


FUNCTION creerNoeud ( J  : tableau ) : Ptr_noeud;
Function initialisationNoeud ( nbdeJoueur : integer; J1,J2,J3,J4,J5 : tableau ): Ptr_noeud;
Function Recherche (J : tableau; tete : Ptr_noeud):Ptr_noeud;

Implementation
USES sysutils;

(*---------------------------------------------------------------------------
-- FUNCTION          : creerNoeud
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : creer un nouveau noeuds  
-- Remarques         : 
-- Pré conditions    : avoir distribuer les cartes 
-- Post conditions   : retourne un temps et un pointeur qui pointe sur rien (nil)
-----------------------------------------------------------------------------
*)

FUNCTION creerNoeud ( J  : tableau ) : Ptr_noeud;
VAR
	ptr_add : Ptr_noeud;
BEGIN
	new(ptr_add);
	ptr_add^.valeur := J;
	ptr_add^.suivant := nil;
	creerNoeud := ptr_add;
END;

(*---------------------------------------------------------------------------
-- FUNCTION          : initialisationNoeud
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : creer un nouveau noeuds  
-- Remarques         : 
-- Pré conditions    : avoir distribuer les cartes 
-- Post conditions   : retourne une liste CIRCULAIRE et un pointeur qui pointe sur rien (nil)
-----------------------------------------------------------------------------
*)

Function initialisationNoeud ( nbdeJoueur : integer; J1,J2,J3,J4,J5 : tableau ): Ptr_noeud;
VAR
	tete,P2,P3,P4,P5 : Ptr_noeud;
Begin
	tete:=creerNoeud(J1);
	case nbdeJoueur of 
		2 : begin
			P2 := creerNoeud(J2);
			tete^.suivant := P2;
			P2^.suivant:=tete;
			end;
		3 : begin
			P2 := creerNoeud(J2);
			P3 := creerNoeud(J3);
			tete^.suivant := P2;
			P2^.suivant:=P3;
			P3^.suivant:=tete;
			end;
		4 : begin
			P2 := creerNoeud(J2);
			P3 := creerNoeud(J3);
			P4 := creerNoeud(J4);
			tete^.suivant := P2;
			P2^.suivant:=P3;
			P3^.suivant:=P4;
			P4^.suivant:=tete;
			end;
		5 : begin
			P2 := creerNoeud(J2);
			P3 := creerNoeud(J3);
			P4 := creerNoeud(J4);
			P5 := creerNoeud(J5);
			tete^.suivant := P2;
			P2^.suivant:=P3;
			P3^.suivant:=P4;
			P4^.suivant:=P5;
			P5^.suivant:=tete;
			end;	
	end;
	initialisationNoeud:=tete;
End;

(*---------------------------------------------------------------------------
-- FUNCTION          : Recherche
-- Auteur            : CHEVRIER.C, MOHAMED_FARHAN.F, DEROBERT.T <chevrierch@eisti.eu>
-- Date de creation  : 02/06/2019
--
-- But               : recherche une valeur dans une liste 
-- Remarques         : 
-- Pré conditions    : avoir distribuer les cartes  
-- Post conditions   : retourne se qui seras la tete de la liste
-----------------------------------------------------------------------------
*)

Function Recherche (J : tableau; tete : Ptr_noeud):Ptr_noeud;
VAR
	p : Ptr_noeud;
Begin

	p:=tete;
	WHILE (p^.valeur <> J) DO p := p^.suivant;
	tete := p;
	Recherche:=tete;

End;

END.
