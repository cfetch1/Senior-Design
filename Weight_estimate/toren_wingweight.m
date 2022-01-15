function [W_w] = toren_wingweight(MTOW, bs, b_ref, n_ult, tr, S)
% for light aircraft (less than 12000lbs) and cantilever wings

% MTOW = in lb
% W_w = wing weight in lbs
% b = wing span
% lam = sweep angle at 50% chord
% bs = structural span in ft = b/lam
% b_ref =  reference span = 6.25 ft (given in book)
% n_ult = ultimate load factor
% tr = max thickness of root chord
% S = wing surface area in ft^2

bs = b/lam ;
W_w = MTOW*0.00125*(bs^0.75)*abs(1+ sqrt(bs/b_ref))*(n_ult^0.55)*(((bs/tr)/(MTOW/S))^0.3);

end