clc;clear;close all;

% Trim Condition setup
alpha = [9.8327	6.65967	4.62528	3.22 2.25047...
        1.52047	0.9655	0.53461	0.193 -0.08325];

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

% Area without fuselage
S_e = sum(S) - 1.5*2.141;

% Re by section and speed
for i = 1:length(V)
    Re(:,i) = (rho*V(i)*MAC)./mu;
end


for i = 1:size(Re,2)
    disp(['Speed = ', num2str(V(i)),'[ft/s]'])
    top = 0;
    bottom = 0;
    
    for j = 1:size(Re,1) 
        % Run Xfoil
        RSUT = xfoil('NACA2412', alpha(i), Re(j,i), M(i),'panels n 400');
        disp(['Section = ', num2str(j),' Cd_p_i = ', num2str(RSUT.CDp)])        
        
        % Sum Equations
        top = top + RSUT.CDp.*S(j);
        bottom = bottom + S(j);
    end

    % Total C_d parasitic
    Cd_p = 2*(top./bottom)*(S_e/sum(S));
    disp(['Total Cd_p = ', num2str(Cd_p)])
    disp(' ')
end






