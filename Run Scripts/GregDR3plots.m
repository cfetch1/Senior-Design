close all
clear all
clc
% 
addpath('C:\Users\grega\Documents\GitHub\Senior-Design\Functions')

err = 1000;
MTOW = 400;
S = 38.63;
Wrs = ones(8,1);
Wf = 50;
P2 = 40;
dX1 = MTOW;
dX2 = .95*MTOW;
dX3 = .9*MTOW;
dX4 = MTOW;
dX5 = .9*MTOW;
res = Wf*.25;
c=1;
ROC=160;
while err>1
X1 = MTOW;
P1 = P2;
k = .65*sqrt(MTOW/440) +.35*sqrt(S/38.63);
[~,CD0] = DragSLF(1,0,0,S,0,k);

[CL1,CD1] = DragSLF(100,dX1,0,S,ROC,k);
E1 = CL1/CD1;

[CL2,CD2] = DragSLF(120,dX2,14000,S,0,k);
E2 = CL2/CD2;

[CL3,CD3] = DragSLF(80,dX3,2000,S,0,k);
E3 = CL3/CD3;



Vs = sqrt(2*(dX5)/(.0024*S*1.5))/1.69;
[CL4,CD4] = DragSLF(1.5*Vs,dX4,0,S,0,k);
E4 = CL4/CD4;


WS=5:.5:30;
[MTOW,We,Wf,EWF,Wrs]=RangeSizing(50,X1,550,1,[E1,E2,E3],[.34,.36,.29],[100,120,80],ROC,14000,[.62,.83],1.1,res);
X2 = MTOW;

X =categorical({'Start-Up','Taxi','Takeoff','Climb','Cruise','Loiter','Descent','Shut-Down','Reserves'});
X = reordercats(X,{'Start-Up','Taxi','Takeoff','Climb','Cruise','Loiter','Descent','Shut-Down','Reserves'});
for ii=1:length(Wrs)
    y(ii) = (1-(Wrs(ii)))/(prod(Wrs(1:ii)));
end
yy = (Wf-res)/sum(y);
y = y*yy;
y(end+1) = 12;

% dX1 = MTOW;
% dX3 = MTOW-sum(y(1:3));

PW_cruise2 = 1.05*PW_cruise(15, WS, 120, CD0, 14000,.75);
PW_to = 1.05*PW_takeoff(15, WS, CL4, CD4,  2000,  0, 1.5*Vs);
WS_ = WS_landing(0,2000,1.5);
for ii = 1
    for jj = 1:length(WS)
        PWmin(ii,jj) = max([dX3*PW_cruise2(ii,jj),dX1*PW_to(ii,jj)]);
        if PWmin(ii,jj) == min([PWmin(ii,1:jj)])
            if WS(jj) <= WS_ 
                index = jj;
            end
        end
    end
end

P2 = PWmin(index); %shaft horsepower
S = MTOW/WS(index); %planform area, ft^2

figure
hold on 
ii=1;
plot(WS,PW_cruise2(ii,:),'b','linewidth',2)
plot(WS,PW_to(ii,:),'r','linewidth',2)
% scatter(11.7,60/350,'g*','linewidth',2)
dy = linspace(0,2*max([PW_cruise2(ii,:),PW_to(ii,:)]),100);
dx = zeros(100,1);
dx(:,1) = WS_;
axis([0,max(WS),0,max([PW_cruise2(ii,:),PW_to(ii,:)])])
plot(dx,dy,'k--')
xlabel('Wing Loading lb/ft^2')
ylabel('Power Loading (hp/lb)')
legend('Cruise Requirement','Takeoff Requirement','Landing Requirement','location','best')
grid on
ax=gca;
ax.XAxis.Exponent = 0;
ax.XTick = 0:10:1000;
ax.XAxis.MinorTick='on';
ax.XAxis.MinorTickValues = 0:2:1000;
ax.YAxis.Exponent = 0;
ax.YTick = 0:.1:30000;
ax.YAxis.MinorTick='on';
ax.YAxis.MinorTickValues = 0:.025:30000;



% for ii = 1:length(AR)
%         PWminAR2(ii) = min(PWmin(ii,:));
% end
% for ii = 1:length(WS)
%         PWminWS(ii) = min(PWmin(:,ii));
% end


err = 1000*max([abs(X1-X2)/X2,abs(P1-P2)/P2]);

if err>1
    close all
    dX1 = MTOW;
    dX2 = MTOW-sum(y(1:3));
    dX3 = MTOW-sum(y(1:4));
    dX4 = MTOW;
    dX5 = MTOW-sum(y(1:7));
    res = .25*sum(y(1:7));
    clear y PWmin
    c=c+1;
end

end

figure
hold on
bar(X,y)
ylabel('Fuel Consumption [lbs]')
xlabel('Mission Phase')
ax = gca;
ax.FontSize = 14;
ax.YTick = 0:5:100;
ax.YAxis.MinorTick='on';
ax.YAxis.MinorTickValues = 0:1:100;
grid on

disp(['Eclimb = ' num2str(E1)])
disp(['Ecruise = ' num2str(E2)])
disp(['Eloiter = ' num2str(E3)])
disp(['CL_to = ' num2str(CL4)])
disp(['CD0 = ' num2str(CD0)])
disp(' ')
disp(['MTOW = ' num2str(MTOW) ' [lbs]'])
disp(['Fuel = ' num2str(Wf) ' [lbs]'])
disp(['P_req = ' num2str(P2) ' [BHP]'])
disp(['Wing Loading = ' num2str(WS(index))])
disp(['Planform Area = ' num2str(S) ' [ft^2]'])



clear err
x = [594,600,162,810,54,59,11,76];
w = [397,165,66,60,51,375,14,79];
A = -.144;
B = 1.1162;


for ii = 1:100
    EWF = ii/100;
    for jj = 1:length(x)
    eval(jj) = (10.^((log10(w(jj))-A)/B))/EWF-w(jj);
    end
    err(ii) = std(eval);
    if err(ii) == min(err)
        index = ii;
    end
end

x = [594,600,162,810,972,5373,54,59,11,76];
w = [397,165,66,60,12500,32250,51,375,14,79];
dx = linspace(0,max(x),1000);
MTOW_log= (10.^((log10(dx)-A)/B))/EWF;
fit = (10.^((log10(dx)-A)/B))/.85;

figure
hold on
scatter(550,MTOW,100,'ro','filled')
scatter(x,w,50,'bo','filled')
plot(dx,MTOW_log,'k--','linewidth',2)
ax = gca;
axis([0,dx(end),0,max(w)])
ax.XScale = 'log';
ax.YScale = 'log';
xlabel('Range [nmi]')
ylabel('MTOW [lbs]')
grid on
ax.FontSize = 14;
pbaspect([1 1 1])
legend('Results of Initial Sizing','Competetive Assessment','MTOW Prediction by Mean EWF*','location','northwest')
text(10,8*10^3,'*Outliers Excluded','Fontsize',14)

% ax.XTick = 0:1000:10000;
% ax.XAxis.MinorTick='on';
% ax.XAxis.MinorTickValues = 0:200:10000;
% ax.YTick = 0:100:10000;
% ax.YAxis.MinorTick='on';
% ax.YAxis.MinorTickValues = 0:20:10000;
