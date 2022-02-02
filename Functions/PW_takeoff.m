function [PW] = PW_takeoff(AR, WS, CL_to, CD_to,  Sg, h,V)
V=V*1.69;

    g = 32.2;
rho = density(h);
% V = sqrt(MTOW/(.5*rho*S));
q = .25*rho*(V)^2;
mu =.04;
% ROC = 75/(.5*Sg/(60*V));
%alpha = alpha0(V/1.69,h);
eta = TR640(V,120*1.69);

for i = 1:length(AR)
     for j = 1:length(WS)

        TW1 = (V^2)/(2*g*Sg) + q*CD_to/WS(j) + mu*(1-q*CL_to/WS(j));
%          TW2 = ROC/(60*V) + (q/(WS(j)))*CD_to + (k/q)*(WS(j));
%          TW = max([TW1,TW2]);
        PW(i,j) = (TW1*V)/(550*eta);
    end
end
end

