function [W_struct] = roskam_weights(W_w, W_fus, W_lg, W_emp)
% Roskam Class II Method - Cessna aproximation
[W_w] = roskam_wing(MTOW, S, n_ult, A) ;
[W_fus] = roskam_fuselage(MTOW, L_f, pmax, Npax) ;
[W_lg] = roskam_landinggear(MTOW, WL, n_ultl, L_sm, L_sn) ;
[W_emp] = roskam_emp(MTOW, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a) ;

W_struct = W_w + W_fus + W_lg + W_emp ;
end