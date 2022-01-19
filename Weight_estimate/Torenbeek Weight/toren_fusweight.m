function [W_fus] = toren_fusweight(k_wf, v_d, lt, bf, hf, S_g)
% Torenbeek fuselage weight aka "body group" 

% W_fus = in lbs
% MTOW in lbs
% k_wf = 0.021 = constant
% v_d = dive speed in EAS knots
% lt = distance between quarter chord points of wing root and horizontal
     % tail root
% bf = maximum width of fuselage
% hf = maximum depth of fuselage
% S_g = gross shell area in ft^2

W_fus = k_wf*sqrt(v_d*(lt/(bf+hf)))*(S_g^1.2) ;

end