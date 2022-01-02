function [PW] = PW_turn(WS, AR, CDmin, V, h, n, eta)

rho = density(h);
rho_SL = density(0);
q = .5*rho*(V*1.168781)^2;
sigma = rho/rho_SL;

for i = 1:length(AR)
    e = 1.78*(1-0.045*AR(i)^0.68)-0.64;
    k = 1/(pi*AR(i)*e);
    for j = 1:length(WS)
        TW = q*(CDmin/WS(j) + k*((n/q)^2)*WS(j));
        PW(i,j) = TW/(eta*sigma^.8);
    end
end
end

