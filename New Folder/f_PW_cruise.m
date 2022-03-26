function [PW] = f_PW_cruise(AR, WS, V, CDmin, h, throttle)
eta = .8335;
rho = density(h);
sig = (rho/.0024);
q = .5*rho*(V*1.69)^2;
e = 1.78*(1-0.045*AR^0.68)-0.64;
k = 1/(pi*AR*e);
for jj = 1:length(WS)
    PW(jj) =(((q*CDmin*(1/WS(jj))+k*(1/q)*WS(jj))*V*1.69)/(550*eta*throttle))/(sig-(1-sig)/7.55);
end
end