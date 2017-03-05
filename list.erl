-module(list).
-export([productTR/1, maxListDR/1, test/0]).

%% product of a list (tail recursive)
%% TODO: do not see how this is good ?
%% am i just writing bad erlang code ? or this example is too small ?
%% feel like we take a small problem and split it into smaller worse pieces
productTR([]) ->
	1;
productTR(L) ->
	productTR(L,1).

productTR([], P) ->
	P;
productTR([H|T], P) ->
	productTR(T, H * P).

%% product of a list (direct recursive)
%% much better than the tail recursive version
productDR([]) ->
	1;
productDR(X) when is_number(X) ->
	X;
productDR([H|T]) ->
	productDR(H * productDR(T)).

%% maximum in a list. cannot be named `max` as that is an Erlang function (BIF)
%% both tail and direct recursion seem good here
%% but would prefer direct recursion for readability

%% direct recursive version
maxListDR([]) ->
	1;
maxListDR([H|T]) ->
	erlang:max(H, maxListTR(T)).

%% tail recursive version
maxListTR([], MAX) ->
	MAX;
maxListTR([H|T], MAX) ->
	NEW_MAX = erlang:max(H, MAX),
	maxListTR(T, NEW_MAX).

maxListTR(L) when is_list(L) ->
	maxListTR(L, 1).

%% tests
test() ->
	%% product (tail recursive)
  1 = productTR([]),
	1 = productTR([1]),
	2 = productTR([1,2]),
	6 = productTR([1,2,3]),
	300 = productTR([5,6,10]),
	100 = productTR([100]),
	-100 = productTR([-100]),
	-2000 = productTR([-100, 20]),
	20000 = productTR([-100, 20, -10]),

	%% product (direct recursive)
  1 = productDR([]),
	1 = productDR([1]),
	2 = productDR([1,2]),
	6 = productDR([1,2,3]),
	300 = productDR([5,6,10]),
	100 = productDR([100]),
	-100 = productDR([-100]),
	-2000 = productDR([-100, 20]),
	20000 = productDR([-100, 20, -10]),

	%% max (direct recursive)
	10 = maxListDR([10]),
	20 = maxListDR([10,20]),
	30 = maxListDR([10,20,30]),

	%% max (tail recursive)
	10 = maxListTR([10]),
	20 = maxListTR([10,20]),
	30 = maxListTR([10,20,30]),

	ok.
