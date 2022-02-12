function [WS] = WS_landing(h,dg,CLmax)
% Roskam pg 125
rho = density(h);
Vs = @(WS) sqrt(2*WS/(rho*CLmax));
SL = @(WS) .5136*(Vs(WS)/1.69)^2;
WS = fzero(@(WS) SL(WS)-dg,20);
end
