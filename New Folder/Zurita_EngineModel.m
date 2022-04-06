% power(lines 50-54 on fcruise fn)
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
h = linspace(0,18000,1000);

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

%% Interpolating Empirical Engine data from Rotax 912

% Empirical Data
RPM = [ 3000 3500 4000 4500 5000 5500 ];
throttle = linspace(0,100,length(RPM));
Power = [ 32 42 51 60 68 73 ]*1.34;                 % hp
fuel_cons = [ 7.5 8 12.5 17 22 27 ]*.26417*6;       % lbs/hr

% Calculate PSFC from power and fuel consumption range
PSFC = fuel_cons./Power;
PSFC_cruise = (fuel_cons./(Power*(sigma-(1-sigma)/7.55)));                % This is divided by 2 to match Gregs model and account for differen fuel cons at altitude

% Interpolate Power and PSFC to throttle
throttle_Power = interp1(throttle,Power,linspace(0,100,100),'spline');
throttle_PSFC_sealevel = interp1(throttle,PSFC,linspace(0,100,100),'spline');
throttle_PSFC_cruise = interp1(throttle,PSFC_cruise,linspace(0,100,100),'spline');

% Assuming max throttle how does PSFC change with altitude?
PSFC_altitude = (fuel_cons(end)./P_max);                                  % This is divided by 2 to match Gregs model and account for differen fuel cons at altitude

%% Plotting
figure();
plot(h,P_max,'linewidth',4); grid on;
ylabel('Max Power [Hp]');
xlabel('Altitude [Ft]');
ylim([0,100]);

figure();
plot(h,PSFC_altitude,'linewidth',4); grid on;
ylabel('PSFC (Max Throttle) [lb/hp/hr]');
xlabel('Altitude [Ft]');

figure();
plot(linspace(0,100,100),throttle_PSFC_sealevel,'linewidth',4); grid on; hold on;
plot(linspace(0,100,100),throttle_PSFC_cruise,'linewidth',4); grid on; 
ylabel('PSFC [lb/hp/hr]');
xlabel('Throttle Setting [%]');

%% Drake Notes: as long as all consistent, check altitude vs PSFC plot cause its high make sure it works with gregs code
%% Include PSFC model at altitude and Sea level


%% Greg Validation
for ii = 1:length(P_max)

    rho = density(h(ii));

    % Calculate TSFC
    [TSFC] = fTSFC(h(ii),V);

    % Calculate drag on aircraft
    V_fps = V*1.688;
    CL = W/(.5*rho*V_fps^2*S);
    CD = f(1)*(CL)^2 + f(2)*CL + f(3);
    D = .5*rho*V_fps^2*S*CD;
    
    PSFC_greg(ii) = (TSFC*D)/P_max(ii);
end

% figure(); 
% plot(P_max,PSFC,'linewidth',2); grid on;
% xlabel('Max Power [hp]')
% ylabel('PSFC [lb/hp/hr]')

% figure(); 
% plot(linspace(0,100,length(PSFC_greg)),PSFC_greg,'linewidth',2); grid on;
% xlabel('Throttle Setting (%)')
% ylabel('PSFC [lb/hp/hr]')
% % 
% figure(); 
% plot(h,PSFC_greg,'linewidth',2); grid on;
% xlabel('Altitude [Ft]')
% ylabel('PSFC [lb/hp/hr]')

% Throttle vs PSFC












