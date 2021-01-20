UNIT Utype;
Interface

TYPE

			carte= record //Type carte 
			couleur: string;
			nombre : integer;
			utilisation : boolean;
			img : string; 	
		END;

		tableau = array of carte; // tabelau des carte en 1D serviras, pour la distribution
		tabplateau  = array of integer; // tableau de nombre, serviras pour les paris et le calsule des plis gagner
		tableau2d = array[1..4,1..13] of carte ; // tableau de carte en 2D serviras, pour le melange
		
		Ptr_noeud = ^Noeud; 	// type pointeur sur Noeud
		Noeud = RECORD			// Liste de tableau = relie les jeu des joueurs 
			valeur : Tableau;
			suivant : Ptr_noeud;
		END;
	
		ATOUT = record //Type atout 
			active : boolean;
			couleur: string;
		END;
		
Implementation
USES sysutils;

END.
