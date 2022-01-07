function [CLB,CDB] = FuselageLiftDrag(alpha,alphaB0,S,k,D,eta,CDC,Spx0,Cf,F,SA,SC,K,dCDS,Scab)

CLB = (alpha-alphaB0)*(.5*k*pi*D^2+eta*CDC*(alpha-alphaB0)*Spx0)/S;
CDiB = CLB*alpha;

CD0A = Cf*F*SA/S;
CD0B = Cf*SA/S;
CD0C = Cf*F*SC/S;
dCD0lambda = K*CD0C/100;
dCD0cab = dCDS*Scab/S;

CDB = CDiB+CD0A+CD0B+CD0C+dCD0lambda+dCD0cab;

end

