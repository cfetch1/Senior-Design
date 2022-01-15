function [W_w] = toren_wingweight(MTOW, bs, b_ref, n_ult, tr, S)
% for light aircraft (less than 12000lbs) and cantilever wings
% W_w = wing weight in lbs
% bs = ?? in ft
% b_ref = 6.25 ft
% n_ult = 
% tr = 
% S = 

W_w = MTOW*0.00125*(bs^0.75)*abs(1+ sqrt(bs/b_ref))*(n_ult^0.55)*(((bs/tr)/(MTOW/S))^0.3);

end