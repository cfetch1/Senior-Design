function [CL,CD] = DragSLF(V,W,h,S,f)
rho = density(h);
V = 1.69*V;
CL = W/((.5*rho*V^2*S));
% f = [0.0351   -0.0029    0.0210];
CD = f(1)*(CL)^2 + f(2)*CL + f(3);
end

