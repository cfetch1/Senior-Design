function [CL,CD] = DragSLF2(V,W,h,S,ROC,FOS)
rho = density(h);
V = 1.69*V;
gamma = atan(ROC/(V*60));
CL = W/((.5*rho*V^2*S)*cos(gamma));
f = [0.0212   -0.0022    0.0286];
CD = (f(1)*(CL)^2 + f(2)*CL + f(3));
end

