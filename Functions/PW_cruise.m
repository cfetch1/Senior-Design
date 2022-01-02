function [PW] = PW_cruise(AR, WS, V, CDmin, eta)

rho = density(h);
rho_SL = density(0);
q = .5*rho*(V*1.168781)^2;
sigma = rho/rho_SL;

for i = 1:length(AR)
    e = 1.78*(1-0.045*AR(i)^0.68)-0.64;
    k = 1/(pi*AR(i)*e);
    for j = 1:length(WS)
        TW(j) = q*CDmin*(1/WS(j))+k*(1/q)*WS(j);
        PW(i,j) = TW/(eta*sigma^.8);
    end
end
end