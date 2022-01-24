function [RDT,C_flyaway,OPS,mat] = DAPCA_IV(W_e,V,Q,FTA,N_eng,Thrust_max,M_max,Temp_inlet,C_avi,Vc,W_to,Ce)

% W_e           empty weight [lbs]
% V             max velocity [kts]
% Q             production quantity
% FTA           number of flight test aircraft
% N_eng         Q*(engines per aircraft)
% Thrust_max    max engine thrust [lbs]
% M_max         max engine Mach number
% Temp_inlet    turbine inlet temperature [R]
% C_avi         avionics cost
% Vc            cruise velocity [kts]
% W_to          gross takeoff weight [lbs]
% Ce            cost per engine

HE = 4.86*W_e^0.777*V^0.894*Q^0.163;
HT = 5.99*W_e^0.777*V^0.696*Q^0.263;
HM = 7.37*W_e^0.82*V^0.484*Q^0.641;
HQ = 0.133;

CD = 45.54*W_e^0.630*V^1.3;
CF = 1243.03*W_e^0.325*V^0.822*FTA^1.21;
CM = 11.0*W_e^0.921*V^0.621*Q^0.799;
%C_eng = 1548*(0.043*Thrust_max+243.25*M_max+0.969*Temp_inlet-2228);
C_eng = 500000;

if C_eng < 0
    C_eng = 0;
end

RE = 59.10;
RT = 60.70;
RQ = 55.40;
RM = 50.10;

% inflation 1986 -> 2021 == 250%

RDT = 2.50*(HE*RE+HT+RT+HM*RM+HQ*RQ);

C_flyaway = 2.50*(CD+CF+CM+C_eng*N_eng+C_avi);

crew = 2;
if crew == 2
    OPS = 35*(Vc*W_to/1000)^0.3+84;
elseif crew == 3
    OPS = 47*(Vc*W_to/1000)^0.3+118;
end

OPS = OPS*2.50; % per block flight hour

Ca = C_flyaway - Ce;

mat = 3.3*Ca/10^6 +7.04+(58*Ce/10^6-13)*N_eng; % material repair per block flight hour 
    

end

