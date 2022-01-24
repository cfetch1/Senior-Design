function [BHP] = f_Preq(V,W,h,S,ROC,pow)
[~,CD] = DragSLF(V,W,h,S,ROC,1);
rho = density(h);
M0 = fM0(V);
if M0>.1
    alpha = alpha0(V,h);
else
    alpha= delta0(h);
end
eta = .85*sqrt(V/120);
BHP = .5*rho*(V*1.69)^3*S*CD/(550*eta*alpha*pow);
end

