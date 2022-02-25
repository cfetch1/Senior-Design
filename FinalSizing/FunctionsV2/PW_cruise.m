function [PW] = PW_cruise(AR, WS, V, CDmin, h, pow)
% pow = max throttle at condition 
% eta = TR640(V,V);
eta = .8335;
rho = density(h);
sig = rho/.0024;
q = .5*rho*(V*1.69)^2;
%alpha = alpha0(V,h);
alpha = 1;
for i = 1:length(AR)
    e = 1.78*(1-0.045*AR(i)^0.68)-0.64;
    k = 1/(pi*AR(i)*e);

    for j = 1:length(WS)
        PW(i,j) =(((q*CDmin*(1/WS(j))+k*(1/q)*WS(j))*V*1.69)/(550*eta*alpha*pow))/(sig-(1-sig)/7.55);
    end
end
end