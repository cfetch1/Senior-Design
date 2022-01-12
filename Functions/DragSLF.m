function [CL,CD] = DragSLF(V,W,h,S,ROC,FOS)
rho = density(h);
V = 1.69*V;
gamma = atan(ROC/(V*60));
CL = W/(.5*rho*V^2*S);
CD = FOS*(0.0242*(CL*cos(gamma))^2 - 0.0026*CL*cos(gamma) + 0.0128);
end

