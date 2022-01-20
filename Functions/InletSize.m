function [A1,A2] = InletSize(V1,M2,h,PSFC,Bhp,f,T2)
[T,~,rho_inf] = ISA_english(h);
a1 = sqrt(1.4*296*T)/.3048;
rho1 = rho_inf/(1+.25*(V1/a1)^2);
rho2 = rho_inf/(1+.25*(M2)^2);
V2 = M2*sqrt(1.4*296*T2)/.3048;
A1 = Bhp*PSFC/(3600*f*rho1*V1);
A2 = A1*rho1*(V1/1.69)/(rho2*V2);
end

