close all;clear;clc;

% Greg Arnold 20220110
% Guide to Global Function Folder
addpath('..\Functions')

%% Initial Sizing 
AR = 1:30;
WS = 1:50;
CDmin = .035;
h = 14500; %m
ROC = 200;
V = 120;
Sg = 2000;
CL_to = 0.7;
CD_to = .028;
CD0 = 0.035;
S = 38.67;
eta = [.85,.35];

MTOW_i = 439;

PW_cruise1 = PW_cruise(AR, WS, V, CDmin, h)/(.75*eta(1));
PW_to = PW_takeoff(AR, WS, .7, CD0, S, Sg, 0, MTOW_i)/eta(2);

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


%% Updated Sizing form new Drag Polar
AR = 1:30;
WS = 1:50;
CDmin = .03135;
h = 14500;
ROC = 200;
V = 120;
Sg = 2000;
MTOW_new = 430;

[CL_to,CD_to] = DragSLF(96.8/1.69,435,0,38.63,0,1);
[~,CD_min] = DragSLF(90,0,0,38.63,0,1);
% CL_to = 0.92;
% CD_to = .048;
S = 38.63;
eta = [.85,.35];

PW_cruise2 = PW_cruise(AR, WS, V, CDmin, h)/(.75*eta(1));
PW_to = PW_takeoff(AR, WS, CL_to, CD_to, S, Sg, 0, MTOW_new)/eta(2);

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


%% Plot Sizing Results 
figure(1)
hold on
% Plot Initial AR vs Power 
plot(AR,PWminAR1.*MTOW_i,'linewidth',2)

% Label design AR point
scatter(15, 33,'pentagram','linewidth',5);

% Plot Updated AR on initial 
% plot(AR,PWminAR2.*MTOW_new,'b','linewidth',2)
ylabel('Power [bhp]')
xlabel('Aspect Ratio')
grid on
ylim([20 80])
% legend('Initial Sizing','Refined Sizing','location','best')




% figure(2)
% hold on 
% plot(WS,PWminWS)
% ylabel('Power Loading (hp/lb)')
% xlabel('Wing Loading')
% axis([min(WS),max(WS),0,.15])
% grid on


%% Plot Constrain Diagram 
figure(3)
hold on 

plot(WS,1.1*PW_cruise2(AR(15),:),'r')
plot(WS,1.1*PW_to(AR(15),:),'b')

xlabel('Wing Loading lb/ft^2')
ylabel('Power Loading (hp/lb)')
grid on

% figure
% hold on 
% for jj = 1:length(WS)
%     plot(AR,PW_cruise(:,jj),'b')
%     plot(AR,PW_to(:,jj),'r')
% end
% xlabel('Aspect Ratio')
% ylabel('Power Loading (hp/lb)')
