function h=plotcontours(C,varargin)
%PLOTCONTOURS Plot contours
%   H=plotcontours(C,VARARGIN) plots the contours specified in C.  Any
%   parameters passed in varargin are passed directly to the plot command.
%   
%   The graphics handles for all of the curves are returned in H.
%
%   Conventionally a labeled contour plot would be created with the
%   following code:
%
%   [c,h] = contour(x,y,z);
%   clabel(c,h);
%
%   Using CONTOURC and PLOTCONTOURS, this can be accomplished with the
%   following code:
%
%   c = contourc(x,y,z);
%   h = plotcontours(c);
%   clabel(c,h);
%
%   By separating generation and plotting of the contour curves,
%   PLOTCONTOURS enables the user to modify the contour curves before
%   plotting them.  The driving requirement for this is to transform the
%   contours using CARPETCONTOURCONVERT onto a carpet plot.
%
%   This function is essentially identical to HATCHEDCONTOURS except it
%   uses the PLOT command instead of HATCHEDLINE.
%
%   See also CARPET, CARPETCONTOURCONVERT, HATCHEDCONTOURS, CONTOURC.

%   Rob McDonald 
%   ramcdona@calpoly.edu  
%   19 February 2013 v. 1.0

% Break contour array C into curves for individual plotting and plot them.

% Store axis setting in case figure is cleared.
ax=axis;

holdsetting=ishold;
if(~holdsetting) 
  clf
  axis(ax);
end
hold on;

nlimit=size(C,2);
h=[];
icont=1;
while(icont<nlimit)
  n=C(2,icont);
  
  % Pick off contour points
  xc=C(1,icont+1:icont+n);
  yc=C(2,icont+1:icont+n);
  
  % Plot contour curves
  h=[h; plot(xc,yc,varargin{:})];
  icont=icont+n+1;
end

if(~holdsetting)
  hold off;
end