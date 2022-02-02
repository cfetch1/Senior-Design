function [x,h,V,W,t] = fsearch(x2,h,V1,Vw,W1,P0,throttle,Vc,S,f)

%% OUTPUTS 
% x (vector):   distance [nmi]
% h (vector):   altitude [ft]
% V (vector):   airspeed [kts]
% W (vector):   weight [lbs]
% t (time):     time [min]

x(1) = 0;
h(1) = h;
V(1) = V1;
W(1) = W1;
t(1) = 0;


dt = 60; % seconds
ii = 1;

while x(ii)<x2
    
    PSFC = fPSFC(h(ii),V(ii));
    
    rho = density(h(ii));
    
    sigma = sigma0(h(ii));
    P_eng = P0*throttle*(sigma-(1-sigma)/7.55);
    eta_prop = TR640(V(ii)+Vw,Vc);
    P_avail = P_eng*eta_prop*550;
    df = PSFC*P_eng*dt/3600;
    
    V_fps = (V(ii)+Vw)*1.69;        
    CL = W(ii)/(.5*rho*V_fps^2*S);
    CD = f(1)*(CL)^2 + f(2)*CL + f(3);
    D = .5*rho*V_fps^2*S*CD;
    P_req = D*V_fps;
    
    dV = (P_avail-P_req)*dt/(W(ii)*3600);

    x(ii+1) = x(ii)+(V(ii)-Vw+.5*dV/1.69)*dt/3600;
    h(ii+1) = h(ii);
    V(ii+1) = V(ii)+dV/1.69;
    W(ii+1) = W(ii)-df;
    t(ii+1) = ii*dt;
    
%     if 60*x(end)/t(end)< .9*Vc
%         disp('ERROR')
%         break
%     end
       
    ii = ii+1;
    
end

t = t/60;
      
end

