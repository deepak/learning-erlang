-module(palindrome).
-export([is_palindrome/1,test/0]).
-export([reverse/1,keep_char/1,is_char/1,to_lower/1]). % helpers

is_palindrome(String) ->
	CANONICAL_STRING = to_lower(keep_char(String)),
	CANONICAL_STRING =:= reverse(CANONICAL_STRING).

reverse([]) ->
	[];
reverse([H|T]) ->
	%% erlang:display(["reverse", H, T]),
	reverse(T) ++ [H].

keep_char([]) ->
	[];
keep_char([H|T]) ->
	%% erlang:display(["keep_char", H, T, is_char(H)]),
	case is_char(H) of
		true  -> [H | keep_char(T)];
		false -> keep_char(T)
	end.

%% TODO: convert this to be like to_lower.
%% how to use boolean and along with grouping in guard ?
%% is_char(C)	when is_integer(C), (($A =< C, C =< $Z); ($a =< C, C =< $z)) ->
is_char(Code) ->
	SmallA = 97,
	SmallZ = 122,
	CapitalA = 65,
	CapitalZ = 90,
	(Code >= SmallA andalso Code =< SmallZ)
		orelse (Code >= CapitalA andalso Code =< CapitalZ).

to_lower(C)	when is_integer(C), $A =< C, C =< $Z ->
	C + 32;
to_lower(C) when not is_list(C) ->
	C;
to_lower(S) when is_list(S) ->
	[to_lower(C) || C <- S].

test() ->
	false = is_palindrome("Not a Palindrome"),
	true = is_palindrome("noon"),
	true = is_palindrome("Madam I'm Adam"),
	ok.
