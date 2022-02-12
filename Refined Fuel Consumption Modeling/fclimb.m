function [x,h,V,W,t] = fclimb(h1,h2,V1,W1,P0,throttle,Vc,S,f)

%% OUTPUTS 
% x (vector):   distance [nmi]
% h (vector):   altitude [ft]
% V (vector):   airspeed [kts]
% W (vector):   weight [lbs]
% t (time):     time [?]

%% CONSTANTS
% P0 (scalar)
% Vc (scalar)
% S (scalar)
% f (scalar set)


%% OTHER (change later)

x(1) = 0;
h(1) = h1;
V(1) = V1;
W(1) = W1;
t(1) = 0;


dt = 60; % seconds
ii = 1;

while h(ii)<h2
    
    PSFC = fPSFC(h(ii),V(ii));
    
    rho = density(h(ii));
    V_fps = V(ii)*1.69;
    
    sigma = sigma0(h(ii));
    P_eng = P0*throttle*(sigma-(1-sigma)/7.55);
    eta_prop = TR640(V(ii),Vc);
    P_avail = P_eng*eta_prop*550;
    df = PSFC*550*P_eng*dt/3600;
        
    % for gamma << 1
    CL = W(ii)/(.5*rho*V_fps^2*S);
    CD = f(1)*(CL)^2 + f(2)*CL + f(3);
    D = .5*rho*V_fps^2*S*CD;
    P_req = D*V_fps;
    
    gamma = asin((P_avail-P_req)/(W(ii)*V_fps));
       
    err = 1000;
    
    while err > .1
        
        e1 = gamma;

        % correct for CL
        CL = W(ii)*cos(gamma)/(.5*rho*V_fps^2*S);
        CD = f(1)*(CL)^2 + f(2)*CL + f(3);
        D = .5*rho*V_fps^2*S*CD;
        P_req = D*V_fps;

        gamma = asin((P_avail-P_req)/(W(ii)*V_fps));

        e2 = gamma;
        err = abs(e2-e1)/e2;
    
    end
    
    x(ii+1) = x(ii)+V(ii)*cos(gamma)*dt/3600;
    h(ii+1) = h(ii)+V_fps*sin(gamma)*dt;
    V(ii+1) = V(ii);
    W(ii+1) = W(ii)-df;
    t(ii+1) = ii*dt;
    if h(ii+1)<h(ii)
        disp('ERROR')
        break
    end
       
    ii = ii+1;
    
end

t = t/60;
      
end

