-module(questions).
-export([bigNumFails/0, howToWriteMultipleCase/0]).

bigNumFails() ->
	% math:pow(2,1023).
	% works but
	math:pow(2,1024).
	% fails in `erl` with
	% ** exception error: an error occurred when evaluating an arithmetic expression
	%      in function  math:pow/2
	%         called as math:pow(2,1024)
	% according to Indrajith, it is because the computation requires too much memory
	% but it works in ruby and others also - i guess
	% so why not in Erlang ?
	% BEAM compile fails with
	% Warning: this expression will fail with a 'badarith' exception

% not a valid function as variable name has to be capital
% error in erl REPL is `exception error: no function clause matching questions:foo(1)`
% but import goes through fine. how to catch such issues ?
foo(x) ->
	x.

%% does not compile
%% error is, "questions.erl:36: variable 'X' unsafe in 'case' (line 27)"
howToWriteMultipleCase() ->
	%% will not compile, have run it in the REPL ie. erl
	%% X & Y is bound here
	P1 = case [2,3,4] of
				 [X,Y|_] -> X+Y;
				 [S] -> S;
				 _ -> 0
			 end,

	%% X & Y is bound before, so will not match
	%% additionally S is bound
	P2 = case [10] of
				 [X,Y|_] -> X+Y;
				 [S] -> S;
				 _ -> 0
			 end,

	%% X & Y is bound before, so will not match
	%% also S is bound before, so will not match
	%% even though in isolation it seems as if it will match S
	P3 = case [6] of
				 [X,Y|_] -> X+Y;
				 [S] -> S;
				 _ -> 0
			 end,

	P4 = case [] of
				 [X,Y|_] -> X+Y;
				 [S] -> S;
				 _ -> 0
			 end,

	[P1, P2, P3, P4].
