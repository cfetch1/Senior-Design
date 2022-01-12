function [alpha] = alpha(V,h)
delta = delta(V,h);
M0 = M0(V);
alpha = delta*(1-.96*(M0-1)^.25);
end

