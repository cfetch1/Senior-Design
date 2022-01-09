function [CD] = DuctDrag(h,A1,V1,V2,S)
% C = 4.9*10^-7;
[~,~,rho_inf] = ISA_english(h);
% [~,~,rho_SL] = ISA_english(0);
% sigma=rho_inf/rho_SL;
% Pshaft=Pprop/eta;
% CD = C*Pshaft*(T/1.8)^2/(sigma*V*1.69*S);
mdot = rho_inf*A1*V1*1.69;
dV = (V1-V2)*1.69;
q=.5*rho_inf*(V1*1.69)^2;
CD=mdot*dV/(q*S);

end

