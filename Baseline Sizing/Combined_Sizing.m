close all;clear;clc;
% Greg Arnold 20220110
% Modified by Eddie Hsieh

% Guide to Global Function Folder
addpath('..\Functions')

%% Initial Sizing 
AR = 1:30;
WS = 1:50;
CD_min_i = .035;
h = 14500; %m
ROC = 200;
V = 120;
Sg = 1800;
CL_to = 0.7;
CD_to_i = .035+.018;

CD0 = 0.035;
S = 38.63;
eta = [.85,.35];

MTOW_i = 439;


PW_cruise1 = PW_cruise(AR, WS, V, CD_min_i, h)/(.75*eta(1));
PW_to = PW_takeoff(AR, WS, .7, CD_to_i, S, Sg, 0, MTOW_i)/eta(2);


% Create AR sweep data sets
for ii = 1:length(AR)
    for jj = 1:length(WS)
        PWmin(ii,jj) = max([PW_cruise1(ii,jj),PW_to(ii,jj)]);
    end
end

for ii = 1:length(AR)
        PWminAR1(ii) = min(PWmin(ii,:));
end
for ii = 1:length(WS)
        PWminWS(ii) = min(PWmin(:,ii));
end
% -------------------------------------------------------------------------

%% Updated Sizing form new Drag Polar
AR = 1:30;
WS = 1:50;
h = 14500;
ROC = 200;
V = 120;
Sg = 2000;
V_liftoff = 57.28; %kts
FOS = 1;
CL_max = 1.5;


% Updated MTOW 350 lbs
MTOW_new = 350;

[CL_to,CD_to] = DragSLF(V_liftoff,MTOW_new,0,S,0,FOS);
[~,CD_min] = DragSLF(V_liftoff,0,0,S,0,FOS);


% CL_to = 0.92;
% CD_to = .048;
S = 38.63;
eta = [.85,.35];

PW_cruise2 = PW_cruise(AR, WS, V, CD_min, h)/(.75*eta(1));
PW_to = PW_takeoff(AR, WS, CL_to, CD_to, S, Sg, 0, MTOW_new)/eta(2);
WS_land = ones(size(PW_to,1),1).*(WS_landing(0, Sg, CL_max));


% Create AR sweep data sets
for ii = 1:length(AR)
    for jj = 1:length(WS)
        PWmin(ii,jj) = max([PW_cruise2(ii,jj),PW_to(ii,jj)]);
    end
end

for ii = 1:length(AR)
        PWminAR2(ii) = min(PWmin(ii,:));
end

for ii = 1:length(WS)
        PWminWS(ii) = min(PWmin(:,ii));
end


PW_land = linspace(0, max(PW_cruise2(AR(15),:)), size(PW_to,1))';


%-------------------------------------------------------------------------
%% Plot Initial Sizing Results 
figure(3)
hold on
% Plot Initial AR vs Power 
plot(AR,PWminAR1.*MTOW_i,'--c','linewidth',2)

% Label design AR point
scatter(15, 35,'pentagram','linewidth',5);

% Plot Updated AR on initial 
% plot(AR,PWminAR2.*MTOW_new,'b','linewidth',2)
ylabel('Power [bhp]')
xlabel('Aspect Ratio')
set(gca,'FontSize',15)
grid on
ylim([20 80])
% legend('Initial Sizing','Refined Sizing','location','best')

%% Plot Updated AR vs Power
plot(AR,PW_cruise2(:,AR(15)).*MTOW_i,'b','linewidth',2);

xlabel('Aspect Ratio')
ylabel('Power Loading (hp/lb)')
title('Need new MTOW')

%% Plot Updated Constrain Diagram 
% openfig("Figures\initial_contrain.fig")
figure(2)
hold on
plot(WS,1.1*PW_cruise2(AR(15),:),'b','linewidth',2)

plot(WS,1.1*PW_to(AR(15),:),'r','linewidth',2)
plot(WS_land, PW_land ,'Color','#77AC30','linewidth',2)

hatchedline(WS, 1.1.*PW_cruise2(AR(15),:),'b', pi/90, .5, 0.5, 0.5);
hatchedline(WS, 1.1.*PW_to(AR(15),:),'r', pi/90, .5, 0.5, 0.5);

%   Add hatchline for vertical line
    ii = 1;
    while ii < 50
        plot([WS_land(1); WS_land(1)+0.25],...
            [ii*0.75*.25/length(WS_land); (ii-0.75)*0.75*.25/length(WS_land)],...
            'Color','#77AC30', 'LineWidth',2)
        ii = ii + 1;
    end 
xlabel('Wing Loading lb/ft^2')
ylabel('Power Loading (hp/lb)')
title('Updated Constrain')
grid on
set(gca,'FontSize',16)
xlim([7 13])
ylim([0.05 0.1])
