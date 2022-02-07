function [WS] = WS_landing(h,dg,CLmax)
% Roskam pg 125
rho = density(h);
Va = @(WS) 1.3*sqrt(2*WS/(rho*CLmax));
SL = @(WS) .5136*(Va(WS)/1.69)^2;
WS = fzero(@(WS) SL(WS)-dg,10);
end
