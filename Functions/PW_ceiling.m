function [PW] = PW_ceiling(AR, WS, CDmin, h)
rho = density(h);
Vv = 1.67;
for i = 1:length(AR)
    e = 1.78*(1-0.045*AR(i)^0.68)-0.64;
    k = 1/(pi*AR(i)*e);
    for j = 1:length(WS)
        TW = Vv/(sqrt((2/rho)*WS(j)*sqrt(k/(3*CDmin)))) + 4*sqrt(k*CDmin/3);
        PW(i,j) = BHP_SL(TW,h);
    end
end
end

