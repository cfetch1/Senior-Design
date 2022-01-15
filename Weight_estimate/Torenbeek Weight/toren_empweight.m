function [W_emp] = toren_empweight()
% Torenbeek empennage weight for low-speed
% light aircraft (max 250 kts EAS) - vertical and horizontal tail 

% w_emp = tail group weight in lb
% w_h= horizontal tail weight in lb
% w_v =vertical tail weight in lb
% s_h = horizontal tailplane surface area
% k_h = correction factor = 1.0, k_v = 1.0
% f = design hoop stress in fuselage skin ?? -- we don't have this
% lam_h = sweep angle for horizontal tail
% v_d = design dive speed in EAS knots
% for vertical tail, same parameters



w_h = s_h*k_h*f*(((s_h^0.2)*v_d)/(sqrt(cos(lam_h)))) ;
w_v = s_v*k_v*f*(((s_v^0.2)*v_d)/(sqrt(cos(lam_v)))) ;
W_emp = w_h + w_v ;

end