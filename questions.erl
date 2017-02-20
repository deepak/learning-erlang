-module(questions).
-export([bigNumFails/0]).

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
