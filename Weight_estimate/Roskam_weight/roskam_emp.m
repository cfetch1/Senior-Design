function [W_emp] = roskam_emp(MTOW, S_h, A_h, t_rh, S_v, A_v, t_rv, sw_a)
% weight for empennage
% S_h = horizontal tail area in ft^2
% A_h = horizontal tail aspect ratio
% t_rh = horizontal tail maximum root thickness in ft
% S_v = vertical tail area in ft^2
% A_v = vertical tail aspect ratio
% t_rv = vertical tail maximum root thickness in ft
% sw_a = vertical tail quarter cord sweep angle

w_v = (1.68*(MTOW^0.567)*(S_v^1.24)*(A_v^0.482)) / (15.6*(t_rv^0.747)*(cos(sw_a)^0.882));
w_h = (3.184*(MTOW^0.887)*(S_h^0.101)*(A_h^0.138)) / (57.5*(t_rh^0.223)) ;
W_emp = w_h + w_v ;
end