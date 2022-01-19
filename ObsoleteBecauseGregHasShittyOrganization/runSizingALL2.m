% close all
% clear all
clc

MTOW = 400;
CLmax = 2;
% Eclimb = 15;
Wf = 10;
S = 40;
P = 30;
AR_ = 15;
%cd0 = [0.035,0.028];
cd0 = .013;
for z = 1
for i = 1:length(AR_)
AR = 18;
err=1000;
CD0 = cd0(z);
while abs(err)>.5

    close all
    clc

e1 = MTOW;

% CD0 = .035;
e = 1.78*(1-0.045*AR^0.68)-0.64;
k = 1/(pi*AR*e);
%E = 1/2*sqrt(1/(CD0*k));
CL = MTOW/(.5*.002*202.5^2*S);
CD = 0.0242*CL^2 - 0.0026*CL + 0.0128;
E = CL/CD;
Wpl = 160;
Wtoguess = MTOW*.9;
SFCcruise = .4;
Range = 550;
Eloiter = Emax;
Eclimb = E;
SFCloiter = .4;
Endurance = 1;
reserve = Wf/4;
hcr = 7000;
Vcl = 120;
ROC = 80;
SFCclimb = .5;
eta_cl = .7865;
eta_cr = .7859;
%Eclimb = 14;

[MTOW,We,Wf]=RangeSizing(Wpl,Wtoguess,Ecruise,SFCcruise,Range,Eloiter,SFCloiter,Endurance,reserve,hcr,Vcl,ROC,SFCclimb,eta_cl,eta_cr,Eclimb);
e2 = MTOW;

% %AR = 10;
% i=1;
% e = 1.78*(1-0.045*AR^0.68)-0.64;
% k = 1/(pi*AR*e);
% % E = 1/2*sqrt(1/(.025*k));
% S =  31.27;


WS = 5:.5:45;

CDto = CD0;
CLto = .7;
dg = 3000;
% MTOW = 312;
Vstall = 45;
Vcr = 120;
Vturn = .5*Vcr;
Vto = 60;
V = [Vturn, Vcl, Vto, Vcr,Vstall];
% ROC = 160;
eta = [.4147,eta_cl,.4097,eta_cr,.7859]; %[turn, climb, to, cruise, ceiling]

hturn = hcr;
hto = 0;
hclimb = 0;
hmax = 10000;
h = [hturn, hclimb, hto, hcr, hmax];
% if AR == 23
%     z = 1;
% else 
%     z=0;
% end
E1 = P;
[~,~,PWmin,ii] = PowerSizing(WS,CD0,CDto,MTOW,CLmax,AR,V,ROC,h,dg,eta,1);
% 
% 
% end
% figure
% hold on
% plot(x,y,'r','linewidth',2)
% grid on
% axis([x(1),x(end),0,max(y)])
% % ax=gca;
% % ax.XTick = 0:1:WS(end);
% % ax.XAxis.MinorTick='on';
% % ax.XAxis.MinorTickValues = 0:1:AR_(end);
% % ax.YTick = 0:.001:1;
% % ax.YAxis.MinorTick='on';
% % ax.YAxis.MinorTickValues = 0:.001:1;
% % ylabel('Minimum P/W [hp/lbm]')
% % xlabel('Aspect Ratio')
% % 
% % 
P = PWmin*MTOW; %shaft horsepower
S = MTOW/WS(ii); %planform area, ft^2
b = sqrt(S*AR); %wingspan, ft
c = S/b; %mean chord, ft
E2 = P;
CLmax = 1.58;
% % 
% 
% % 
% % 



gamma = asin(40*1.69/120);
q = .5*.0024*(120/1.69)^2;
CL = (MTOW*cos(gamma))/(q*S);
CD = CD0+k*CL^2;
Eclimb = CL/CD;


err = abs(100*(E1-E2)/E2)+abs(100*(e1-e2)/e2);

end


if z ==1
x(i) = AR;
y1(i) = P;
y2(i) = MTOW;
elseif z==2
y1c(i) = P;
y2c(i) = MTOW;
% y3(i) = b;
end
end

end
p1 = min(y1);
p2 = p1*1.1;
py1 = zeros(length(AR_),1);
py1(:,1) = p1;
py2 = zeros(length(AR_),1);
py2(:,1) = p2;

m1 = min(y2);
m2 = m1*1.1;
my1 = zeros(length(AR_),1);
my1(:,1) = m1;
my2 = zeros(length(AR_),1);
my2(:,1) = m2;


f_CD = @(CL) CD0+k*CL^2;
CL = 0:.01:CLmax;
Emax = 1/2*sqrt(1/(CD0*k));
x2 = linspace(0,f_CD(CL(end)),length(CL));
% 
for i = 1:length(CL)
    x1(i) = f_CD(CL(i));
    y1(i) = CL(i);
    y2(i) = x2(i)*Emax;
end

figure
hold on
set(gca,'FontSize',21)
plot(x1,y1,'r','linewidth',2)
t1 = plot(x2,y2,'k--','linewidth',1);
text2line(t1,.3,0,['E_m_a_x = ' num2str(round(Emax,1))],21)
grid on
ax=gca;
ax.YTick = 0:.1:max(y1);
ax.YAxis.MinorTick='on';
ax.YAxis.MinorTickValues = 0:.025:max(y1);
ax.XTick = 0:.01:2;
ax.XAxis.MinorTick='on';
ax.XAxis.MinorTickValues = 0:.001:1;
ylabel('C_L')
xlabel('C_D')
axis([0,max(x1),0,max(y1)])

% 
% if i==1
%     
% P 
% AR
% MTOW
% S
% b
% c
% else
%     
% % 
%  figure
% % subplot(211)
%  hold on
%  plot(x,y1,'r','linewidth',2)
%  plot(x,y1c,'b','linewidth',2)
%  t1 = plot(x,py1,'k--','linewidth',1);
%  t2 = plot(x,py2,'k--','linewidth',1);
%  plot(15,35.05,'k*','linewidth',2)
%  text(15,35.05*1.05,'Current Design Point','HorizontalAlignment','Left')
%  text2line(t1,.9,0,'Minimum Power')
%  text2line(t2,.9,0,'110% of Minimum Power')
%  legend('Fixed Landing Gear: C_D_0 = .035','Retractable Landig Gear: C_D_0 = .028','location','best')
%  xlabel('Aspect Ratio')
%  ylabel('Power Required [brake horsepower]')
%  grid on
%  axis([x(1),x(end),0,max(y1)])
% % subplot(312)
% figure
% hold on
% plot(x,y2,'r','linewidth',2)
% plot(x,y2c,'b','linewidth',2)
% t1 = plot(x,my1,'k--','linewidth',1);
% t2 = plot(x,my2,'k--','linewidth',1);
% text2line(t1,.9,0,'Minimum Weight')
% text2line(t2,.9,0,'110% of Minimum Weight')
% plot(15,439.1,'k*','linewidth',2)
% text(15,439.1*1.03,'Current Design Point','HorizontalAlignment','Left')
%  legend('Fixed Landing Gear: C_D_0 = .035','Retractable Landig Gear: C_D_0 = .028','location','best')
% 
% xlabel('Aspect Ratio')
% ylabel('MTOW [lbs]')
% grid on
% axis([x(1),x(end),.5*min(y2),max(y2)])
% % subplot(313)
% % hold on
% % plot(x,y3)
% % xlabel('AR')
% % ylabel('Span')
% % grid on
% % axis([0,max(x),0,max(y3)])
% % 
% % 
% % end
% 
% 
% 
% 
% 
