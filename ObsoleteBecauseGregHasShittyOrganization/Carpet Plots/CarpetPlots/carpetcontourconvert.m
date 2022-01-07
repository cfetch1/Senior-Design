function Cconv=carpetcontourconvert(x1, x2, y, offset, C)
%CARPETCONTOURCONVERT Converts contour curves into carpet plot coordinates.
%   Cconv=carpetcontourconvert(x1, x2, y, offset, C) converts the contour
%   curves in C into carpet plot coordinates defined by (x1, x2, y, offset)
%   as described in CARPET.
%
%   The converted contour curves are returned in Cconv.
%
%   See also CARPET, CARPETCONVERT.

%   Rob McDonald 
%   ramcdona@calpoly.edu  
%   19 February 2013 v. 1.0

Cconv=C;  % Initialize to same size.

nlimit=size(C,2);
icont=1;
while(icont<nlimit)
  n=C(2,icont);
  
  % Pick off contour points
  x1c=C(1,icont+1:icont+n);
  x2c=C(2,icont+1:icont+n);

  % Convert curves to carpet coordinates.
  [xc, yc] = carpetconvert(x1, x2, y, offset, x1c, x2c);
  
  % Reconstruct converted contour curves
  Cconv(1,icont+1:icont+n) = xc;
  Cconv(2,icont+1:icont+n) = yc;
  
  icont=icont+n+1;
end
