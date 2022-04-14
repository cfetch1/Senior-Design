close all
clear
clc

% fun = polyfit(0:.1:1,[.45,.465,.48,.49,.5,.49,.48,.46,.44,.38,.24],2);
% p = @(x) polyval(fun,x);
p = @(x) sqrt(1-x.^2);

file = readmatrix('Configuration.xlsx');
MTOW = file(1,2);
S = file(14,2);
b = file(17,2);
c_root = file(18,2)/12;
c_tip = file(19,2)/12;
lambda = c_tip/c_root;
c = 2*c_root*(1+lambda+lambda^2)/(3*(1+lambda));
S_h = file(28,2);
S_v = file(29,2);
lambda_T = file(33,2)/file(32,2);
c_T = 2*file(32,2)*(1+lambda_T+lambda_T^2)/(3*(1+lambda_T))/12;
L_fuselage = file(10,2);
clear file

file = 'Drag.xlsx';
writecell(mat2cell(MTOW,1),file,'Sheet','Sheet1','Range','D6');
writecell(mat2cell(c,1),file,'Sheet','Sheet1','Range','J5');
writecell(mat2cell(b,1),file,'Sheet','Sheet1','Range','J6');
writecell(mat2cell(c_root,1),file,'Sheet','Sheet1','Range','J7');
writecell(mat2cell(c_tip,1),file,'Sheet','Sheet1','Range','J7');
writecell(mat2cell(S_h/S,1),file,'Sheet','Sheet1','Range','J14');
writecell(mat2cell(c_T/S,1),file,'Sheet','Sheet1','Range','J15');
writecell(mat2cell(L_fuselage,1),file,'Sheet','Sheet1','Range','J16');
clear file

V = 160;
FOS = 1;
h = 0;
index = 1+(V-60)/10;
file = readmatrix('Drag.xlsx', 'Range', 'B20:V29');
V_fps = file(1,index);
alpha = file(2,index);
CL = file(3,index);
CDi = file(4,index);
CDp = file(5,index);
clear file


[T,P,rho] = ISA_english(h/2);
q = .5*rho*(V_fps)^2;
nz = 1;

c = linspace(c_root,c_tip,100);
dy = linspace(0,b/2,100);

for ii=1:100
    XY(ii,:) = linspace(0,c(ii),100);
    dx = (c_root-XY(ii,end))/4;
    XY(ii,:) = XY(ii,:)+dx;
    dA(ii) = c(ii)*b/200;
    dCL(ii) = CL*p(1-cos(dy(ii)/(b/2)*pi/2));
    dCDi(ii) = CDi*p(1-cos(dy(ii)/(b/2)*pi/2));
    dCDp(ii) = CDp*dA(ii)/dA(1);
end

dCL = .5*(dCL*CL/sum(dCL))*nz;
dCL1 = .5*(dCL*CL/sum(dCL));
dCDi = .5*(dCDi*CDi/sum(dCDi))*nz^2;
dCDi1 = .5*(dCDi*CDi/sum(dCDi));
dCDp = .5*(dCDp*CDp/sum(dCDp))*nz;
dCDp1 = .5*(dCDp*CDp/sum(dCDp));


Fz = q*S*(dCL*cosd(alpha)-(dCDi+dCDp)*sind(alpha));
Fz1 = q*S*(dCL1*cosd(alpha)-(dCDi1+dCDp1)*sind(alpha));
Fz_ = sum(Fz);
Fx = q*S*(dCL*sind(alpha)+(dCDi+dCDp)*cosd(alpha));
Fx1 = q*S*(dCL1*sind(alpha)+(dCDi1+dCDp1)*cosd(alpha));
Fx_ = sum(Fx);

F_ = FOS*sqrt(Fx.^2+Fz.^2);
F_1 = FOS*sqrt(Fx1.^2+Fz1.^2);

for ii = 1:100
    Mz(101-ii) = sum(Fx(1:ii).*dy(1:ii));
    Mx(101-ii) = sum(Fz(1:ii).*dy(1:ii));
    M_(101-ii) = sum(F_(1:ii).*(0+dy(1:ii)));
    M_1(101-ii) = sum(F_1(1:ii).*dy(1:ii));
end


Fmin = min([0,min(Fx),min(Fz)]);
Fmax = max(F_);

Mmin = min([0,min(Mx),min(Mz)]);
Mmax = max(M_);

figure
hold all
ax = gca;
ax.FontSize= 24;
grid on
title('External Loads')
yyaxis left
plot(dy,Fz,'linewidth',2)
ylabel('Fz [lb_f]')
axis([0,b/2,Fmin,Fmax])
yyaxis right
plot(dy,Fx,'linewidth',2)
ylabel('Fx [lb_f]')
axis([0,b/2,Fmin,Fmax])
xlabel('Spanwise Location [ft]')


figure
hold all
ax = gca;
ax.FontSize= 24;
grid on
yyaxis left
plot(dy,Mz,'linewidth',2)
ylabel('Mz [ft-lb]')
axis([0,b/2,Mmin,Mmax])
yyaxis right
plot(dy,Mx,'linewidth',2)
ylabel('Mx [ft-lb]')
axis([0,b/2,Mmin,Mmax])
xlabel('Spanwise Location [ft]')

for ii = 1:100
    Fi(101-ii) = sum(F_(1:ii));
    Fi1(101-ii) = sum(F_1(1:ii));
end


figure
hold all
ax = gca;
ax.FontSize= 24;
grid on
title('Internal Loads')
yyaxis left
plot(dy,Fi,'b','linewidth',2)
% if nz ~= 1
%     plot(dy,Fi1,'b--','linewidth',2)
% end
ylabel('Total Shear [lb_f]')
axis([0,b/2,Fmin,max(Fi)])
yyaxis right
plot(dy,M_,'linewidth',2)
% if nz ~= 1
%     plot(dy,M_1,'r--','linewidth',2)
% end
ylabel('Total Moment [ft-lb]')
axis([0,b/2,Mmin,Mmax])
xlabel('Spanwise Location [ft]')




%% MK4 VN diagram


CLmax = 1.3;
CLmin = -.5;

nmax = 4.4;
nmin = -1.8;

Sref = S;
m = MTOW;

g = 33.2;
W = MTOW;
rho = .0024;

Vapos = sqrt(nmax*W/(.5*rho*CLmax*Sref));
Vaneg = sqrt(nmin*W/(.5*rho*CLmin*Sref));
Vd = 1.25*160*1.15*5280/3600;

Vstall = sqrt(W/(.5*rho*CLmax*Sref));

Vpos = linspace(Vstall,Vapos);
Vneg = linspace(Vstall,Vaneg);

nposstall = .5*rho*Vpos.^2*Sref*CLmax./W;
nnegstall = .5*rho*Vneg.^2*Sref*CLmin./W;

dy1 = linspace(nmin,nmax,100);
dy2 = linspace(nnegstall(11),nposstall(11),100);
Vc = zeros(100,1);
Vc(:,1) = 260;
Va = zeros(100,1);
Va(:,1) = 130;

rho = 1.225;
c=c*.3048;
s=1;
WS = W*2.205/(S*.0929);
U = 50/2*(1-cos(2*pi*s/(25*mean(c))));
mug = 2*(WS)/(rho*mean(c)*2*pi*9.81);
kg = .88*mug/(5.3+mug);
nnegg = 1-kg*rho*50*(Va(1)*.3048)/(2*WS);
nposg = 1+kg*rho*50*(Va(1)*.3048)/(2*WS);
dV = linspace(Vpos(1),Vd,100);
pdg = linspace(1,nposg,100);
ndg = linspace(1,nnegg,100);

figure
hold on
ax = gca;
ax.FontSize= 24;
plot(Vpos,nposstall,'k','linewidth',2)
plot(Vneg,nnegstall,'k','linewidth',2)
plot([Vstall Vstall],[nnegstall(1) nposstall(1)],'k','linewidth',2)
plot([Vpos(end) Vd],[nmax nmax],'k','linewidth',2)
plot([Vneg(end) Vd],[nmin nmin],'k','linewidth',2)
plot([Vd Vd],[nmin, nmax],'k','linewidth',2)
plot(Vc,dy1,'k--');
% plot(dV,pdg,'k--','linewidth',2)
% plot(dV,ndg,'k--','linewidth',2)

text(Vc(1),0,'V_C','BackgroundColor','w','FontSize',18)
text(Vd,0,'V_D','BackgroundColor','w','FontSize',18)
plot(Va,dy2,'k--');
text(Va(1),0,'V_A','BackgroundColor','w','FontSize',18)
axis([0 Vd*1.05 -2 5])
xlabel('Airspeed [ft/s]')
ylabel('Load Factor')
grid on









