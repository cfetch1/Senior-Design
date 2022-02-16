clc;clear;close all;

% Trim Condition setup
CL_trim = [1.48	1.2023	0.9205	0.7273	0.5891	0.4869	0.4091	0.3486...
    0.3006	0.2618	0.2301	0.2039	0.1818	0.1632	0.1473	0.1336	0.1217...
    0.1114	0.1023	0.0943	0.0872
];

% Speed in [ft/s]
V = [102	118.1	135.0	151.9	168.8	185.7	202.5	219.4	236.3...
    253.2	270.0	286.9	303.8	320.7	337.6	354.4	371.3	388.2...
    405.1	422.0	438.8];

% mach calculation
T = 454.4784; % R
R = 1716.49;
rho = 0.0013546;
mu = 3.6E-7;
M = V./sqrt(1.4*R*T);

% Section Geometry for Re Calc

% Mean Chord [ft] 
MAC = [5.747 4.981 4.2144 3.4482];

% Ref Area [ft2]
S = [6.021 5.218 4.415 3.612];

S_ref = sum(2.*S);

% Fuse Diameter [ft]
F_d = 1.5;

% Area without fuselage [ft^2]
S_e = S_ref - (F_d*5.747);

% Re by section and speed
for i = 1:length(V)
    Re(:,i) = (rho*V(i)*MAC)./mu;
end


% Do calc, sweept by airspeed
for i = 1:size(Re,2)
    disp(['Speed = ', num2str(V(i)),'[ft/s]'])
    top = 0;
    bottom = 0;

    for j = 1:size(Re,1) 
        % Run Xfoil
        RSUT = xfoilCl('NACA2412', CL_trim(i), Re(j,i), M(i),'panels n 400');
        disp(['Section = ', num2str(j),' Cd_p_i = ',... 
              num2str(RSUT.CD)])        
        try
            AOA(j) = RSUT.alpha;
        catch
%             AOA(j) = AOA(j-1);
            continue
        end
        % Sum Equations
        top = top + RSUT.CD.*S(j);
        bottom = bottom + S(j);
    end
    
    alpha(i) = mean(AOA);
    % Total C_d parasitic
    try
        Cd_p(i) = 2*(top./bottom)*(S_e/S_ref);
        disp([...'Total Cd_p = ',
             num2str(Cd_p(i))])

        
        disp(['Mean AOA = ',...
             num2str(alpha(i))])
        
        disp(' ')
    catch
        disp(' ')
        continue
    end
end







