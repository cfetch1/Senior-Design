function [BHP] = f_Preq(V,W,h,S,ROC,pow)
[~,CD] = DragSLF(V,W,h,S,ROC,1);
rho = density(h);
sig = sigma0(h);
M0 = fM0(V);
alpha = 1;
% if M0>.1
%     alpha = alpha0(V,h);
% else
%     alpha= delta0(h);
% end
eta = TR640(V,120);
BHP = ((.5*rho*(V*1.69)^3*S*CD+W*ROC/60))/(550*eta*alpha*pow*(sig-(1-sig)/7.55));
end

