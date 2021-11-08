function [xc, yc]=carpetconvert(x1, x2, y, offset, x1p, x2p)
%CARPETCONVERT Converts points into carpet plot coordinates.
%   [xc, yc]=carpetconvert(x1, x2, y, offset, x1p, x2p) converts the points
%   x1p, x2p into carpet plot coordinates defined by (x1, x2, y, offset)
%   as described in CARPET.
%
%   The converted points are returned in [xc, yc].
%
%   See also CARPET.

%   Rob McDonald 
%   ramcdona@calpoly.edu  
%   19 February 2013 v. 1.0

% Calculate carpet plot cheater axis
xc = x1p + x2p * offset; 
  
% Interpolate contours to carpet plot y-axis
yc = interp2(x1,x2,y,x1p,x2p);
