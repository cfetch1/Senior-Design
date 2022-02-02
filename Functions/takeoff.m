function [x,h,V,W,t] = takeoff(h,V1,W1)

[~,~,rho] = ISA_english(0);
g=32.17;
CLmax = 1.5;
S = 38.63;
VR = sqrt(2*W1/(rho*S*CLmax));
[CL2,~] = DragSLF(VR/1.69,.995*W1,h,0);
mu = .08;
q = @(V) .5*rho*V^2;
W = W1;

Vlof = sqrt(2*W/(rho*S*CL2));

% L = @(V) q(V)*S*CL;

dt = 1;
h(1) = h;
t(1) =0;
if V1==0
    V1=0.1;
end
V(1)=V1;
x(1)=0;
W(1) = W;
ii=1;
% data(ii,:) = [0,0,0];
alpha = 1;
while V(ii)<Vlof
    %[CL,CD] = DragSLF(V(ii),W(ii),h,0);
    eta= TR640(V(ii),120/1.69);
    T = (40*550/V(ii))*eta;
    if V(ii)>=VR
        [CL,CD] = CLalpha(alpha);
        if alpha <5
        alpha = alpha + 1;
        end
    else
        [CL,CD] = CLalpha(0);
    end
    
    L = q(V(ii))*S*CL;
    D = q(V(ii))*S*CD;
    
    n = W(ii)-L;
    if n<0
        break
    else
        df = 7.14/3600;
        a = (g/W(ii))*((T-D)-n*mu);
        V(ii+1) = V(ii)+a*dt;
        t(ii+1) =t(ii)+dt;
        x(ii+1)=x(ii)+V(ii)*dt+.5*a*dt^2;
        W(ii+1) = W(ii)-6*df*dt/3600;
        h(ii+1) = h(ii);
        c = -3600*(W(ii+1)-W(ii))/(dt*T*V(ii)/550);
        data(ii,:) = [CL,CD,c];
        ii=ii+1;
    end
    Vlof = sqrt(2*W(ii)/(rho*S*CL));
end

% x=x/(5280*1.15);
% V=V*3600/5280;
% t=t/60;
% out = [(data(end,1)),(data(end,2)),(data(end,3))];
end

