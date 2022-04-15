clear;
clc;
close all;
% Aircraft Params
W = 947;
V = 160;
S = 44.4;
f = [0.0351   -0.0029    0.0210];
P0 = 100;

% Altitude Sweep
h = linspace(0,18000,10);

%% Calculate max power for range of altitudes
for ii = 1:length(h)
    % Calculate Density
    rho = density(h(ii));

    % Calculate density ratio
    sigma = sigma0(h(ii));
    
    % Correct power for atmospheric denisty
    P_in = P0;
    P_max(ii) = P0*(sigma-(1-sigma)/7.55);
end

%% Interpolating Empirical Engine data from the Rotax 912 UL 100 hp

% Empirical Data
RPM = [ 3000 3500 4000 4500 5000 5500 ];
throttle = linspace(0,100,length(RPM));
Power = [ 32 42 51 60 68 73 ]*1.34;                 % hp
fuel_cons = [ 7.5 8 12.5 17 22 27 ]*.26417*6;       % lbs/hr

% Calculate PSFC from power and fuel consumption range
PSFC = fuel_cons./Power;
% PSFC_cruise = (fuel_cons./(Power*(sigma-(1-sigma)/7.55)));                

% Interpolate Power and PSFC to throttle
throttle_Power = interp1(throttle,Power,linspace(0,100,100),'spline');
throttle_PSFC_sealevel = interp1(throttle,PSFC,linspace(0,100,100),'spline');
% throttle_PSFC_cruise = interp1(throttle,PSFC_cruise,linspace(0,100,100),'spline');

% Assuming max throttle how does PSFC change with altitude?
PSFC_max = throttle_PSFC_sealevel(end);                    % (fuel_cons(end)./P_max);       
PSFC_ingress = throttle_PSFC_sealevel(84);
PSFC_egress = throttle_PSFC_sealevel(41);
PSFC_loiter = throttle_PSFC_sealevel(34);

%% Plotting
figure();
plot(P_max,h,'linewidth',4); grid on;
% hatchedline(P_max,h); grid on;
xlabel('Max Power [hp]');
ylabel('Altitude [ft]');
xlim([0,100]);

figure();
% plot(PSFC_max,h); hold on;
xline(PSFC_max,'linewidth',4); grid on;
xline(PSFC_ingress,'linewidth',4); 
xline(PSFC_egress,'linewidth',4); 
xline(PSFC_loiter,'linewidth',4); 
xlabel('PSFC [lb/hp/hr]');
ylabel('Altitude [ft]');
xlim([0,.5]);
ylim([0,18000]);

figure();
plot(linspace(0,100,100),throttle_PSFC_sealevel,'linewidth',4); grid on; hold on;
% plot(linspace(0,100,100),throttle_PSFC_cruise,'linewidth',4); grid on; 
ylabel('PSFC [lb/hp/hr]');
xlabel('Throttle Setting [%]');


%% Greg Validation

% % Generate throttle percentages
% throttle_greg = linspace(0,100,100);
% 
% % Generate power linspace (0-100 hp)
% % Power_greg = linspace(0,100,length(throttle_greg));
% 
% V_fps1 = linspace(100*1.688,220*1.688,length(throttle_greg));
% % Calculate TSFC (sea level, 160 knots)
% for i = 1:length(V_fps1)
%     TSFC(i) = fTSFC(0,V_fps1(i)./1.688);
% end
% 
% Calculate drag (sea level, 160 knots)
V = 87;
V_fps1 = V*1.688;
% TSFC = fTSFC(0,V_fps1./1.688);
% D = (Power_greg)./V_fps1;
rho = density(18000);
CL = W./(.5*rho.*V_fps1.^2*S);
CD = f(1).*(CL).^2 + f(2).*CL + f(3);
D = .5*rho.*V_fps1.^2*S.*CD;
Power_greg = D.*V_fps1/550;
% % 
% % Calculate PSFC
% % PSFC_greg = (TSFC.*D)./(Power_greg);
% PSFC_greg = TSFC./(V_fps1/550);
% 
% % Jank shit to make drag power match max power
% V_fps = linspace(200*1.688,250*1.688,length(P_max));
% 
% for ii = 1:length(P_max)
% 
%     % Calculate density
%     rho = density(h(ii));
% 
%     % Calculate TSFC
%     TSFC = fTSFC(h(ii),V);
% 
%     % Calculate drag on aircraft
%     CL = W/(.5*rho*V_fps(ii)^2*S);
%     CD = f(1)*(CL)^2 + f(2)*CL + f(3);
%     D(ii) = .5*rho*V_fps(ii)^2*S*CD;
%     Power_greg2 = D.*V_fps(ii)/550; % Check Var. This is so fucking jank
%     
%     
%     PSFC_greg_alt(ii) = (TSFC*D(ii))/P_max(ii);
% end



% figure(); 
% plot(P_max,PSFC,'linewidth',2); grid on;
% xlabel('Max Power [hp]')
% ylabel('PSFC [lb/hp/hr]')

% figure(); 
% plot(throttle_greg,PSFC_greg,'linewidth',2); grid on;
% xlabel('Throttle Setting (%)')
% ylabel('PSFC [lb/hp/hr]')

% figure(); 
% plot(h,PSFC_greg_alt,'linewidth',2); grid on;
% xlabel('Altitude [Ft]')
% ylabel('PSFC [lb/hp/hr]')

% Throttle vs PSFC












