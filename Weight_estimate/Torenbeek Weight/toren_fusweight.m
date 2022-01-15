function [W_fus] = toren_fusweight()
% Torenbeek fuselage weight aka "body group" 

% W_fus = in lbs
% MTOW in lbs
% k_wf = 0.021 = constant
% v_d = dive speed in EAS knots
% lt =
% bf =
% hf =
% S_g = in ft^2

W_fus = k_wf*sqrt(v_d*(lt/(bf+hf)))*(S_g^1.2) ;

end