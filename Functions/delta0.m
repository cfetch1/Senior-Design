function [delta] = delta0(V,h)
[~,P_SL,~] = ISA_english(0);
[~,P_inf,~] = ISA_english(h);
M0 = fM0(V);
delta = (P_inf/P_SL)*(1+.5*(1.4-1)*M0^2);
end

