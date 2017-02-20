-module(second).
-import(first, [square/1]).
-export([hypotenuse/2,perimeter/2]).

hypotenuse(A,B) ->
	S = first:square(A) + first:square(B),
	math:sqrt(S).

perimeter(A,B) ->
	H = hypotenuse(A,B),
	A + B + H.