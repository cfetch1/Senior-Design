function [PSFC] = fPSFC(h,V)
[T,~,~]=ISA_english(h);
M = V*1.69*.3048/sqrt(1.4*296*T);
PSFC = (.18+.8*M);
end
