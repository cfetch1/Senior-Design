clc;clear;close all;

% Trim Condition setup
CL_trim = [0.0623	0.0369	0.0263	0.0163	0.0093	0.0043	0.0004	-0.0026...
        -0.0049	-0.0068	-0.0083	-0.0095	-0.0106	-0.0115	-0.0122	-0.0129...
    	-0.0134	-0.0139	-0.0143	-0.0147	-0.0150]./0.1026;

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
MAC = mean([1.036 .928]);

% Area [ft2]
S = 5.8736;

% Ref Area [ft2]
S_ref = sum(2.*[6.021 5.218 4.415 3.612]);

% Area without fuselage
S_e = sum(2.*S);

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
        RSUT = xfoilCl('NACA0012', CL_trim(i), Re(j,i), M(i),'panels n 400');
        disp(['Section = ', num2str(j),' Cd_p_i = ', num2str(RSUT.CD)])        
        
        try
            AOA(j) = RSUT.alpha;

        catch
            continue
        end

        % Sum Equations
        top = top + RSUT.CD.*S(j);
        bottom = bottom + S(j);
    end

    % Total C_d parasitic
    try
        Cd_p(i) = 2*(top./bottom)*(sum(S)./S_ref);
        disp(['Total Cd_p = ', num2str(Cd_p(i))])

        alpha(i) = mean(AOA(j));
        disp(['Mean AOA = ',...
             num2str(alpha(i))])
        
        disp(' ')
    catch
        disp(' ')
        continue
    end
end
