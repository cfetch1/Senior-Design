function [sigma] = fsigma0(h)
rho = density(h);
rho_SL = density(0);
sigma = rho/rho_SL;
end

