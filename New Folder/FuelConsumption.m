function [Wf] = FuelConsumption(P0,Vc,S,f,W1)


%% Global Inputs

% vehicle specs
Vp = Vc;

% mission parameters
Vw = 0;
d = 250;
dt_L = 180;
h_in = 18000;


%% Takeoff
W(1) = .98*W1;



%% Climb

dV = 60:120;
for kk = 1:length(dV)
    [CL,CD] = DragSLF(dV(kk),W(end),0,S,f);
    E(kk) = CL/CD;
    if E(kk) == max(E)
        clc
        xx = kk;
    end
end
VE = dV(xx);
clear E
[dx1,dh1,dV1,dW1,dt1] = fclimb(0,h_in,VE,W(end),P0,.85,Vp,S,f);
ii = length(dt1);
x(1:ii) = dx1;
h(1:ii) = dh1;
V(1:ii) = dV1;
W(1:ii) = dW1;
t(1:ii) = dt1;
index = ii;


%% Ingress

[dx2,dh2,dV2,dW2,dt2] = fcruise(d-x(end),h_in,Vc,Vw,W(end),P0,.75,Vp,S,f,0);
ii = index+length(dt2);
dx2 = x(end)+dx2;
dt2 = t(end)+dt2;
x(index+1:ii) = dx2;
h(index+1:ii) = dh2;
V(index+1:ii) = dV2;
W(index+1:ii) = dW2;
t(index+1:ii) = dt2;
index = ii;


%% Loiter

for kk = 1:length(dV)
    [CL,CD] = DragSLF(dV(kk),W(end),4000,S,f);
    E(kk) = CL^1.5/CD;
    if E(kk) == max(E)
        clc
        xx = kk;
    end
end
Vs = dV(xx);
clear E
[~,dh3,dV3,dW3,dt3] = fcruise(1000,4000,Vs,Vw,W(end),P0,.5,Vp,S,f,dt_L);
ii = index+length(dt3);
dx3 = zeros(length(dt3),1);
dx3(:,1) = x(end);
dt3 = t(end)+dt3;
x(index+1:ii) = dx3;
h(index+1:ii) = dh3;
V(index+1:ii) = dV3;
W(index+1:ii) = dW3;
t(index+1:ii) = dt3;
index = ii;

%% Egress

for kk = 1:length(dV)
    [CL,CD] = DragSLF(dV(kk),W(end),4000,S,f);
    E(kk) = CL/CD;
    if E(kk) == max(E)
        clc
        xx = kk;
    end
end
Vr = dV(xx);
clear E
[dx4,dh4,dV4,dW4,dt4] = fcruise(d,4000,Vr,Vw,W(end),P0,.65,Vp,S,f,0);
ii = index+length(dt4);
dx4 = x(end)+dx4;
dt4 = t(end)+dt4;
x(index+1:ii) = dx4;
h(index+1:ii) = dh4;
V(index+1:ii) = dV4;
W(index+1:ii) = dW4;
t(index+1:ii) = dt4;
index = ii;

t=t/60;
dt1 = dt1/60;
dt2 = dt2/60;
dt3 = dt3/60;
dt4 = dt4/60;


W(end) = W(end)*.99;

Wf = (1.25)*(W1-W(end));

end

