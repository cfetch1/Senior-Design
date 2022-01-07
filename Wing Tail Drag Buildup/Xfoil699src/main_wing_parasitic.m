clc;clear;close all;

% Trim Condition setup
alpha = [9.8327	6.65967	4.62528	3.23895	2.25047...
        1.52047	0.96596	0.53461	0.19257	-0.08331];

V = [101.28	118.16	135.04	151.92	168.8...
     185.68	202.56	219.44	236.32	253.2];

% mach calculation
T = 493.7153; % R
R = 1716.49;
rho = 0.0019272;
mu = 3.6E-7;
M = V./sqrt(1.4*R*T);

% Section Geometry for Re Calc

% Mean Chord [ft] 
MAC = [2.00713 1.73938 1.47163 1.20388];

% Area [ft2]
S = [6.021 5.218 4.415 3.612];

% Re by section and speed
for i = 1:length(V)
    Re(:,i) = (rho*V(i)*MAC)./mu;
end


% xfoil('NACA2412',9.8327,1089508,0.093)