function [delta] = delta0(h)
[~,P_SL,~] = ISA_english(0);
[~,P_inf,~] = ISA_english(h);
delta = P_inf/P_SL;
end

