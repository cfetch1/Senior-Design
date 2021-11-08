function xref = refvec( x, nref )
%REFVEC Refines a vector.
%   xref = refvec( x, nref ) generates a refined version of x with nref
%   additional equally spaced values inserted between the values of x.
%
%   The refined vector is returned in xref.
%
%   REFVEC provides an easy way to create refined vectors to create smooth
%   carpet plots using CARPET.
%
%   See also CARPET.

%   Rob McDonald 
%   ramcdona@calpoly.edu  
%   19 February 2013 v. 1.0

norig = length(x);
nfinal = (norig-1)*(nref+1)+1;
xref = zeros(1,nfinal);

for i=1:norig-1
  imin = (i-1)*(nref+1)+1;
  xref(imin:imin+nref+1) = linspace(x(i),x(i+1),nref+2);
end

