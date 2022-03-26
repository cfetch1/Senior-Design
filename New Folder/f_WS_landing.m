function [WS] = f_WS_landing(dg,CLmax,f)
CD = polyval(f,CLmax);
rho = density(0);
Vbr = @(WS) sqrt(2*WS/(rho*CLmax));
mu = .5;
LS =@(WS) 0.25 * rho * Vbr(WS)^2 * CLmax;
DS = @(WS)0.25 * rho * Vbr(WS) ^ 2 * CD;
WS = fzero( @(WS) dg - ( -Vbr(WS) ^ 2 * WS/ (2 * 32.174 * (DS(WS) - mu * (WS - LS(WS)))) ), 50 );
end
