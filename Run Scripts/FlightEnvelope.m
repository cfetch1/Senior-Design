close all
clc; clear; %close all;

% FlightEnvelope.m
%
% Script that uses our drag polar and engine power model to sweep velocity
% and altitude to generate a flight envelope. Finds intersections between
% available and required power using a nice script Eddie found.
%
% - Christian




% You will need this. Change it.
% addpath('C:\Users\fetch\Documents\GitHub\Senior-Design\Functions')
addpath('C:\Users\grega\Documents\GitHub\Senior-Design\Functions');

% Altitude and velocity range
h = 0:500:18000;
V = 10:.5:200;
V0 = 10;

% Aircraft parameters
W = 640;
S = 26.8;
FOS = 1;
BHP0 = 60;
ROC = 500;
throttle = 1;
Vc = 140;
CLmax = 1.3;
f = [0.0351   -0.0029    0.0210];


for jj = 1:length(h)

    % Calculate local density
    rho = density(h(jj));

    for ii = 1:length(V)

        % Prop efficiency?
        eta = TR640(V(ii),Vc);

        % Convert knots to ft/s
        V_fps = V(ii)*1.69;

        % Get drag polar
        [CL,CD] = DragSLF(V(ii),W,h(jj),S,0);
        
        if CL>CLmax
            index = ii;
        end

        % Get required power in hp
        P_req(ii) = .5*rho*V_fps^3*S*CD/550;

        % Density ratio
        sig = sigma0(h(jj));

        % Get engine power
        P_eng(ii) = throttle*BHP0*(sig-(1-sig)/7.55);
        
        % Get available engine power
        P_avail(ii) = P_eng(ii)*eta;  

%         % Get drag polar for climb
%         [CLc,CDc] = DragSLF2(V(ii),W,h(jj),S,ROC,FOS);
% 
%         % Get power required for climb
%         Pc_req(ii) = (.5*rho*V_fps^3*S*CD + W*ROC/60)/(550);
%  
    end


% dy = linspace(0,100,100);
% vs = zeros(100,1);
% vs(:,jj) = round(sqrt(2*W/(rho*S*CLmax))/1.69);

% Old plotting stuff for required power

% hold on; grid on;
% plot(V,P_req,'r','linewidth',2,'displayname','Power Required')
% plot(V,P_avail,'b','linewidth',2,'displayname','Power Available')
% % plot(V,P_eng,'k--','linewidth',2,'displayname','Engine Output')
% % plot(vs,dy,'k','linewidth',2,'displayname','Stall Speed')
% xlabel('Airspeed [kts]')
% ylabel('Power [Hp]')
% % legend('location','best')

% Get intersections between P_req and P_avail to find velocity bounds
[v_lim(jj,:)] = intersections(V,P_req,V,P_avail);

if v_lim(jj,1)<V(index)    
    v_lim(jj,1) = V(index);
    clear index
end

clear P_req P_avail

end

% Plot height-velocity flight envelope
figure();
hold on; grid on;
plot(v_lim(:,1),h,'linewidth',3,'color','k');
plot(v_lim(:,2),h,'linewidth',3,'color','k');
title('Flight Envelope');
xlabel('Velocity (Knots)');
ylabel('Altitude (ft)');
