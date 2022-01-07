function h = carpetlabel(x1, x2, y, offset, nref, x1flag, x2flag, xoff, yoff, varargin)
%CARPETLABEL Labels carpet plot axes.
%   h = carpetlabel(x1, x2, y, offset, nref) Prints labels on a carpet 
%   plot grid.  The carpet plot coordinates are defined by 
%   (x1, x2, y, offset) as described in CARPET.  nref specifies the number
%   of labels to skip, typically the same value as used with CARPET is
%   used.
%
%   h = carpetlabel(x1, x2, y, offset, nref, xflag, yflag)
%   x1flag controls which (-1 min, 0 none, 1 max) extent of the x2 domain
%   the x1 labels are printed.  Default is 1.
%   
%   x2flag controls which (-1 min, 0 none, 1 max) extent of the x1 domain
%   the x2 labels are printed.  Default is 1.
%
%   h = carpetlabel(x1, x2, y, offset, nref, xflag, yflag, xoff, yoff)
%   xoff and yoff specify x & y offsets (in carpet plot coordinates) for
%   the text labels.  Default offsets are 0.0.
%
%   Any additional parameters are passed to the TEXT command.
%   
%   See also CARPET, CARPETTEXT, CARPETCONVERT, TEXT.

%   Rob McDonald 
%   ramcdona@calpoly.edu  
%   19 February 2013 v. 1.0

if( nargin < 6 )
  x1flag = 1;
end

if( nargin < 7 )
  x2flag = 1;
end

if( nargin < 8 )
  xoff = 0;
end

if( nargin < 9 )
  yoff = 0;
end

h=[];
if(x1flag ~= 0)
  if(x1flag < 0)
    x2l = x2(1);
  else
    x2l = x2(end);
  end
  for xl1 = x1(1:nref+1:end)
    h = [h carpettext(x1, x2, y, offset, xl1, x2l, num2str(xl1), xoff, yoff, varargin{:})];
  end
end

if(x2flag ~= 0)
  if(x2flag < 0)
    x1l = x1(1);
  else
    x1l = x1(end);
  end
  
  for xl2 = x2(1:nref+1:end)
    h = [h carpettext(x1, x2, y, offset, x1l, xl2, num2str(xl2), xoff, yoff, varargin{:})];
  end
end

