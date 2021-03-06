/**
TP 10 Prolog

@author Valentin ESMIEU
@author Florent MALLARD
@version Annee scolaire 2014/2015
*/
/*
===============================================================================
 Question 1.1 : make_all_pairs(+ListPeople,-ListLikes)
===============================================================================
*/
make_all_pairs([],[]).
make_all_pairs([Someone|Others],ListLikes):-
	make_all_pairs_for_someone(Someone,Others,[],ListTemp),
	make_all_pairs(Others,ListTemp2),
	append(ListTemp,ListTemp2,ListLikes).


make_all_pairs_for_someone(Someone,[],ListLikes,Res):-
	append([likes(Someone,Someone)],ListLikes,Res).	
make_all_pairs_for_someone(Someone,[Somebody|Others],ListLikes,Res):-
	%\==(Somebody,Someone),
	make_all_pairs_for_someone(Someone,Others,[likes(Somebody,Someone),likes(Someone,Somebody)|ListLikes],Res).

/*
===============================================================================
 Question 1.2 : sub_list(+ListPeople,-SubList)
===============================================================================
*/
sub_list([],[]).
sub_list([Someone|Others],[Someone|Res]):-
	sub_list(Others,Res).
sub_list([_|Others],Somebody):-
	sub_list(Others,Somebody).

/*
===============================================================================
 Question 1.3 : predX(+ListLikes)
===============================================================================
*/

% -- Dana aime Cody
pred1(ListLikes):-
	member(likes(dana,cody),ListLikes).

	
% -- Bess n'aime pas Dana
pred2(ListLikes):-
	not(member(likes(bess,dana),ListLikes)).
	
	
% -- Cody n'aime pas Abby
pred3(ListLikes):-
	not(member(likes(cody,abby),ListLikes)).
	
	
% -- Personne n'aime quelqu'un qui ne l'aime pas
pred4_vv(ListLikes):-
	not(pred4_negative(ListLikes)).
	
pred4_negative(ListLikes):-
	member(likes(A,B),ListLikes),
	not(member(likes(B,A),ListLikes)).
	
	
% -- Abby aime tous ceux qui aiment Bess
pred5(ListLikes):-
	prop5(ListLikes,ListLikes).

prop5([likes(A,bess)|Others],ListLikes):-
	member(likes(abby,A),ListLikes),
	prop5(Others,ListLikes).
prop5([likes(_,B)|Others],ListLikes):-
	\==(B,bess),
	prop5(Others,ListLikes).
prop5([],_).


% version 2
pred5_vv(ListLikes):-
	not(pred5_negative(ListLikes)).
	
pred5_negative(ListLikes):-
	member(likes(A,bess),ListLikes),
	not(member(likes(abby,A),ListLikes)).


% -- Dana aime tous ceux que Bess aime
pred6(ListLikes):-
	prop6(ListLikes,ListLikes).

prop6([likes(bess,B)|Others],ListLikes):-
	member(likes(dana,B),ListLikes),
	prop6(Others,ListLikes).
prop6([likes(A,_)|Others],ListLikes):-
	\==(A,bess),
	prop6(Others,ListLikes).
prop6([],_).



% version 2
pred6_vv(ListLikes):-
	not(pred6_negative(ListLikes)).
	
pred6_negative(ListLikes):-
	member(likes(bess,A),ListLikes),
	not(member(likes(dana,A),ListLikes)).
	
	

% -- Tout le monde aime quelqu'un
pred7_vv(ListLikes):-
	not(pred7_negative(ListLikes)).
	
pred7_negative(ListLikes):-
	member(likes(_,A),ListLikes),
	not(member(likes(A,_),ListLikes)).
	
	


/*
===============================================================================
 Question 1.4 : possibles_worlds(-ListLikes)
===============================================================================
*/

person(abby).
person(bess).
%person(dana).
%person(cody).

possible_worlds(World):-
	findall(People,person(People),Everybody),
	make_all_pairs(Everybody,Pairs),
	sub_list(Pairs,World),
	not(member(likes(A,A),World)).
	

/*
===============================================================================
 Question 1.5 : suppression des doublons
===============================================================================
*/

% ok

/*
===============================================================================
 Question 1.6 : possibles_worlds(-ListLikes)
===============================================================================
*/

test_possible_worlds :-
        possible_worlds(World),
        writeln(World),
        fail.
	
% La complexité semble être en 2 puissance n*(n-1), où n est le nombre de personnes.
% 1 personne  : 2^(1*0) = 1 monde possible
% 2 personnes : 2^(2*1) = 4 mondes possibles
% 4 personnes : 2^(4*3) = 4096 mondes possibles

/* 
----------------------------------------------------------------------------------------------------
 [Tests]

?- make_all_pairs([coco,valou,flobear],Res).
Res = [likes(coco, coco), likes(flobear, coco), likes(coco, flobear), likes(valou, coco), likes(coco, valou), likes(valou, valou), likes(flobear, valou), likes(valou, flobear), likes(flobear, flobear)]
Yes

----------------------------------------------------------------------------------------------------
?- sub_list([1,2,3,4],Sublist).
Sublist = [] ? ;
Sublist = [1] ? ;
Sublist = [2] ? ;
Sublist = [3] ? ;
Sublist = [4] ? ;
Sublist = [1,2] ? ;
Sublist = [1,3] ? ;
Sublist = [1,4] ? ;
Sublist = [2,3] ? ;
Sublist = [2,4] ? ;
Sublist = [3,4] ? ;
Sublist = [1,2,3] ? 
Sublist = [1,2,4] ? 
Sublist = [1,3,4] ? ;
Sublist = [2,3,4] ? ;
Sublist = [1,2,3,4] ? ;
Yes

----------------------------------------------------------------------------------------------------
?- pred1([likes(dana,cody)]).
yes

?- pred2([likes(bess,cody)]).
yes

pred3([likes(bess,cody)]).
yes

?- pred4_vv([likes(cody,bess)]).
no
?- pred4_vv([likes(cody,bess),likes(bess,cody)]).
yes

?- pred5([likes(cody,bess)]).
no
?- pred5_vv([likes(cody,bess)]).
no
?- pred5_vv([likes(cody,bess),likes(abby,cody)]).
yes
?- pred5([likes(cody,bess),likes(abby,cody)]).
yes

?- pred6([likes(dana,bertrand),likes(bess,bertrand)]).
yes
?- pred6_vv([likes(dana,bertrand),likes(bess,bertrand)]).
yes
?- pred6_vv([likes(bess,bertrand)]).
no
?- pred6([likes(bess,bertrand)]).
no

?- pred7_vv([likes(cody,bertrand),likes(bertrand,bess),likes(bess,cody)]).
yes
?- pred7_vv([likes(cody,bertrand),likes(bertrand,bess)]).
no
----------------------------------------------------------------------------------------------------
Pour 2 personnes :
possible_worlds(World).
World = [likes(bess, abby), likes(abby, bess)]
Yes (0.00s cpu, solution 1, maybe more) ? ;
World = [likes(bess, abby)]
Yes (0.00s cpu, solution 2, maybe more) ? ;
World = [likes(abby, bess)]
Yes (0.00s cpu, solution 3, maybe more) ? ;
World = []
Yes
*/
