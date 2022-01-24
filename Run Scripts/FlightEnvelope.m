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
throttle = .75;
for jj = 1:length(dh)
    h = dh(jj);
for ii = 1:length(dV)
    rho = density(h);
    V_fps = dV(ii)*1.69;
    [CL,CD] = DragSLF(dV(ii),W,h,S,0,FOS);
    P_req(ii) = .5*rho*V_fps^3*S*CD/550;
    sig = sigma0(h);
    P_avail(ii) = throttle*BHP0*(sig-(1-sig)/7.55);  
    [CLc,CDc] = DragSLF(dV(ii),W,h,S,ROC,FOS);
    Pc_req(ii) = (.5*rho*V_fps^3*S*CD+W*ROC/60)/(550);
 
end

hold on
plot(dV,P_req,'r','linewidth',2)
plot(dV,P_avail,'b','linewidth',2)
plot(dV,Pc_req,'g','linewidth',2)

end
