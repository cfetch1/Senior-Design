close all
clear all
clc

addpath('C:\Users\grega\Documents\GitHub\Senior-Design\Functions')

dh = 0:1000:20000;
dV = 5:5:200;
W = 350;
S = 38.63;
FOS = 1;
BHP0 = 40;
ROC = 500;
throttle = 1;
Vc = 120;
for jj = 1:length(dh)
    h = dh(jj);
for ii = 1:length(dV)
%     if dV(ii)<=120
%         eta = .85*(dV(ii)/120)^1.5;
%     else
%         eta = .85*(120/dV(ii))^1.5;
%     end
    eta = TR640(dV(ii),Vc);
    rho = density(h);
    V_fps = dV(ii)*1.69;
    [CL,CD] = DragSLF(dV(ii),W,h,S,0,FOS);
    P_req(ii) = .5*rho*V_fps^3*S*CD/550;
    sig = sigma0(h);
    P_avail(ii) = throttle*BHP0*(sig-(1-sig)/7.55)*eta;  
    [CLc,CDc] = DragSLF(dV(ii),W,h,S,ROC,FOS);
    Pc_req(ii) = (.5*rho*V_fps^3*S*CD+W*ROC/60)/(550);
 
end

hold on
plot(dV,P_req,'r','linewidth',2)
plot(dV,P_avail,'b','linewidth',2)
plot(dV,Pc_req,'g','linewidth',2)
grid on
% ax = gca;
% ax.FontSize = 14;
axis([0,max(dV),0,100])
xlabel('Airspeed kts]')
ylabel('Power [Hp]')
legend('Power Required - Cruise','Power Available','Power Required - Climb (500 ft/min)','location','northwest')
text(10,75,['h = ' num2str(h) ' ft'],'background','white')
% text(10,50,['throttle = ' num2str(throttle*100) '%'],'background','white')
pbaspect([2,1,1])
end