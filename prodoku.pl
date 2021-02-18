/*

Made for Paris VIII University.


              PROJET 1 :
   ___________________________________
  |  	     					      |
  |      La résolution de Sudoku      |
  |___________________________________|


Une grille de sudoku 9x9 contient 9 rangées et 9 colonnes, le but du jeu est
de remplir les cases vides avec un chiffre de 1 à 9 qui doit être unique
dans la rangée, dans la colonne, et unique dans son carré de 9 cases.

Autrement dit, un jeu parfait pour Prolog.

Nous allons commencer par une petite grille de 4x4, avant de s'attaquer à
une grille classique de 9x9.


REPRÉSENTATION D'UNE GRILLE 4x4 :

A1 | B1 | C1 | D1 
A2 | B2 | C2 | D2 
A3 | B3 | C3 | D3
A4 | B4 | C4 | D4

A1 B1 C1 D1 représentent la première rangée.
A1 A2 A3 A4 représentent la première colonne.
A1 B1 A2 B2 représentent le premier carré.

Pour que Prolog puisse résoudre une grille 4x4 on peut s'inspirer du
Chapitre 2 du cours, avec l'exercice amusant où chaque lettre représentait
un chiffre.

On commence par initialiser les chiffres possibles : */

chiffre(1).
chiffre(2).
chiffre(3).
chiffre(4).

% Les chiffres doivent être uniques sur la même ligne, colonne, et dans le
% carré, on va donc créér un prédicat pour s'assurer que les chiffres soient
% uniques :

uniques4x4(A,B,C,D) :- chiffre(A), chiffre(B), chiffre(C), chiffre(D),
	A=\=B, A=\=C, A=\=D,
	B=\=C, B=\=D,
	C=\=D.

% Maintenant le corps du programme, le prédicat qui va résoudre le sudoku 4x4.
% Il faut mettre en paramètre les 16 cases de la grille :

sudoku4x4(A1,B1,C1,D1,A2,B2,C2,D2,A3,B3,C3,D3,A4,B4,C4,D4) :-
	uniques4x4(A1,B1,C1,D1),   % chaque rangée doit contenir des chiffres uniques
	uniques4x4(A2,B2,C2,D2),
	uniques4x4(A3,B3,C3,D3),
	uniques4x4(A4,B4,C4,D4),
	uniques4x4(A1,A2,A3,A4),   % de même pour chaque colonne
	uniques4x4(B1,B2,B3,B4),
	uniques4x4(C1,C2,C3,C4),
	uniques4x4(D1,D2,D3,D4),
	uniques4x4(A1,B1,A2,B2),   % idem pour les 4 carrés de la grille
	uniques4x4(A3,B3,A4,B4),
	uniques4x4(C1,D1,C2,D2),
	uniques4x4(C3,D3,C4,D4),
	write(A1), write(' | '), write(B1), write(' | '),   % on imprime le résultat de manière à avoir
	write(C1), write(' | '), write(D1), nl,             % une grille
	write(A2), write(' | '), write(B2), write(' | '),
	write(C2), write(' | '), write(D2), nl,
	write(A3), write(' | '), write(B3), write(' | '),
	write(C3), write(' | '), write(D3), nl,
	write(A4), write(' | '), write(B4), write(' | '),
	write(C4), write(' | '), write(D4).



/*
Test 1 :

?- sudoku4x4(3, 4, 1, _,
_, 2, _, _,
_, _, 2, _,
_, 1, 4, 3).


Résultat :

3 | 4 | 1 | 2
1 | 2 | 3 | 4
4 | 3 | 2 | 1
2 | 1 | 4 | 3
true ;
false.

__________________________________

Test 2 :

sudoku4x4(_, 3, 4, _,
4, _, _, 2,
1, _, _, 3,
_, 2, 1, _).


Résultat :

2 | 3 | 4 | 1
4 | 1 | 3 | 2
1 | 4 | 2 | 3
3 | 2 | 1 | 4
true ;
false.
*/



% ----------------------------------------------------
% ----------------------------------------------------

/* REPRÉSENTATION D'UNE GRILLE 9x9 :


A1 | B1 | C1 | D1 | E1 | F1 | G1 | H1 | I1
A2 | B2 | C2 | D2 | E2 | F2 | G2 | H2 | I2
A3 | B3 | C3 | D3 | E3 | F3 | G3 | H3 | I3
A4 | B4 | C4 | D4 | E4 | F4 | G4 | H4 | I4
A5 | B5 | C5 | D5 | E5 | F5 | G5 | H5 | I5
A6 | B6 | C6 | D6 | E6 | F6 | G6 | H6 | I6
A7 | B7 | C7 | D7 | E7 | F7 | G7 | H7 | I7
A8 | B8 | C8 | D8 | E8 | F8 | G8 | H8 | I8
A9 | B9 | C9 | D9 | E9 | F9 | G9 | H9 | I9


Si la première méthode était simple et rapide pour trouver la solution d'une
grille sudoku de 4x4, cela ne va pas être pareil pour une grille composée de
81 cases. Le résultat va mettre beaucoup trop de temps pour arriver, il faut
donc changer de méthode et utiliser la méthode de programmation par
contrainte avec le module clp/bounds que l'on va exécuter ici : */

:- use_module(library(bounds)).

/* Ce module va permettre de créer un prédicat différent de celui utilisé pour
la grille 4x4. En effet, si je réutilisais la méthode originale, le
programme mettrait extrêmement longtemps à trouver la solution.
L'utilisation du module va permettre une vitesse éclair.

On vient restreindre les valeurs (domaines) de Chiffre aux chiffres de 1 inclus à 9 inclus.
On indique ensuite que tous les chiffres doivent être uniques/différents. */

uniques9x9(Chiffre) :- Chiffre in 1..9, all_different(Chiffre).

sudoku9x9(A1,B1,C1,D1,E1,F1,G1,H1,I1, A2,B2,C2,D2,E2,F2,G2,H2,I2,
	A3,B3,C3,D3,E3,F3,G3,H3,I3, A4,B4,C4,D4,E4,F4,G4,H4,I4,
	A5,B5,C5,D5,E5,F5,G5,H5,I5, A6,B6,C6,D6,E6,F6,G6,H6,I6,
	A7,B7,C7,D7,E7,F7,G7,H7,I7, A8,B8,C8,D8,E8,F8,G8,H8,I8,
	A9,B9,C9,D9,E9,F9,G9,H9,I9) :-
	% les colonnes sont mises dans des listes et doivent chacune contenir des chiffres uniques
	uniques9x9([A1,A2,A3,A4,A5,A6,A7,A8,A9]),
	uniques9x9([B1,B2,B3,B4,B5,B6,B7,B8,B9]),
	uniques9x9([C1,C2,C3,C4,C5,C6,C7,C8,C9]),
	uniques9x9([D1,D2,D3,D4,D5,D6,D7,D8,D9]),
	uniques9x9([E1,E2,E3,E4,E5,E6,E7,E8,E9]),
	uniques9x9([F1,F2,F3,F4,F5,F6,F7,F8,F9]),
	uniques9x9([G1,G2,G3,G4,G5,G6,G7,G8,G9]),
	uniques9x9([H1,H2,H3,H4,H5,H6,H7,H8,H9]),
	uniques9x9([I1,I2,I3,I4,I5,I6,I7,I8,I9]),
	% de même pour les rangées :
	uniques9x9([A1,B1,C1,D1,E1,F1,G1,H1,I1]),
	uniques9x9([A2,B2,C2,D2,E2,F2,G2,H2,I2]),
	uniques9x9([A3,B3,C3,D3,E3,F3,G3,H3,I3]),
	uniques9x9([A4,B4,C4,D4,E4,F4,G4,H4,I4]),
	uniques9x9([A5,B5,C5,D5,E5,F5,G5,H5,I5]),
	uniques9x9([A6,B6,C6,D6,E6,F6,G6,H6,I6]),
	uniques9x9([A7,B7,C7,D7,E7,F7,G7,H7,I7]),
	uniques9x9([A8,B8,C8,D8,E8,F8,G8,H8,I8]),
	uniques9x9([A9,B9,C9,D9,E9,F9,G9,H9,I9]),
	% idem dans les carrés, ici le carré 1 :
	uniques9x9([A1,B1,C1,A2,B2,C2,A3,B3,C3]),
	uniques9x9([A4,B4,C4,A5,B5,C5,A6,B6,C6]),
	uniques9x9([A7,B7,C7,A8,B8,C8,A9,B9,C9]),
	% carré 2 :
	uniques9x9([D1,E1,F1,D2,E2,F2,D3,E3,F3]),
	uniques9x9([D4,E4,F4,D5,E5,F5,D6,E6,F6]),
	uniques9x9([D7,E7,F7,D8,E8,F8,D9,E9,F9]),
	%carré 3 :
	uniques9x9([G1,H1,I1,G2,H2,I2,G3,H3,I3]),
	uniques9x9([G4,H4,I4,G5,H5,I5,G6,H6,I6]),
	uniques9x9([G7,H7,I7,G8,H8,I8,G9,H9,I9]),
	% label vient assigner une valeur à chaque variable en suivant les contraintes
	label([A1, A2, A3, A4, A5, A6, A7, A8, A9]),
	label([B1, B2, B3, B4, B5, B6, B7, B8, B9]),
	label([C1, C2, C3, C4, C5, C6, C7, C8, C9]),
	label([D1, D2, D3, D4, D5, D6, D7, D8, D9]),
	label([E1, E2, E3, E4, E5, E6, E7, E8, E9]),
	label([F1, F2, F3, F4, F5, F6, F7, F8, F9]),
	label([G1, G2, G3, G4, G5, G6, G7, G8, G9]),
	label([H1, H2, H3, H4, H5, H6, H7, H8, H9]),
	label([I1, I2, I3, I4, I5, I6, I7, I8, I9]),
	% enfin on imprime ici aussi la solution :
	write(A1), write(' | '), write(B1), write(' | '),
	write(C1), write(' | '), write(D1), write(' | '),
	write(E1), write(' | '), write(F1), write(' | '),
	write(G1), write(' | '), write(H1), write(' | '),
	write(I1), nl,
	write(A2), write(' | '), write(B2), write(' | '),
	write(C2), write(' | '), write(D2), write(' | '),
	write(E2), write(' | '), write(F2), write(' | '),
	write(G2), write(' | '), write(H2), write(' | '),
	write(I2), nl,
	write(A3), write(' | '), write(B3), write(' | '),
	write(C3), write(' | '), write(D3), write(' | '),
	write(E3), write(' | '), write(F3), write(' | '),
	write(G3), write(' | '), write(H3), write(' | '),
	write(I3), nl,
	write(A4), write(' | '), write(B4), write(' | '),
	write(C4), write(' | '), write(D4), write(' | '),
	write(E4), write(' | '), write(F4), write(' | '),
	write(G4), write(' | '), write(H4), write(' | '),
	write(I4), nl,
	write(A5), write(' | '), write(B5), write(' | '),
	write(C5), write(' | '), write(D5), write(' | '),
	write(E5), write(' | '), write(F5), write(' | '),
	write(G5), write(' | '), write(H5), write(' | '),
	write(I5), nl,
	write(A6), write(' | '), write(B6), write(' | '),
	write(C6), write(' | '), write(D6), write(' | '),
	write(E6), write(' | '), write(F6), write(' | '),
	write(G6), write(' | '), write(H6), write(' | '),
	write(I6), nl,
	write(A7), write(' | '), write(B7), write(' | '),
	write(C7), write(' | '), write(D7), write(' | '),
	write(E7), write(' | '), write(F7), write(' | '),
	write(G7), write(' | '), write(H7), write(' | '),
	write(I7), nl,
	write(A8), write(' | '), write(B8), write(' | '),
	write(C8), write(' | '), write(D8), write(' | '),
	write(E8), write(' | '), write(F8), write(' | '),
	write(G8), write(' | '), write(H8), write(' | '),
	write(I8), nl,
	write(A9), write(' | '), write(B9), write(' | '),
	write(C9), write(' | '), write(D9), write(' | '),
	write(E9), write(' | '), write(F9), write(' | '),
	write(G9), write(' | '), write(H9), write(' | '),
	write(I9).




/* Test 1

?- sudoku9x9(_, _, 7, 9, 6, 2, 4, _, _,
9, _, _, _, 1, _, _, _, 2, 
_, 1, _, 8, 5, 3, _, 6, _, 
5, _, _, 4, 7, 9, _, _, 1, 
_, _, _, _, 8, _, _, _, _, 
4, _, _, 3, 2, 1, _, _, 7, 
_, 9, _, 2, 4, 8, _, 5, _, 
6, _, _, _, 3, _, _, _, 8,
_, _, 8, 6, 9, 5, 1, _, _).


Résultat :

8 | 3 | 7 | 9 | 6 | 2 | 4 | 1 | 5
9 | 5 | 6 | 7 | 1 | 4 | 8 | 3 | 2
2 | 1 | 4 | 8 | 5 | 3 | 7 | 6 | 9
5 | 8 | 3 | 4 | 7 | 9 | 6 | 2 | 1
1 | 7 | 2 | 5 | 8 | 6 | 9 | 4 | 3
4 | 6 | 9 | 3 | 2 | 1 | 5 | 8 | 7
7 | 9 | 1 | 2 | 4 | 8 | 3 | 5 | 6
6 | 4 | 5 | 1 | 3 | 7 | 2 | 9 | 8
3 | 2 | 8 | 6 | 9 | 5 | 1 | 7 | 4
true ;
false.

__________________________________

Test 2:

sudoku9x9(9, _, 3, _, _, _, _, _, 8,
_, 6, _, _, _, _, _, 1, _, 
_, 5, _, 2, _, _, _, 9, _, 
_, _, _, 1, 6, 4, 5, _, 2, 
_, _, _, _, 3, _, _, _, _, 
6, _, 1, 5, 8, 7, _, _, _, 
_, 4, _, _, _, 6, _, 8, _, 
_, 8, _, _, _, _, _, 2, _,
2, _, _, _, _, _, 3, _, 7).


Résultat :

9 | 1 | 3 | 6 | 7 | 5 | 2 | 4 | 8
4 | 6 | 2 | 8 | 9 | 3 | 7 | 1 | 5
7 | 5 | 8 | 2 | 4 | 1 | 6 | 9 | 3
8 | 3 | 9 | 1 | 6 | 4 | 5 | 7 | 2
5 | 7 | 4 | 9 | 3 | 2 | 8 | 6 | 1
6 | 2 | 1 | 5 | 8 | 7 | 9 | 3 | 4
3 | 4 | 5 | 7 | 2 | 6 | 1 | 8 | 9
1 | 8 | 7 | 3 | 5 | 9 | 4 | 2 | 6
2 | 9 | 6 | 4 | 1 | 8 | 3 | 5 | 7
true ;
false.

__________________________________

Test 3 : 

sudoku9x9(_, _, _, 4, _, 1, _, _, 6,
8, 5, _, 2, _, _, 4, _, _, 
_, 2, _, 5, _, _, _, _, _, 
_, _, _, _, _, _, 5, _, 4, 
4, 1, _, _, _, _, _, 6, 3, 
9, _, 5, _, _, _, _, _, _, 
_, _, _, _, _, 8, _, 2, _, 
_, _, 9, _, _, 4, _, 7, 5,
7, _, _, 6, _, 2, _, _, _).


Résultat :

3 | 9 | 7 | 4 | 8 | 1 | 2 | 5 | 6
8 | 5 | 6 | 2 | 3 | 9 | 4 | 1 | 7
1 | 2 | 4 | 5 | 6 | 7 | 9 | 3 | 8
6 | 7 | 8 | 1 | 2 | 3 | 5 | 9 | 4
4 | 1 | 2 | 8 | 9 | 5 | 7 | 6 | 3
9 | 3 | 5 | 7 | 4 | 6 | 1 | 8 | 2
5 | 4 | 3 | 9 | 7 | 8 | 6 | 2 | 1
2 | 6 | 9 | 3 | 1 | 4 | 8 | 7 | 5
7 | 8 | 1 | 6 | 5 | 2 | 3 | 4 | 9
true ;
false.

*/