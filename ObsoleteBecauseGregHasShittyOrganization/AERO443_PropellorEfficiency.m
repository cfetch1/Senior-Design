close all
clear all
clc

dV = 5;
V = 10:dV:180; % kts, TAS
%Vc = V(index);
h_ = 18000;
%Vc = 120;
Vc = 120;
%h_=7000;

for jj=1:length(h_)
      h = h_(jj);
    

    
  

[T_SL,P_SL,rho_SL] = ISA_english(0);
[T_inf,P_inf,rho_inf] = ISA_english(h);

EAS_mph = V*1.15*sqrt(rho_inf/rho_SL);
MAP = 29.92*(P_inf/P_SL);

    P = 35*550*(rho_inf/rho_SL)^0.8;

for ii = 1:length(V)
    
    u(1) = MAP;
    u(2) = EAS_mph(ii);
    u(3) = h;
    u(4) = K2F(T_inf);
    
    p = engine_propeller(u);
    
    x1(ii) = V(ii); 
    y1(ii) = p(3);
    yy=p(1);
%     if x1(ii) == V
%         index = ii;
%     end
   %  if jj ==1
    if y1(ii) == max(y1)
       index = ii;
    end
    % end
    

    AR = 15;
    CD0 = .035;
    e = 1.78*(1-0.045*AR^0.68)-0.64;
    k = 1/(pi*AR*e);
    V_fps = V(ii)*1.69;
    q = .5*rho_inf*V_fps^2;
    S = 38.9;
    W = 428;
    CL = W/(q*S);
    D = q*S*(CD0+k*CL^2);
    P_req(ii)= D*V_fps;
            
end


x2 = linspace(V(1),Vc,index); %,linspace(Vc+dV,V(end),ii-index)];
f = polyfit(x2,y1(1:index),4);
y2 = polyval(f,x1);
xc = zeros(length(y2),1);
xc(:,1) = Vc;
yc = linspace(0,1.2*y1(index),length(y2));


P_avail = P*y2./550;

P_req=P_req/550;

f1 = polyfit(V,P_avail,2);
f2 = polyfit(V,P_req,2);
Vmin(jj) = fzero(@(x) polyval(f1,x)-polyval(f2,x), V(1));
Vmax(jj) = fzero(@(x)polyval(f1,x)-polyval(f2,x), V(end));

% hold on
% plot(V,polyval(f1,V))
% plot(V,polyval(f2,V))
% 


CLmax = 1.58;
xlim = (sqrt(2*W/(rho_inf*S*CLmax)))/1.69;
dx = zeros(length(x1),1);
dx(:,1) = xlim;
dy = linspace(0,max(P_req),length(P_req));


ddx = linspace(0,200,200);
pp = zeros(200,1);
pp(:,1) = round(P/550);


figure
hold on
% title(['h = ' num2str(h) ' ft'])
t1 = plot(x1,P_req,'r','linewidth',2);
t2 = plot(x1,P_avail,'b','linewidth',2);
text2line(t1,.4,0,'Power Required',14)
text2line(t2,.4,0,'Power Available',14)
t3 = plot(dx,dy,'k','linewidth',2);
t4 = plot(ddx,pp,'k--','linewidth',2);
text2line(t3,.3,0,'Stall Speed',14)
text2line(t4,.35,0,'Engine Output',14)
xlabel('Airspeed [kts]')
ylabel('Power [hp]')
axis([0,180,0,80])
pbaspect([2,1,1])
ax=gca;
ax.XTick = 0:25:1000;
ax.XAxis.MinorTick='on';
ax.XAxis.MinorTickValues = 0:5:1000;
ax.YTick = 0:10:100;
ax.YAxis.MinorTick='on';
ax.YAxis.MinorTickValues = 0:2:100;
ax.FontSize = 14;
grid on






end

figure
hold on
plot(Vmin,h_,'r','linewidth',2)
plot(Vmax,h_,'b','linewidth',2)




figure
hold on
plot(x1,y1,'r','linewidth',2)
plot(x1,y2,'b','linewidth',2)
tc = plot(xc,yc,'k--','linewidth',1);
text2line(tc,.5,0,'Design Point')
xlabel('Airspeed [kts]')
ylabel('Propellor Efficiency [%]')
legend('RV7 Propellor Efficiency','UAS Target Efficiency','location','best')
axis([V(1),V(end),0,1.2*y1(index)])
grid on
 






    