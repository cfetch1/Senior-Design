close all
clear all
clc

% Greg Arnold 20220110

cd('C:\Users\grega\Documents\GitHub\Senior-Design\Functions')

AR = 1:48;
WS = 1:50;
CDmin = .035;
h = 14500;
ROC = 200;
V = 120;
Sg = 2000;
CL_to = 0.92;
CD_to = .048;
S = 38.63;
eta = [.85,.35];

PW_cruise1 = PW_cruise(AR, WS, V, CDmin, h)/(.75*eta(1));
PW_to = PW_takeoff(AR, WS, .7, .035, S, Sg, 0, 430)/eta(2);

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



AR = 1:48;
WS = 1:50;
CDmin = .03135;
h = 14500;
ROC = 200;
V = 120;
Sg = 2000;

[CL_to,CD_to] = DragSLF(96.8/1.69,435,0,38.63,0,1);
[~,CD_min] = DragSLF(90,0,0,38.63,0,1);
% CL_to = 0.92;
% CD_to = .048;
S = 38.63;
eta = [.85,.35];

PW_cruise2 = PW_cruise(AR, WS, V, CDmin, h)/(.75*eta(1));
PW_to = PW_takeoff(AR, WS, CL_to, CD_to, S, Sg, 0, 430)/eta(2);

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



cd('C:\Users\grega\Documents\GitHub\Senior-Design\Run Scripts')

figure
% subplot(211)
hold on 
plot(AR,PWminAR1,'r','linewidth',2)
plot(AR,PWminAR2,'b','linewidth',2)
ylabel('Power Loading (hp/lb)')
xlabel('Aspect Ratio')
axis([min(AR),max(AR),0,.15])
grid on
ax=gca;
ax.XAxis.Exponent = 0;
ax.XTick = 0:5:1000;
ax.XAxis.MinorTick='on';
ax.XAxis.MinorTickValues = 0:1:1000;
ax.YAxis.Exponent = 0;
ax.YTick = 0:.025:30000;
ax.YAxis.MinorTick='on';
ax.YAxis.MinorTickValues = 0:.005:30000;
legend('Original Drag Estimate','Updated Drag Estimate','location','best')








% subplot(212)
% hold on 
% plot(WS,PWminWS)
% ylabel('Power Loading (hp/lb)')
% xlabel('Wing Loading')
% axis([min(WS),max(WS),0,.15])
% grid on



figure
hold on 
for ii = 10:30
    plot(WS,1.1*PW_cruise2(ii,:),'b')
    plot(WS,1.1*PW_to(ii,:),'r')
end
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
