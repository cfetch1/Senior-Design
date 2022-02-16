clc;clear;close all;

% Trim Condition setup
alpha = zeros(21);

% Speed in [ft/s]
V = [101.3	118.1	135.0	151.9	168.8	185.7	202.5	219.4	236.3...
    253.2	270.0	286.9	303.8	320.7	337.6	354.4	371.3	388.2...
    405.1	422.0	438.8];

% mach calculation
T = 493.7153; % R
R = 1716.49;
rho = 0.0019272;
mu = 3.6E-7;
M = V./sqrt(1.4*R*T);

% Section Geometry for Re Calc

% Mean Chord [ft] 
MAC = [1.75 1.73];

% Area [ft2]
S = [4.375 1.66];

% Ref Area [ft2]
S_ref = sum(2.*[6.021 5.218 4.415 3.612]);

% Area without fuselage
S_e = sum(S);

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
        try
            RSUT = xfoil('NACA0012', alpha(i), Re(j,i), M(i),'panels n 400');
            disp(['Section = ', num2str(j),' Cd_p_i = ', num2str(RSUT.CD)])        
        catch
            continue
        end
        % Sum Equations
        top = top + RSUT.CD.*S(j);
        bottom = bottom + S(j);
    end

    % Total C_d parasitic
    Cd_p(i) = 2*(top./bottom)*(S_e/sum(S)).*(sum(S)./S_ref);
    disp(['Total Cd_p = ', num2str(Cd_p)])
    disp(' ')
end

