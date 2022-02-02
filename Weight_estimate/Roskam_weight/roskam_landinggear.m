function [W_lg] = roskam_landinggear(MTOW, Wfuel, L_sm, L_sn)
%WL = design landing weight in lbs
%n_ultl = ultimate loaad factor

WL=MTOW;
n_ultl=2;
W_lg = 0.013*MTOW + (0.362*(WL^0.417)*(n_ultl^0.950)*(L_sm^0.183)) + 6.2 + ...
    0.0013*MTOW + (0.007157*(WL^0.749)*(n_ultl)*(L_sn^0.788)) ;
end