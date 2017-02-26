%%% find `perimeter` and `area` for some shapes like circle, rectangle and triangle
-module(shapes).
-export([perimeter/1, area/1, enclose/1, test/0]).

%% ======================
%% calculate perimeter %%
%% ======================

%% calculates the perimeter of a circle
perimeter({
						circle,     % type
						R           % radius
					}) ->
	2 * math:pi() * R;

%% calculates the perimeter of a rectangle
perimeter({
						rectangle,  % type
						W,          % width
						L           % length
					}) ->
	2 * (W + L);

%% calculates the perimeter of a triangle
%% when guard is for a valid triangle
perimeter({
						triangle,   % type
						A,          % side A
						B,          % side A
						C           % side C
					}) when A + B > C, A + C > B, B + C > A ->
	A + B + C.

%% ======================
%% calculate area      %%
%% ======================

%% calculates the area of a circle
area({
			 circle,          % type
			 R                % radius
		 }) ->
	math:pi() * R * R;

%% calculates the area of a rectangle
area({
			 rectangle,       % type
			 W,               % width
			 L                % length
		 }) ->
	W * L;

%% calculates the area of a triangle using Heron's formula
%% advantage is that the representation of a triangle is consistent.
%% other formula is 1/2 * Base * Height
%% but that fails when height is unknown
%% and we need to calculate height for `enclose/1`.
area({
			 triangle,        % type
			 A,               % side A
			 B,               % side B
			 C                % side C
		 }) when A + B > C, A + C > B, B + C > A ->
	S = perimeter({ triangle, A, B, C }) / 2,
	math:sqrt(S * (S - A) * (S - B) * (S - C)).

%% ===============================
%% calculate bounding rectangle %%
%% ===============================

%% calculates the bounding rectangle of a circle
enclose({
					circle,       % type
					R             % radius
				}) ->
	{ rectangle, 2 * R, 2 * R };

%% calculates the perimeter of a rectangle
enclose({
					rectangle,    % type
					W,            % width
					L             % length
				}) ->
	{ rectangle, W, L };

%% calculates the perimeter of a triangle
%% when guard is for a valid triangle
enclose({
					triangle,    % type
					A,           % side A
					B,           % side B
					C            % side C
				}) when A + B > C, A + C > B, B + C > A ->
	Base = max(A,B,C),
	Height = height({ triangle, A, B, C }),
	{ rectangle, Base, Height }.

%% helper methods

%% calculates the area of a triangle
%% when guard is for a valid triangle
height({
				 triangle,     % type
				 A,            % side A
				 B,            % side B
				 C             % side C
		 }) when A + B > C, A + C > B, B + C > A ->
	Base = max(A,B,C),
	Area = area({ triangle, A, B, C }),
	2 * Area / Base.

% max/2 is a erlang defined function
max(X,Y,Z) ->
	max(max(X,Y), Z).

%% test cases
test () ->
	Circle = { circle, 10 },
	Rectangle = { rectangle, 10, 20 },
	Triangle = { triangle, 10, 10, 10 },

	%% test perimeter
	62.83185307179586 = perimeter(Circle),
	60 = perimeter(Rectangle),
	30 = perimeter(Triangle),

	%% test area
	314.1592653589793 = area(Circle),
	200 = area(Rectangle),
	43.30127018922193 = area(Triangle),

	%% test enclose
	{ rectangle, 20, 20 } = enclose(Circle),
	Rectangle = enclose(Rectangle),
	{ rectangle, 10, 8.660254037844386 } = enclose(Triangle),

	ok.

%% ======
%% FIN %%
%% ======
