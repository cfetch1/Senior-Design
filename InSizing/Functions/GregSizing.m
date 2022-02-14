function [MTOW,We,Wf,Wrs] = GregSizing(f,x0,Mission,Vc,Xc,hc,hl,t,ROC,Wpl,Wres)

%% INPUTS

% f         drag curve f(CL)
% x0        initialization for MTOW, P, S
% Mission   ON/OFF for mission stages
% Vc        cruise speed
% Xc        cruise distance
% hc        cruise altitude
% hl        loiter altitude
% t         loiter time
% ROC       rate of climb
% Wpl       payload weight
% Wres      fuel reserve (%)

% UNITS
% distance (in air)     nautical miles
% ground run            feet
% speed                 knots (TAS)
% altitude              feet
% time                  minutes
% power                 horsepower (BHP)

% MISSION PROFILE: turn mission stage ON (1) or OFF (0)
% 1.  Start-Up          fixed fuel consumption - ALWAYS ON
% 2.  Taxi              fixed fuel consumption - ALWAYS ON
% 3.  Takeoff           fixed fuel consumption - ALWAYS ON
% 4.  Climb 1           V_MaxROC, to cruise altitude (hc1) - ALWAYS ON
% 5.  Cruise 1          set airspeed (Vc1) and altitude (hc1) - ALWAYS ON
% 6.  Descent 1         fixed fuel consumption
% 7.  Loiter 1          V_MaxEndurance, set time (tl1) and altitude (hl1)
% 8.  Climb 2           V_MaxROC, to cruise altitude (hc2)
% 9.  Cruise 2          set airspeed (Vc2) and altitude
% 10. Loiter 2          V_MaxEndurance, set time and altitude
% 11. Descent 2         fixed fuel consumption - ALWAYS ON
% 12. Land/Shut-Down    fixed fuel consumption - ALWAYS ON

% if airspeed is not specified (0), V = V_MaxRange



% Set Constants/Anonymous Function
rho = @(h) density(h);

% Initialize Values
MTOW = x0(1);
P0 = x0(2);
S = x0(3);
Wrs = ones(1,length(Mission)); % Fuel Fractions
err = 1000;
Vp = max(Vc)*1.69; % propellor design speed, fps


while abs(err) > 1 % Begin Range Sizing Loop
    
    W(1) = MTOW;
    
    %% 1. Start-Up
    Wrs(1) = .99;
    W(2) = MTOW*Wrs(1);
    
    %% 2. Taxi
    Wrs(2) = .99;
    W(3) = MTOW*prod(Wrs(1:2));
    
    %% 3. Take-Off
    Wrs(3) = .98;
    W(4) = MTOW*prod(Wrs(1:3));
    
    %% 4. Climb 1
    
    % solve for V_Max(L/D)
    syms V
    a = 2*W(4)/(rho(hc(1)/2)*S);
    CL = @(V) a/(V^2);
    CD = @(V) f(1)*CL(V)^2+f(2)*CL(V)+f(3);
    E = @(V) CL(V)/CD(V);
    dE = diff(E,V);
    V_fps = fzero(@(V) eval(dE), 100);
    V_kts = V_fps/1.69;
    P_req = .5*rho(hc(1)/2)*V_fps^3*S*CD(V_fps);
    
    % solve for engine power
    sigma = sigma0(hc(1)/2);
    eta = TR640(V_fps,Vp);
    throttle = (ROC(1)*W(4)/60+P_req)/(P0*550*(sigma-(1-sigma)/7.55)*eta);
    
    % solve for fuel consumption, distance
    dt = hc(1)/ROC(1);
    df = P0*550*throttle*(sigma-(1-sigma)/7.55)*fTSFC(hc(1)/2,V_kts)*(dt/60)/(V_fps);
    gamma = asin(ROC(1)/(60*V_fps));
    dx = V_fps*cos(gamma)*3600/(5280*1.15);
    
    W(5) = W(4)-df;
    Wrs(4) = W(5)/W(4);
    
    %% 5. Cruise 1
    
    V_fps = Vc(1)*1.69;
    CL = 2*W(5)/(rho(hc(1))*V_fps^2*S);
    CD = f(1)*CL^2+f(2)*CL+f(3);
    P_req = .5*rho(hc(1))*V_fps^3*S*CD;
    
    % solve for engine power 
    sigma = sigma0(hc(1));
    eta = TR640(V_fps,Vp);
    throttle = P_req/(P0*550*(sigma-(1-sigma)/7.55)*eta);
    
    % solve for fuel consumption
    dt = (Xc(1)-2*dx)/Vc(1);
    df = P0*550*throttle*(sigma-(1-sigma)/7.55)*fTSFC(hc(1),Vc(1))*dt/(V_fps);
    
    W(6) = W(5)-df;
    Wrs(5) = W(6)/W(5);
    
    if Mission(6) == 1  % Descent 1
        Wrs(6) = .99;
    end
    
    %% 7. Loiter 1
    
    W(7) = MTOW*prod(Wrs(1:6));
    
    if Mission(7) == 1
        
        % solve for V_MaxEndurance
        syms V
        a = 2*W(4)/(rho(hl(1))*S);
        CL = @(V) a/(V^2);
        CD = @(V) f(1)*CL(V)^2+f(2)*CL(V)+f(3);
        F = @(V) CL(V)^1.5/CD(V);
        dF = diff(F,V);
        V_fps = fzero(@(V) eval(dF), 80);
        V_kts = V_fps/1.69;
        P_req = .5*rho(hl(1))*V_fps^3*S*CD(V_fps);
        
        % solve for engine power
        sigma = sigma0(hl(1));
        eta = TR640(V_fps,Vp);
        throttle = P_req/(P0*550*(sigma-(1-sigma)/7.55)*eta);
        
        % solve for fuel consumption
        df = P0*throttle*550*(sigma-(1-sigma)/7.55)*fTSFC(hl(1),V_kts)*(t(1)/60)/V_fps;
        W(8) = W(7)-df;
        Wrs(7) = W(8)/W(7);
    else
        W(8) = W(7);
    end
    
    %% 8. Climb 2
    
    if Mission(8) == 1
        syms V
        a = 2*W(8)/(rho(hc(2)/2)*S);
        CL = @(V) a/(V^2);
        CD = @(V) f(1)*CL(V)^2+f(2)*CL(V)+f(3);
        E = @(V) CL(V)/CD(V);
        dE = diff(E,V);
        V_fps = fzero(@(V) eval(dE), 100);
        V_kts = V_fps/1.69;
        P_req = .5*rho(hc(2)/2)*V_fps^3*S*CD(V_fps);
        
        sigma = sigma0(hc(2)/2);
        eta = TR640(V_fps,Vp);
        throttle = (ROC(1)*W(4)/60+P_req)/(P0*550*(sigma-(1-sigma)/7.55)*eta);
        
        dt = hc(1)/ROC(1);
        df = P0*550*throttle*fTSFC(hc(2)/2,V_kts)*(dt/60)/V_fps;
        gamma = asin(ROC(1)/(60*V_fps));
        dx = V_fps*cos(gamma)*3600/(5280*1.15);
        
        W(9) = W(8)-df;
        Wrs(8) = W(9)/W(8);
    else
        W(9) = W(8);
        dx = 0;
    end
    
    %% 9.  Cruise 2
    
    if Mission(9) == 1
        if Vc(2)>0
            
            V_fps = Vc(2)*1.69;
            CL = 2*W(9)/(rho(hc(2))*V_fps^2*S);
            CD = f(1)*CL^2+f(2)*CL+f(3);
            P_req = .5*rho(hc(2))*V_fps^3*S*CD;
            
        else
            
            a = 2*W(9)/(rho(hc(2))*S);
            CL = @(V) a/(V^2);
            CD = @(V) f(1)*CL(V)^2+f(2)*CL(V)+f(3);
            E = @(V) CL(V)/CD(V);
            dE = diff(E,V);
            V_fps = fzero(@(V) eval(dE), 100);
            V_kts = V_fps/1.69;
            P_req = .5*rho(hc(2))*V_fps^3*S*CD(V_fps);
            
        end
        
        sigma = sigma0(hc(2)/2);
        eta = TR640(V_fps,Vp);
        throttle = P_req/(P0*550*(sigma-(1-sigma)/7.55)*eta);
        
        dt = (Xc(2)-2*dx)/(V_fps*3600/(5280*1.15));
        df = P0*550*throttle*fTSFC(hc(2),V_kts)*dt/V_fps;
        W(10) = W(9)-df;
        Wrs(9) = W(10)/W(9);
        
    else
        W(10) = W(9);
    end
    
    
    %% 10. Loiter 2
    
    if Mission(10) == 1
        syms V
        a = 2*W(10)/(rho(hl(2))*S);
        CL = @(V) a/(V^2);
        CD = @(V) f(1)*CL(V)^2+f(2)*CL(V)+f(3);
        F = @(V) CL(V)^1.5/CD(V);
        dF = diff(F,V);
        V_fps = fzero(@(V) eval(dF), 80);
        V_kts = V_fps/1.69;
        P_req = .5*rho(hl(2))*V_fps^3*S*CD(V_fps);
        
        sigma = sigma0(hl(2));
        eta = TR640(V_fps,Vp);
        throttle = P_req/(P0*550*(sigma-(1-sigma)/7.55)*eta);
        
        df = P0*throttle*550*fTSFC(hl(2),V_kts)*(t(2)/60)/V_fps;
        W(11) = W(10)-df;
        Wrs(10) = W(11)/W(10);
    else
        W(11) = W(10);
    end
    
    %% Descent 2
    Wrs(11) = .99;      % Descent 2
    
    %% Landing/Shut-Down
    Wrs(12) = .995;
    W(12) = MTOW*prod(Wrs(1:11));
    
    
    % total fuel required
    Wf = MTOW*(1-prod(Wrs))*(1+Wres);
    
    We=MTOW-Wf-Wpl;
    
    % calculate empty weight from log regression (Roskam)
    A1 = -.144;
    B1 = 1.1162;
    
    A2 = .8222;
    B2 = .8050;
    We_log=.5*( (10^((log10(MTOW)-A1)/B1)) + (10^((log10(MTOW)-A2)/B2)) );
    
    % update MTOW based on error
    err = We-We_log;
    MTOW = MTOW - err;
    
end

MTOW = (We+Wf+Wpl);






end

