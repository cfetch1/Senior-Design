function [T] = f_Treq(V,W,h,S,ROC)
[~,CD] = DragSLF(V,W,h,S,ROC,1);
rho = density(h);
M0 = fM0(V);
if M0>.1
    alpha = alpha0(V,h);
else
    alpha= delta0(h);
end
T = .5*rho*(V*1.69)^2*S*CD/(alpha);
end

