function [A1,A2] = DuctSizing(h,V,PSFC,power,f,T2)
[T1,~,rho] = ISA_english(h);
A1 = PSFC*power/(f*rho*V*1.69)/3600;
A2 = A1*T1/T2;
end

