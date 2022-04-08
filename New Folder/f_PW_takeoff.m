function [PW] = f_PW_takeoff(WS,Sg,CL_max)
rho = density(0);

for jj = 1:length(WS)
    V_lof = 1.1*sqrt(WS(jj)/(.5*rho*CL_max));
    CL_to = WS(jj)/((.5*rho*(V_lof)^2));
    PW(jj) = WS(jj)/(Sg*CL_to/1.21); % Roskam I pg 95
end
end

