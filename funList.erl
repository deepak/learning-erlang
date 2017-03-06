-module(funList).
-export([double/1, evens/1, take/2, nub/1, test/0]).

%% double
double([]) ->
	%% erlang:display("empty"),
	[];
double(X) when not is_list(X) ->
	%% erlang:display(["single", X]),
	X + X;
double([X]) when not is_list(X) ->
	%% erlang:display(["single element list", X]),
	[X + X];
double([X|Xs]) ->
	%% erlang:display(["list", X, Xs]),
	DoubleOfX = double(X),
	[DoubleOfX | double(Xs)].

%% evens
evens([], Acc) ->
	%% erlang:display(["empty with Acc", Acc]),
	Acc;
evens([X], Acc) ->
	%% erlang:display(["single element list", X, Acc]),
	case even(X) of
		true  -> [X|Acc];
	  false -> Acc
	end;
evens([X|Xs], Acc) when is_list(Xs) ->
	%% erlang:display(["list", X, Xs, Acc]),
	case even(X) of
		true  -> evens(Xs, [X|Acc]);
	  false -> evens(Xs, Acc)
	end.

evens(L) ->
	%% erlang:display(["start", L]),
	evens(L, []).

even(Number) ->
	Number rem 2 =:= 0.

%% take
take(0, _, Acc) ->
	Acc;
take(_Num, [], Acc) ->
	Acc;
take(Num, [X|Xs], Acc) ->
	%% erlang:display(["take/3", X, Acc]),
	take(Num-1, Xs, Acc++[X]).

take(0, _List) ->
	[];
take(Num, [X|Xs]) ->
	%% erlang:display(["take/2", X]),
	take(Num-1, Xs, [X]).

%% nub
nub([], Acc) ->
	Acc;
nub([X|Xs], Acc) ->
	%% erlang:display(["nub/2", X, Xs, Acc]),
	case lists:member(X, Acc) of
		true -> nub(Xs, Acc);
		false -> nub(Xs, Acc ++ [X])
	end.
nub(List) ->
	nub(List, []).

test() ->
	%% double
	[] = double([]),
	[[]] = double([[]]),
	[[], []] = double([[],[]]),
	[2] = double([1]),
	[2, 4] = double([1, 2]),
	[[], 2, 4] = double([[], 1, 2]),
	[2, 4, []] = double([1, 2, []]),

	%% evens
	[] = evens([]),
	[] = evens([1]),
	[2] = evens([2]),
	[2] = evens([1,2]),
	[2] = evens([2,1]),
	[10,4,8,4,4] = evens([4,4,8,5,4,1,10,3]),

	%% take
	[] = take(0, "hello"),
	"hell" = take(4, "hello"),
	"hello" = take(5, "hello"),
	"hello" = take(9, "hello"),

	%% nub
	[2,4,1,3] = nub([2,4,1,3,3,1]),

	ok.
