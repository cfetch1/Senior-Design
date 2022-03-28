function [PW] = PW_takeoff(AR,WS,Sg,h,CL_to,f,Vp)
%V=V*1.69;

g = 32.2;
rho = density(h);
% V = sqrt(MTOW/(.5*rho*S));

mu =.04;
% ROC = 75/(.5*Sg/(60*V));
%alpha = alpha0(V/1.69,h);
eta = .35;
for i = 1:length(AR)
     for j = 1:length(WS)
%         %Vto = sqrt(2*WS(j)/(rho*CL_to));
%         Vto = 75;
%         q = .5*rho*(Vto/sqrt(2))^2;
%         CD_to = f(1)*CL_to^2+f(2)*CL_to+f(3);
%         %eta = TR640(Vto,Vp);
%         TW1 = (Vto^2)/(2*g*Sg) + q*CD_to/WS(j) + mu*(1-q*CL_to/WS(j));
% %       TW2 = ROC/(60*V) + (q/(WS(j)))*CD_to + (k/q)*(WS(j));
% %       TW = max([TW1,TW2]);
%         PW(i,j) = (TW1*Vto)/(550*eta);

PW(i,j) = (Sg/(WS(j)*CL_to/1.21)/550); % Roskam I pg 95
    end
end
end

