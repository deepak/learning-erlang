-module(funList).
-export([double/1, evens/1, test/0]).

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
	ok.
