% 18 septembre 2014
% TP2 TERMES CONSTRUITS - A compl�ter et faire tourner sous Eclipse Prolog
% ==============================================================================
% Valentin Esmieu - FLorent Mallard - G1.2
% ============================================================================== 
%	FAITS
% ============================================================================== 
/*
	hauteur(Valeur)
*/
hauteur(deux).
hauteur(trois).
hauteur(quatre).
hauteur(cinq).
hauteur(six).
hauteur(sept).
hauteur(huit).
hauteur(neuf).
hauteur(dix).
hauteur(valet).
hauteur(dame).
hauteur(roi).
hauteur(as).

/*
	couleur(Valeur)
*/
couleur(trefle).
couleur(carreau).
couleur(coeur).
couleur(pique).

/*
	succ_hauteur(H1, H2)
*/
succ_hauteur(deux, trois).
succ_hauteur(trois, quatre).
succ_hauteur(quatre, cinq).
succ_hauteur(cinq, six).
succ_hauteur(six, sept).
succ_hauteur(sept, huit).
succ_hauteur(huit, neuf).
succ_hauteur(neuf, dix).
succ_hauteur(dix, valet).
succ_hauteur(valet, dame).
succ_hauteur(dame, roi).
succ_hauteur(roi, as).

/*
	succ_couleur(C1, C2)
*/
succ_couleur(trefle, carreau).
succ_couleur(carreau, coeur).
succ_couleur(coeur, pique).

/*
  carte_test
  cartes pour tester le pr�dicat EST_CARTE
*/

carte_test(c1,carte(sept,trefle)).
carte_test(c2,carte(neuf,carreau)).
carte_test(ce1,carte(7,trefle)).
carte_test(ce2,carte(sept,t)).

/* 
	main_test(NumeroTest, Main) 
	mains pour tester le pr�dicat EST_MAIN 
*/

main_test(main_triee_une_paire, main(carte(sept,trefle), carte(valet,coeur), carte(dame,carreau), carte(dame,pique), carte(roi,pique))).
% attention ici m2 repr�sente un ensemble de mains	 
main_test(m2, main(carte(valet,_), carte(valet,coeur), carte(dame,carreau), carte(roi,coeur), carte(as,pique))).
main_test(main_triee_deux_paires, main(carte(valet,trefle), carte(valet,coeur), carte(dame,carreau), carte(roi,coeur), carte(roi,pique))).
main_test(main_triee_brelan, main(carte(sept,trefle), carte(dame,carreau), carte(dame,coeur), carte(dame,pique), carte(roi,pique))).	
main_test(main_triee_suite,main(carte(sept,trefle),carte(huit,pique),carte(neuf,coeur),carte(dix,carreau),carte(valet,carreau))).
main_test(main_triee_full,main(carte(deux,coeur),carte(deux,pique),carte(quatre,trefle),carte(quatre,coeur),carte(quatre,pique))).

main_test(merreur1, main(carte(sep,trefle), carte(sept,coeur), carte(dame,pique), carte(as,trefle), carte(as,pique))).
main_test(merreur2, main(carte(sep,trefle), carte(sept,coeur), carte(dame,pique), carte(as,trefle))).

% ============================================================================= 
%        QUESTION 1 : est_carte(carte(Hauteur,Couleur))
% ==============================================================================

est_carte(carte(Hauteur,Couleur)) 
	:- hauteur(Hauteur),couleur(Couleur).


% ============================================================================= 
%	QUESTION 2 : est_main(main(C1,C2,C3,C4,C5))
% ============================================================================= 

est_main(main(C1,C2,C3,C4,C5)):-
	est_carte(C1),
	est_carte(C2),
	\==(C1,C2),
	est_carte(C3),
	\==(C1,C3),
	\==(C2,C3),
	est_carte(C4),
	\==(C1,C4),
	\==(C2,C4),
	\==(C3,C4),
	est_carte(C5),
	\==(C1,C5),
	\==(C2,C5),
	\==(C3,C5),
	\==(C4,C5).


% ==============================================================================
%       QUESTION 3 : inf_carte(C1,C2) premi�re version
% ============================================================================= 

% vrai si Couleur 1 <= Couleur 2
couleur_inf(C,C).
couleur_inf(Coul1,Coul2):-
	succ_couleur(Coul1, Coul2).
couleur_inf(Coul1,Coul2):-
	succ_couleur(Coul1,X),
	couleur_inf(X,Coul2).

% vrai si Hauteur 1 <= Hauteur 2
hauteur_inf(H,H).
hauteur_inf(Haut1,Haut2):-
	succ_hauteur(Haut1, Haut2).
hauteur_inf(Haut1,Haut2):-
	succ_hauteur(Haut1,X),
	hauteur_inf(X,Haut2).

inf_carte(carte(H1,C1),carte(H2,C2)):-
	est_carte(carte(H1,C1)),
	est_carte(carte(H2,C2)),
	hauteur_inf(H1,H2).
inf_carte(carte(H,C1),carte(H,C2)):-
	couleur_inf(C1,C2).
	
	



% ============================================================================= 
%       QUESTION 3 : inf_carte_b(C1,C2) deuxi�me version
% ==============================================================================



% ==============================================================================
%       QUESTION 4 : est_main_triee(main(C1,C2,C3,C4,C5))
% ==============================================================================

est_main_triee(main(C1,C2,C3,C4,C5)):-
	est_main(main(C1,C2,C3,C4,C5)),
	inf_carte(C1,C2),
	inf_carte(C2,C3),
	inf_carte(C3,C4),
	inf_carte(C4,C5).

% ==============================================================================
%       QUESTION 5 : une_paire(main(C1,C2,C3,C4,C5))
% ==============================================================================
meme_hauteur(carte(H,C1), carte(H,C2)) :-
	est_carte(carte(H,C1)),
	est_carte(carte(H,C2)),
	\==(C1,C2).

une_paire(main(C1,C2,C3,C4,C5)):-
	est_main_triee(main(C1,C2,C3,C4,C5)),
	meme_hauteur(C1,C2).
une_paire(main(C1,C2,C3,C4,C5)):-
	est_main_triee(main(C1,C2,C3,C4,C5)),
	meme_hauteur(C2,C3).
une_paire(main(C1,C2,C3,C4,C5)):-
	est_main_triee(main(C1,C2,C3,C4,C5)),
	meme_hauteur(C3,C4).
une_paire(main(C1,C2,C3,C4,C5)):-
	est_main_triee(main(C1,C2,C3,C4,C5)),
	meme_hauteur(C4,C5).


% ==============================================================================
%       QUESTION 6 : deux_paires(main(C1,C2,C3,C4,C5))
% ==============================================================================
deux_paire(main(C1,C2,C3,C4,C5)):-
	est_main_triee(main(C1,C2,C3,C4,C5)),
	meme_hauteur(C1,C2),
	meme_hauteur(C3,C4).
deux_paire(main(C1,C2,C3,C4,C5)):-
	est_main_triee(main(C1,C2,C3,C4,C5)),
	meme_hauteur(C1,C2),
	meme_hauteur(C4,C5).
deux_paire(main(C1,C2,C3,C4,C5)):-
	est_main_triee(main(C1,C2,C3,C4,C5)),
	meme_hauteur(C2,C3),
	meme_hauteur(C4,C5).


% ============================================================================= 
%       QUESTION 7 : brelan(main(C1,C2,C3,C4,C5))
% ============================================================================= 
brelan(main(C1,C2,C3,C4,C5)):-
	est_main_triee(main(C1,C2,C3,C4,C5)),
	meme_hauteur(C1,C2),
	meme_hauteur(C2,C3).
brelan(main(C1,C2,C3,C4,C5)):-
	est_main_triee(main(C1,C2,C3,C4,C5)),
	meme_hauteur(C2,C3),
	meme_hauteur(C3,C4).
brelan(main(C1,C2,C3,C4,C5)):-
	est_main_triee(main(C1,C2,C3,C4,C5)),
	meme_hauteur(C3,C4),
	meme_hauteur(C4,C5).


% ============================================================================= 
%       QUESTION 8 : suite(main(C1,C2,C3,C4,C5))
% ==============================================================================
suiv(carte(H1,C1),carte(H2,C2)):-
	succ_hauteur(H1,H2).

suite(main(C1,C2,C3,C4,C5)):-
	suiv(C1,C2),
	suiv(C2,C3),
	suiv(C3,C4),
	suiv(C4,C5).

% ============================================================================= 
%       QUESTION 9 : full(main(C1,C2,C3,C4,C5))
% ============================================================================= 
full(main(C1,C2,C3,C4,C5)):-
	meme_hauteur(C1,C2),
	meme_hauteur(C2,C3),
	meme_hauteur(C4,C5).
full(main(C1,C2,C3,C4,C5)):-
	meme_hauteur(C1,C2),
	meme_hauteur(C3,C4),
	meme_hauteur(C4,C5).


% ==============================================================================

/* TESTS QUESTION 1 : carte_test
?-est_carte(X).

X = carte(as, pique)
Yes (0.01s cpu, solution 52)
*/

% ============================================================================= 

/*  TESTS QUESTION 2 : est_main
?-est_main(M).

M = main(carte(deux, trefle), carte(deux, carreau), carte(deux, coeur), carte(deux, pique), carte(trois, trefle))
Yes (0.00s cpu, solution 1, maybe more) ?
*/

% ============================================================================= 

/* TESTS QUESTION 3 premiere version
?-inf_carte(C1,C2).

C1 = carte(deux, trefle)
C2 = carte(trois, trefle)
Yes (0.00s cpu, solution 1, maybe more) ?
*/

% ==============================================================================

/* TESTS QUESTION 3 deuxieme version

*/

% ==============================================================================

/* TESTS QUESTION 4
?-est_main_triee(M).

M = main(carte(deux, trefle), carte(trois, trefle), carte(quatre, trefle), carte(cinq, trefle), carte(six, trefle))
Yes (0.00s cpu, solution 1, maybe more) ? 
*/

% ============================================================================= 

/* TESTS QUESTION 5
?-une_paire(M).

M = main(carte(deux, trefle), carte(deux, carreau), carte(deux, coeur), carte(deux, pique), carte(trois, trefle))
Yes (0.00s cpu, solution 1, maybe more) ? 
*/

% ==============================================================================

/* TESTS QUESTION 6
?-deux_paire(main(carte(valet,trefle), carte(valet,coeur), carte(dame,carreau), carte(roi,coeur), carte(roi,pique))).

Yes (0.00s cpu, solution 1, maybe more) ?

?-deux_paire(main(carte(sept,trefle), carte(valet,coeur), carte(dame,carreau), carte(dame,pique), carte(roi,pique))).

No (0.00s cpu)


*/

% ==============================================================================


/* TESTS QUESTION 7
?-brelan(main(carte(sept,trefle), carte(valet,coeur), carte(dame,carreau), carte(dame,pique), carte(roi,pique))).

No (0.00s cpu)

?-brelan(main(carte(sept,trefle), carte(dame,carreau), carte(dame,coeur), carte(dame,pique), carte(roi,pique))).

Yes (0.00s cpu, solution 1, maybe more) ? 


*/

% ==============================================================================

/* TESTS QUESTION 8
?-suite(main(carte(sept,trefle),carte(huit,pique),carte(neuf,coeur),carte(dix,carreau),carte(valet,carreau))).

Yes (0.00s cpu)

?-suite(main(carte(valet,trefle), carte(valet,coeur), carte(dame,carreau), carte(roi,coeur), carte(roi,pique))).

No (0.00s cpu)

*/

% ============================================================================= 

/* TESTS QUESTION 9
?-full(main(carte(valet,trefle), carte(valet,coeur), carte(dame,carreau), carte(roi,coeur), carte(roi,pique))).

No (0.00s cpu)

?-full(main(carte(deux,coeur),carte(deux,pique),carte(quatre,trefle),carte(quatre,coeur),carte(quatre,pique))).

Yes (0.00s cpu)


*/
