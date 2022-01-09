function [CLB,CDB,CD0,CDiB] = FuselageLiftDrag(alpha,alphaB0,S,k,D,eta,CDC,Spx0,Cf,F,SA,SC,K,dCDS_cab,Scab)
%format long
alpha = alpha*pi/180;
alphaB0 = alphaB0*pi/180;
CLB = (alpha-alphaB0)*(.5*k*pi*D^2+eta*CDC*(alpha-alphaB0)*Spx0)/S;
CDiB = CLB*(alpha-alphaB0);

CD0A = Cf*F*SA/S;
CD0B = Cf*SA/S;
CD0C = Cf*F*SC/S;
dCD0lambda = K*CD0C/100;
dCD0cab = dCDS_cab*Scab/S;

CDB = CDiB+CD0A+CD0B+CD0C+dCD0lambda+dCD0cab;
CD0 = CDB-CDiB;
end

