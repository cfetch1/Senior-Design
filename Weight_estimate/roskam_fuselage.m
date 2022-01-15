function [W_fus] = roskam_fuselage(MTOW, L_f, pmax, Npax)
% for high wing cessna
%L_f = length of fuselage
%pmax = max perimeter of fuselage cross section
%Npax = number of passengers (approximate to equal our inside weight)

W_fus = 14.86*(MTOW^0.144)*((L_f/pmax)^0.778)*(L_f^0.383)*(Npax^0.455) ;
end