-module(patMat).
-export([xor1/2, xor2/2, maxThree/3, howManyEqual/3]).

xor1(X,X) ->
	false;
xor1(_,_) ->
	true.

xor2(true, false) ->
	true;
xor2(false, true) ->
	true;
xor2(_,_) ->
	false.

maxThree(X,Y,Z) ->
	maxTwo(maxTwo(X,Y), Z).

maxTwo(X,Y) ->
	case X > Y of
		true -> X;
		false -> Y
	end.

% TODO: can we sort and then match ?
% otherwise possible matches exploded
% any other way ?
howManyEqual(X,X,X) ->
	3;
howManyEqual(X,X,_) ->
	2;
howManyEqual(_,X,X) ->
	2;
howManyEqual(X,_,X) ->
	2;
howManyEqual(_,_,_) ->
	0.

% TODO: generic versions for howManyEqual (for N arguments) and maxThree (for N arguments)
