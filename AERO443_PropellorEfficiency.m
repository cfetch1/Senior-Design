close all
clear all
clc

dV = 5;
V = 20:dV:180; % mph, TAS
Vc = 120;
h = 0;

[T_SL,P_SL,rho_SL] = ISA_english(0);
[T_inf,P_inf,rho_inf] = ISA_english(h);

EAS_mph = V*1.15*sqrt(rho_inf/rho_SL);
MAP = 29.92*(P_inf/P_SL);

for ii = 1:length(V)
    
    u(1) = MAP;
    u(2) = EAS_mph(ii);
    u(3) = h;
    u(4) = K2F(T_inf);
    
    p = engine_propeller(u);
    
    x1(ii) = V(ii); 
    y1(ii) = p(3);
    
    if y1(ii) == max(y1)
        index = ii;
    end
    
    P = 35*550;
    AR = 15;
    CD0 = .035;
    e = 1.78*(1-0.045*AR^0.68)-0.64;
    k = 1/(pi*AR*e);
    V_fps = V(ii)*1.69;
    q = .5*rho_inf*V_fps^2;
    S = 39.8;
    W = 437.7;
    CL = W/(q*S);
    D = q*S*(CD0+k*CL^2);
    P_req(ii)= D*V_fps;
            
end

x2 = linspace(V(1),Vc,index); %,linspace(Vc+dV,V(end),ii-index)];
f = polyfit(x2,y1(1:index),3);
y2 = polyval(f,x1);
xc = zeros(length(y2),1);
xc(:,1) = Vc;
yc = linspace(0,1.2*y1(index),length(y2));

P_avail = P*y2./550;
P_req=P_req/550;

% figure
% hold on
% plot(x1,y1,'r','linewidth',2)
% plot(x1,y2,'b','linewidth',2)
% tc = plot(xc,yc,'k--','linewidth',1);
% text2line(tc,.5,0,'Design Point')
% xlabel('Airspeed [kts]')
% ylabel('Propellor Efficiency [%]')
% axis([V(1),V(end),0,1.2*y1(index)])
% grid on
 
CLmax = 1.58;
xlim = (sqrt(2*W/(rho_inf*S*CLmax)))/1.69;
dx = zeros(length(x1),1);
dx(:,1) = xlim;
dy = linspace(0,max(P_req),length(P_req));



figure
hold on
t1 = plot(x1,P_req,'r','linewidth',2);
t2 = plot(x1,P_avail,'b','linewidth',2);
text2line(t1,.4,0,'Power Required')
text2line(t2,.4,0,'Power Available')
t3 = plot(dx,dy,'k--','linewidth',1);
text2line(t3,.3,0,'Stall Speed')
xlabel('Airspeed [kts]')
ylabel('Power [hp]')
axis([V(1),140,0,1.5*max(P_avail)])
grid on

    