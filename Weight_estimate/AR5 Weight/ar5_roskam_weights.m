function [W_struct_roskam] = ar5_roskam_weights(MTOW, S, AR, Ltot, pmax, Npax, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a, Wfuel, L_sm, L_sn)
% Roskam Class II Method - Cessna aproximation
[W_w] = roskam_wing(MTOW, S, AR);
[W_fus] = roskam_fuselage(MTOW, Ltot, pmax, Npax) ;
[W_lg] = roskam_landinggear(MTOW, Wfuel, L_sm, L_sn) ;
[W_emp] = roskam_emp(MTOW, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a) ;

W_struct_roskam = W_w + W_fus  + W_emp +W_lg;
end