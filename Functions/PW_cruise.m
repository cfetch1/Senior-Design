function [PW] = PW_cruise(AR, WS, V, CDmin, h)

rho = density(h);

q = .5*rho*(V*1.69)^2;


for i = 1:length(AR)
    e = 1.78*(1-0.045*AR(i)^0.68)-0.64;
    k = 1/(pi*AR(i)*e);
    for j = 1:length(WS)
        TW = q*CDmin*(1/WS(j))+k*(1/q)*WS(j);
        PW(i,j) = BHP_SL(TW,h)*V*1.69/550;
    end
end
end