function [sigma] = sigma(h)
rho = density(h);
rho_SL = density(0);
sigma = rho/rho_SL;
end

