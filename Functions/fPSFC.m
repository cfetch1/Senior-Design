function [PSFC] = fPSFC(PSFC,h)
sigma= sigma0(h);
PSFC = PSFC/sqrt(sigma);
end

