function [CD] = DuctDrag(h,Pprop,eta,V,S)
C = 4.9*10^-7;
[T,~,rho_inf] = ISA_english(h);
[~,~,rho_SL] = ISA_english(0);
sigma=rho_inf/rho_SL;
Pshaft=Pprop/eta;
CD = C*Pshaft*(T/1.8)^2/(sigma*V*1.69*S);
end

