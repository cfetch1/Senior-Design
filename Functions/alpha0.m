function [alpha] = alpha0(V,h)
delta = delta0(h);
M0 = fM0(V);
if M0>.1
alpha = delta*(1-.96*(M0-.1)^.25);
else
    alpha = delta;
end
end

