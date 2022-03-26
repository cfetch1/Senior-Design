function [PW] = f_PW_takeoff(WS,Sg,V_lof)
rho = density(0);
for jj = 1:length(WS)
    CL_to = WS(jj)/((.5*rho*(V_lof*1.69)^2));
    PW(jj) = (Sg/(WS(jj)*CL_to/1.21)/550); % Roskam I pg 95
end
end

