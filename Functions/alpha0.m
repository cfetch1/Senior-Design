function [alpha] = alpha0(V,h)
delta = delta0(V,h);
M0 = M0(V);
alpha = delta*(1-.96*(M0-1)^.25);
end

