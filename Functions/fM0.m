function [M0] = fM0(V)
% inputs V as kts
M0 = V*1.69*.3048/sqrt(1.4*296*288.15);
end

