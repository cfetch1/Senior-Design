function [PW] = PW_climb(AR, WS, V, ROC, CDmin,h,Vc)
rho = density(h);
sig = rho/.0024;
q = .5*rho*(V*1.69)^2;
eta = TR640(V,Vc);
for i = 1:length(AR)
    e = 1.78*(1-0.045*AR(i)^0.68)-0.64;
    k = 1/(pi*AR(i)*e);
%     k=.0212;
    for j = 1:length(WS)
        TW = ROC/(60*1.69*V) + (q/(WS(j)))*CDmin + (k/q)*(WS(j));
        PW(i,j) = V*1.69*TW/((550*eta*.85)*(sig-(1-sig)/7.55));
    end
end
end

