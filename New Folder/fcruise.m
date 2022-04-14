function [x,h,V,W,t,PSFC,phi] = fcruise(x2,h,V1,Vw,W1,P0,Vc,S,f,tlim,opt,PSFC)

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

if opt == 1
        
        dV = 60:120;
        
        for kk = 1:length(dV)
            [CL,CD] = DragSLF(dV(kk),W(end),h(end),S,f);
            E(kk) = CL/CD;
            if E(kk) == max(E)
                index = kk;
            end
        end
        V(1) = dV(index);
        clear E index
        
    elseif opt == 2
        
                dV = 60:120;
        
        for kk = 1:length(dV)
            [CL,CD] = DragSLF(dV(kk),W(end),h(end),S,f);
            E32(kk) = CL^1.5/CD;
            if E32(kk) == max(E32)
                index = kk;
            end
        end
        V(1) = dV(index);
        clear E32 index
end



dt = 10; % seconds
ii = 1;
    
    rho = density(h(ii));
    
    sigma = sigma0(h(ii));
    eta = TR640(V(ii)+Vw,Vc);
    P_max = P0*550*(sigma-(1-sigma)/7.55)*eta;
    V_fps = (V(ii)+Vw)*1.69;
       
    CL = W(ii)/(.5*rho*V_fps^2*S);
    CD = f(1)*(CL)^2 + f(2)*CL + f(3);
    D = .5*rho*V_fps^2*S*CD;
    P_req = D*V_fps;
    P_hp = P_req/550;
    throttle = P_req/P_max;
    P_eng = P_max*throttle/550

while x(ii)<x2
    
%     TSFC = fTSFC(h(ii),V(ii));
    
%     rho = density(h(ii));
    
%     sigma = sigma0(h(ii));
    P_in = P0*throttle*550;
    P_eng = P_in*(sigma-(1-sigma)/7.55);
    eta = TR640(V(ii)+Vw,Vc);
    P_avail = P_eng*eta;
    V_fps = (V(ii)+Vw)*1.69;
    
    
    CL = W(ii)/(.5*rho*V_fps^2*S);
    CD = f(1)*(CL)^2 + f(2)*CL + f(3);
    D = .5*rho*V_fps^2*S*CD;
    P_req = D*V_fps;
    
    df = PSFC*P_eng/550*(dt/3600);
    
%     PSFC(ii) = df*3600/(dt*P_eng/550);
    
    dV = (P_avail-P_req)*dt/(W(ii)*3600);
    if dV>0.5*dt/3600
        throttle = throttle-.005;
    elseif dV<-0.5*dt/3600
        if throttle <= .995
            throttle = throttle+.005;
        end
    else

    x(ii+1) = x(ii)+(V(ii)-Vw+.5*dV/1.69)*dt/3600;
    h(ii+1) = h(ii);
    
    if opt == 1
        
        dV = 60:120;
        
        for kk = 1:length(dV)
            [CL,CD] = DragSLF(dV(kk),W(end),h(end),S,f);
            E(kk) = CL/CD;
            if E(kk) == max(E)
                index = kk;
            end
        end
        V(ii+1) = dV(index);
        clear E index
        
    elseif opt == 2
        
                dV = 60:120;
        
        for kk = 1:length(dV)
            [CL,CD] = DragSLF(dV(kk),W(end),h(end),S,f);
            E32(kk) = CL^1.5/CD;
            if E32(kk) == max(E32)
                index = kk;
            end
        end
        V(ii+1) = dV(index);
        clear E32 index
    else
        
        V(ii+1) = V(ii)+dV/1.69;
        
    end
    
    
    W(ii+1) = W(ii)-df;
    t(ii+1) = ii*dt;
    phi(ii+1) = throttle;
    
    %     if 60*x(end)/t(end)< .9*Vc
    %         disp('ERROR')
    %         break
    %     end
    
    ii = ii+1;
    if tlim>0
        if t(ii)/60 >= tlim
            break
        end
    end
    end
end
% 
% PSFC(ii) = PSFC(ii-1);
t = t/60;

end

