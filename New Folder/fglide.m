function [x,h,V,W,t] = fglide(h1,h2,V1,W1,Vc,S,f)

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


dt = 5; % seconds
ii = 1;

while h(ii)<h2
    
    TSFC = 0;
    
    rho = density(h(ii));
    Vs = sqrt(W/(.5*rho*S*1.3));
    V(ii) = 1.3*Vs;
    V_fps = V(ii);
    
    P_avail = 0;
    
    
    % for gamma << 1
    CL = 1.3;
    CD = f(1)*(CL)^2 + f(2)*CL + f(3);
    D = .5*rho*V_fps^2*S*CD;
    P_req = D*V_fps;
    
    df = 0;
    
    gamma = asin((-P_req)/(W(ii)*V_fps));
    rad2deg(gamma)
    x(ii+1) = x(ii)+V(ii)*cos(gamma)*dt/3600;
    h(ii+1) = h(ii)+V_fps*sin(gamma)*dt;
    %V(ii+1) = V(ii);
    W(ii+1) = W(ii)-df;
    t(ii+1) = ii*dt;
   
    V(ii+1) = V(ii);

    ii = ii+1;
    
    
    
end

t = t/60;

end

