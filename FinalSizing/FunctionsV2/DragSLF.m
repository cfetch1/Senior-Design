function [CL,CD] = DragSLF(V,W,h,S,ROC)
%S = 38.63;
rho = density(h);
V = 1.69*V;
gamma = atan(ROC/(V*60));
CL = W/((.5*rho*V^2*S)*cos(gamma));
%f = [0.0212   -0.0022    0.0286];
f = [0.0351   -0.0029    0.0210];
CD = f(1)*(CL)^2 + f(2)*CL + f(3);
end

