function [CL,CD] = CLalpha(alpha)
fL =  [0.1663    0.1985];
CL = fL(1)*alpha+fL(2);
fD = [0.0212   -0.0022    0.0282];
CD = (fD(1)*(CL)^2 + fD(2)*CL + fD(3));
end
