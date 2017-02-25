-module(fib).
-export([at/1]).

% 0,1,1,2,3,5,8
at(X) when X == 1 ->
	 0;
at(X) when X == 2 ->
	1;
at(X) when X > 2 ->
	at(X - 2) + at(X - 1).
