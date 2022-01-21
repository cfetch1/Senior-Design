close all;clear;clc;
% Add local function floder to path
addpath('../Functions')

AR = 1:48;
WS = 1:50;
CDmin = .013;
h = 7000;
ROC = 200;
V = 120;
Sg = 3000;
CL_to = 0.92;
CD_to = .031;
S = 38.63;
eta = [.85,.35];

PW_cruise = PW_cruise(AR, WS, V, CDmin, h)/(.75*eta(1));
PW_to = PW_takeoff(AR, WS, CL_to, CD_to, S, Sg, 0, 430)/eta(2);

for ii = 1:length(AR)
    for jj = 1:length(WS)
        PWmin(ii,jj) = max([PW_cruise(ii,jj),PW_to(ii,jj)]);
    end
end

for ii = 1:length(AR)
        PWminAR(ii) = min(PWmin(ii,:));
end
for ii = 1:length(WS)
        PWminWS(ii) = min(PWmin(:,ii));
end


figure
% subplot(211)
hold on 
plot(AR,PWminAR)
ylabel('Power Loading (hp/lb)')
xlabel('Aspect Ratio')
axis([min(AR),max(AR),0,.15])
grid on

subplot(212)
hold on 
plot(WS,PWminWS)
ylabel('Power Loading (hp/lb)')
xlabel('Wing Loading')
axis([min(WS),max(WS),0,.15])
grid on



figure
hold on 
for ii = 15
    plot(WS,PW_cruise(ii,:),'b')
    plot(WS,PW_to(ii,:),'r')
end
xlabel('Wing Loading lb/ft^2')
ylabel('Power Loading (hp/lb)')
grid on

figure
hold on 
for jj = 1:length(WS)
    plot(AR,PW_cruise(:,jj),'b')
    plot(AR,PW_to(:,jj),'r')
end
xlabel('Aspect Ratio')
ylabel('Power Loading (hp/lb)')
