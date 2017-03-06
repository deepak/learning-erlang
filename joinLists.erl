-module(joinLists).
-export([doublePlus/2, concat/1, test/0]).

doublePlus(L, R) when is_list(L), is_list(R) ->
	shunt(reverse(L), R).

%% nest doublePlus calls. eg. `doublePlus(doublePlus(doublePlus`
concat([X,Y]) ->
	%% erlang:display(["concat 2", X, Y]),
	doublePlus(X,Y);
concat([X,Y,Z]) ->
	%% erlang:display(["concat 3", X, Y, Z]),
	doublePlus(doublePlus(X,Y), Z);
%% concat([P,Q,R,S]) ->
%% 	erlang:display(["concat 4", P, Q, R, S]),
%% 	doublePlus(doublePlus(doublePlus(P,Q), R), S);
concat([F,S|T]) ->
	%% erlang:display(["concat N", F, S, T]),
	doublePlus(doublePlus(F,S), concat(T)).

%% helpers

reverse(L) when is_list(L) ->
	shunt(L, []).

shunt([], Ys) ->
	Ys;
shunt([H|T], Ys) ->
	shunt(T, [H|Ys]).

test() ->
	%% doublePlus
	"hello" = doublePlus("hel", "lo"),
	"hello" = doublePlus([$h,$e,$l], [$l, $o]),

	%% concat
	"hello" = concat(["hel", "lo"]),
	"wellhello" = concat(["well", "hel", "lo"]),
	"goodbye" = concat(["goo","d","by","e"]),
	"sogoodbye" = concat(["so", "go","od","by","e"]),
	"goodbye" = concat(["goo","d","","by","e"]),

	ok.
