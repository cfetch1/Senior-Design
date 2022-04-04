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


% Altitude and velocity range
h = 0:200:18000;
V = 10:.5:200;
V0 = 10;

% Aircraft parameters
W = 920;
S = 42.6;
FOS = 1;
BHP0 = 100;
ROC = 500;
throttle = 1;
Vc = 160;
CLmax = 1.3;
f = [0.0332    0.0040    0.0223];


for jj = 1:length(h)

    % Calculate local density
    rho = density(h(jj));

    for ii = 1:length(V)

        % Prop efficiency?
        eta = TR640(V(ii),Vc);

        % Convert knots to ft/s
        V_fps = V(ii)*1.69;

        % Get drag polar
        [CL,CD] = DragSLF(V(ii),W,h(jj),S,f);
                
        if CL>CLmax
            index = ii;
        end
        
        E(ii) = CL/CD;
        
        if E(ii) == max(E)
            index2 = ii;
        end
        
        E32(ii) = CL^1.5/CD;
        
        if E32(ii) == max(E32)
            index3 = ii;
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

% if v_lim(jj,1)<V(index)    
%     vs(jj) = V(index);
%     clear index
% end
vs(jj) = V(index);
vr(jj) = V(index2);
ve(jj) = V(index3);
vi(jj) = 160;

clear P_req P_avail clear index index2 index3 E E32

end

% Plot height-velocity flight envelope
figure();
hold on; grid on;
plot(vs,h,'k--','linewidth',2);
plot(vr,h,'r','linewidth',2);
plot(ve,h,'b','linewidth',2);
plot(vi,h,'g','linewidth',2);
title('Flight Envelope');
xlabel('Velocity (Knots)');
ylabel('Altitude (ft)');
legend('Stall Speed','Max Range Speed (Egress)','Max Endurance Speed (Loiter')
plot(v_lim(:,1),h,'linewidth',3,'color','k');
plot(v_lim(:,2),h,'linewidth',3,'color','k');