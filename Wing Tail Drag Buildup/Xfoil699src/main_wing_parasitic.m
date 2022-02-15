clc;clear;close all;

% Trim Condition setup
CL_trim = [1.0080	0.7401  0.5670	0.4480	0.3629	0.3	0.2520	0.2147	0.1851	0.1613	0.1417	0.1256	0.1120	0.1005	0.0907	0.0823	0.0750	0.0686	0.0630	0.0581	0.0537
];

V = [101.3	118.1	135.0	151.9	168.8	185.7	202.5	219.4	236.3	253.2	270.0	286.9	303.8	320.7	337.6	354.4	371.3	388.2	405.1	422.0	438.8
];

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
S = 2.*[49.5414388 42.9382124 36.32981376 29.72486328];


% Fuse Diameter [ft]
F_d = 5;

% Area without fuselage [ft^2]
S_e = 2.*sum(S) - (1.5*2.141);

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
            AOA(j) = AOA(j-1);
            continue
        end
        % Sum Equations
        top = top + RSUT.CD.*S(j);
        bottom = bottom + S(j);
    end

    % Total C_d parasitic
    try
        Cd_p(i) = 2*(top./bottom)*(S_e/sum(S));
        disp([...'Total Cd_p = ',
             num2str(Cd_p(i))])

        alpha(i) = mean(AOA(j));
        disp(['Mean AOA = ',...
             num2str(alpha(i))])
        
        disp(' ')
    catch
        disp(' ')
        continue
    end
end







