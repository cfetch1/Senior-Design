function h=carpettext(x1, x2, y, offset, x1p, x2p, str, xoff, yoff, varargin)
%CARPETTEXT Prints text on carpet plot axes.
%   h = carpettext(x1, x2, y, offset, x1p, x2p, str) Prints text
%   on a carpet plot grid.  The carpet plot coordinates are defined by 
%   (x1, x2, y, offset) as described in CARPET.  x1p, x2p specify the text
%   location in dependent variable coordinates.  str specifies the string
%   to print.
%
%   h = carpettext(x1, x2, y, offset, x1p, x2p, str, xoff, yoff)
%   xoff and yoff specify x & y offsets (in carpet plot coordinates) for
%   the text labels.  Default offsets are 0.0.
%
%   Any additional parameters are passed to the TEXT command.
%   
%   See also CARPET, CARPETLABEL, CARPETCONVERT, TEXT.

%   Rob McDonald 
%   ramcdona@calpoly.edu  
%   19 February 2013 v. 1.0

% Handle default offset values.
if( nargin < 8 )
  xoff = 0;
end

if( nargin < 9 )
  yoff = 0;
end

% Convert coordinates to carpet plot coordinates.
[xc, yc] = carpetconvert( x1, x2, y, offset, x1p, x2p );

% Plot text in carpet plot coordinates.
h = text( xc + xoff, yc + yoff, str, varargin{:} );
