%%% take a positive integer N and returns the sum of the bits in the binary representation
-module(sumBits).
-export([bitsNR/1, bitsR/1, bitsTR/1, test/0]).

%% non-recursive
bitsNR(N) when N > 0 ->
	Binary = erlang:integer_to_list(N, 2),
	lists:foldl(fun(Term, Sum) ->
									Count = case Term of
														49 -> 1;
														48 -> 0
													end,
									%% erlang:display([Term, Count]),
									Count + Sum
							end,
							0, Binary).

%% recursive
bitsR([]) ->
	0;
bitsR(48) ->
	0;
bitsR(49) ->
	1;
bitsR([H|T]) ->
	%% erlang:display(["both", H, T]),
	bitsR(H) + bitsR(T);
bitsR(N) when is_number(N), N > 0 ->
	Binary = erlang:integer_to_list(N, 2),
	bitsR(Binary).

%% tail-recursive
bitsTR(N) when is_number(N), N > 0 ->
	Binary = erlang:integer_to_list(N, 2),
	computeBitsTR(Binary, 0).

computeBitsTR([], C) ->
	C;
computeBitsTR([H|T], C) ->
	%% erlang:display(["both", H, T]),
	Count = case H of
						49 -> 1;
						48 -> 0
					end,
	computeBitsTR(T, C + Count).

test() ->
	3 = bitsNR(7),
	1 = bitsNR(8),
	3 = bitsR(7),
	1 = bitsR(8),
	3 = bitsTR(7),
	1 = bitsTR(8),
	ok.
