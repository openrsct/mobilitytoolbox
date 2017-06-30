%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%   Zdenek Becvar   %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%   FEMTO Path Loss Model - ITU-R P.1238  %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%DESCRIPTION
%   Path Loss model for indoor communication according to ITU-R P.1238 (defined in [0013])
%
%FUNCTION
%   function [PL] = PathLoss1238(Type, Freq, Dist, Floors)
%
%OUTPUTS
%   PL... Path Loss [dB]
%
%INPUTS
%   Type...Type of building ['R' / 'O' / 'C'] R...Residential, O...Office, C...Commercial
%   Freq...Operating frequency [MHz]
%   Dist...Distance between MS and BS/FAP [m]; Dist > 1m
%   Floors...Number of floors between BS/FAP and MS; Floors>=1
%%%%%%%%%%%%%%%%%%%%%%

function [PL] = PathLoss1238(Typef, Freq, Dist, Floors)

if Dist<1
    %sprintf('Wrong Distance (<1m)')
end;
if Floors<1
    %sprintf('Wrong Number of floors (<1)')
end;

if Typef=='R'  % Residential
    N=28;
    Lf=4*Floors;
elseif Typef=='O' % Office
    N=33;
    if Floors==1
        Lf=9;
    elseif Floors==2
        Lf=19;
    elseif Floors==3
        Lf=24;
    else
        Lf=15+4*(Floors-1);
    end;
elseif Typef=='C' %Commercial
    N=20;
    Lf=4*Floors; % it is not clear in [Interference Management_ v2...0013] it can be 4*Floors or 6+3(Floors-1)
else
    %sprintf('Wrong Type of building')
end;

PL=20*log10(Freq)+N*log10(Dist)+Lf-28;
end






