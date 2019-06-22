#options --time=recv


% () is read "in the next step"
% see: https://en.wikipedia.org/wiki/Linear_temporal_logic

type bin = +{b0 : ()bin , b1 : ()bin , e:()1}


% copy bits to the future
proc copy : bin |- ()bin
proc copy = caseL ( b0 => R.b0 ; copy
                  | b1 => R.b1 ; copy
                  | e  => R.e ; waitL ; closeR )

proc plus1 : bin |- ()bin
proc plus1 = caseL ( b0 => R.b1 ; copy
                   | b1 => R.b0 ; plus1
                   | e => R.b1 ; waitL ;  R.e ; closeR )

proc six : bin
proc six = R.b0 ; R.b1 ; R .b1 ; R.e ; closeR

% Slow bits: bits "somewhere in the future" (=<>)
type sbits = +{b0 : ()<>sbits, b1 : ()<>sbits, e:()1}



proc compress : bin |- ()<>sbits
proc compress = caseL ( b0 => R.b0 ; compressB
                      | b1 => R.b1 ; compress
                      | e  => R.e ; waitL ; closeR )

% Skip zero and relay 1
proc compressB : bin |- ()<>sbits
proc compressB = caseL ( b0 => compressB
                       | b1 => R.b1 ; compress
                       | e  => R.e ; waitL ; closeR )

% test it:
% we use [bin] to specify the type of the interface
proc in : ()<>sbits
proc in = (R.b0 ; R.b1 ; R.b0 ; R.b0 ; R.b0 ; R.b0 ; R.b0 ; R.b0 ; R .b1 ; R.e ; closeR)  [bin] compress
exec in

% The output is:
%
%    % exec in
%    exec in
%    @ 11 @ closeR
%    @ 10 @ R.e
%    @ 10 @ nowR
%    @ 9 @ R.b1
%    @ 9 @ nowR
%    @ 3 @ R.b0
%    @ 3 @ nowR
%    @ 2 @ R.b1
%    @ 2 @ nowR
%    @ 1 @ R.b0
%    @ 1 @ nowR
%    %------------------------------
%    % success
%
