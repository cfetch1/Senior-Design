close all
clear all
clc



MTOW = 500;
CLmax = 2;
Eclimb = 15;
Wf = 10;

P = 50;
AR_ = 15
for i = 1:length(AR_)
AR = AR_(i);
err=1000;
while abs(err)>1


e1 = MTOW;

CD0 = .035;
e = 1.78*(1-0.045*AR^0.68)-0.64;
k = 1/(pi*AR*e);
E = 1/2*sqrt(1/(CD0*k));


Wpl = 50;
Wtoguess = MTOW*.9;
Ecruise = E;
SFCcruise = .4;
Range = 550;
Eloiter = E;
SFCloiter = .4;
Endurance = 1;
reserve = Wf/4;
hcr = 7000;
Vcl = 120;
ROC = 40;
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


WS = 5:50;

CDto = .028;
CLto = .7;
dg = 3000;
% MTOW = 312;

Vcr = 120;
Vturn = .5*Vcr;
Vto = 60;
Vstall = 40;
V = [Vturn, Vcl, Vto, Vcr,Vstall];

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
[~,~,PWmin,ii] = PowerSizing(WS,CD0,CDto,CLto,CLmax,AR,V,ROC,h,dg,eta,0);
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
CLmax = WS(ii)/((40*1.69)^2*.0024/2);
% % 
% 
% % 
% % 
% % f_CD = @(CL) CD0+k*CL^2;
% % CL = 0:.01:2;
% % x2 = linspace(0,f_CD(CL(end)),length(CL));
% % 
% % for i = 1:length(CL)
% %     x1(i) = f_CD(CL(i));
% %     y1(i) = CL(i);
% %     y2(i) = x2(i)*Emax;
% % end
% % 
% % close all
% % clc
% % 
% % figure
% % hold on
% % plot(x1,y1,'r','linewidth',2)
% % t1 = plot(x2,y2,'k--','linewidth',1);
% % text2line(t1,.6,0,['E_m_a_x = ' num2str(round(Emax,1))])
% % grid on
% % ax=gca;
% % ax.YTick = 0:.1:max(y1);
% % ax.YAxis.MinorTick='on';
% % ax.YAxis.MinorTickValues = 0:.025:max(y1);
% % ax.XTick = 0:.01:2;
% % ax.XAxis.MinorTick='on';
% % ax.XAxis.MinorTickValues = 0:.001:1;
% % ylabel('C_L')
% % xlabel('C_D')
% % axis([0,max(x1),0,max(y1)])
% % 

gamma = asin(40*1.69/120);
q = .5*.0024*(120/1.69)^2;
CL = (MTOW*cos(gamma))/(q*S);
CD = .025+k*CL^2;
Eclimb = CL/CD;


err = abs(100*(E1-E2)/E2)+abs(100*(e1-e2)/e2);

end

x(i) = AR;
y1(i) = MTOW;
y2(i) = P;
y3(i) = b;

end


if i=1
    

AR
MTOW
S
b
c
else
    

figure
subplot(311)
hold on
plot(x,y1)
xlabel('AR')
ylabel('MTOW')
grid on
axis([0,max(x),0,max(y1)])
subplot(312)
hold on
plot(x,y2)
xlabel('AR')
ylabel('Power')
grid on
axis([0,max(x),0,max(y2)])
subplot(313)
hold on
plot(x,y3)
xlabel('AR')
ylabel('Span')
grid on
axis([0,max(x),0,max(y3)])


end





