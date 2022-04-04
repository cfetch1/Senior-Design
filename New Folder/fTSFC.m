function [SFC] = fTSFC(h,V)
[T,~,~]=ISA_english(h);
M = V*1.69*.3048/sqrt(1.4*296*T);
SFC = (.18+(.8-.18)*M/.8);
end

