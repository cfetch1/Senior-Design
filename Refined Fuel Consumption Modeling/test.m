close all
clear
clc

addpath('..\Functions')
for d = 200:50:400
%% Global Inputs
P0 = 65;
Vp = 180;
Vc = 180;
S = 38.63;
f = [0.0212, -0.0022, 0.0282];
k = sqrt(.5*(f(1)+f(2)));
CD0 = f(3);
Vw = 0;
W1 = 600;


%% Takeoff



%% Climb

rho = (density(0)+density(9000))/2;
VE = (sqrt((2*W1/(rho*S)))*(k/(CD0))^.25)/1.69;
[dx,dh,dV,dW,dt] = fclimb(0,9000,VE,W1,P0,.85,Vp,S,f);
ii = length(dt);
x(1:ii) = dx;
h(1:ii) = dh;
V(1:ii) = dV;
W(1:ii) = dW;
t(1:ii) = dt;
index = ii;
clear dx dh dV dW dt ii

%% Cruise 1

[dx,dh,dV,dW,dt] = fcruise(d-x(end),h(end),Vc,Vw,W(end),P0,.85,Vp,S,f);
ii = index+length(dt);
x(index+1:ii) = dx;
h(index+1:ii) = dh;
V(index+1:ii) = dV;
W(index+1:ii) = dW;
t(index+1:ii) = t(index)+dt;
index = ii;
clear dx dh dV dW dt ii

%% Descend?

%% Search

r = 7*t(end)/60;
rho = density(2000);
Vs = (sqrt((2*W(end)/(rho*S)))*(k/(3*CD0))^.25)/1.69;
[~,dh,dV,dW,dt] = fturn(2000,Vs,Vw*.5,W(end),P0,.6,Vp,S,f,1.5,180);
ii = index+length(dt);
x(index+1:ii) = x(end);
h(index+1:ii) = dh;
V(index+1:ii) = dV;
W(index+1:ii) = dW;
t(index+1:ii) = t(index)+dt;
index = ii;
clear dx dh dV dW dt ii

r = 7*t(end)/60;
Vs = (sqrt((2*W(end)/(rho*S)))*(k/(3*CD0))^.25)/1.69;
[~,dh,dV,dW,dt] = fcruise(2*r,h(end),Vs,Vw,W(end),P0,.6,Vp,S,f);
ii = index+length(dt);
x(index+1:ii) = x(end);
h(index+1:ii) = dh;
V(index+1:ii) = dV;
W(index+1:ii) = dW;
t(index+1:ii) = t(index)+dt;
index = ii;
clear dx dh dV dW dt ii

r = 7*t(end)/60;
Vs = (sqrt((2*W(end)/(rho*S)))*(k/(3*CD0))^.25)/1.69;
[~,dh,dV,dW,dt] = fturn(2000,Vs,Vw*.5,W(end),P0,.6,Vp,S,f,1.5,180);
ii = index+length(dt);
x(index+1:ii) = x(end);
h(index+1:ii) = dh;
V(index+1:ii) = dV;
W(index+1:ii) = dW;
t(index+1:ii) = t(index)+dt;
index = ii;
clear dx dh dV dW dt ii

r = 7*t(end)/60;
Vs = (sqrt((2*W(end)/(rho*S)))*(k/(3*CD0))^.25)/1.69;
[~,dh,dV,dW,dt] = fcruise(2*r,h(end),Vs,Vw,W(end),P0,.75,Vp,S,f);
ii = index+length(dt);
x(index+1:ii) = x(end);
h(index+1:ii) = dh;
V(index+1:ii) = dV;
W(index+1:ii) = dW;
t(index+1:ii) = t(index)+dt;
index = ii;
clear dx dh dV dW dt ii

r = 7*t(end)/60;
Vs = (sqrt((2*W(end)/(rho*S)))*(k/(3*CD0))^.25)/1.69;
[~,dh,dV,dW,dt] = fturn(2000,Vs,Vw*.5,W(end),P0,.6,Vp,S,f,1.5,180);
ii = index+length(dt);
x(index+1:ii) = x(end);
h(index+1:ii) = dh;
V(index+1:ii) = dV;
W(index+1:ii) = dW;
t(index+1:ii) = t(index)+dt;
index = ii;
clear dx dh dV dW dt ii

r = 7*t(end)/60;
Vs = (sqrt((2*W(end)/(rho*S)))*(k/(3*CD0))^.25)/1.69;
[~,dh,dV,dW,dt] = fcruise(2*r,h(end),Vs,Vw,W(end),P0,.75,Vp,S,f);
ii = index+length(dt);
x(index+1:ii) = x(end);
h(index+1:ii) = dh;
V(index+1:ii) = dV;
W(index+1:ii) = dW;
t(index+1:ii) = t(index)+dt;
index = ii;
clear dx dh dV dW dt ii

t2T = t(end);

% 
% 
% 
% 
% 
% r = 7*t(end)/60;
% rho = density(2000);
% Vs = (sqrt((2*W(end)/(rho*S)))*(k/(3*CD0))^.25)/1.69;
% [~,dh,dV,dW,dt] = fturn(2000,Vs,Vw*.5,W(end),P0,.6,Vp,S,f,1.5,180);
% ii = index+length(dt);
% x(index+1:ii) = x(end);
% h(index+1:ii) = dh;
% V(index+1:ii) = dV;
% W(index+1:ii) = dW;
% t(index+1:ii) = t(index)+dt;
% index = ii;
% clear dx dh dV dW dt ii
% 
% r = 7*t(end)/60;
% Vs = (sqrt((2*W(end)/(rho*S)))*(k/(3*CD0))^.25)/1.69;
% [~,dh,dV,dW,dt] = fcruise(2*r,h(end),Vs,Vw,W(end),P0,.6,Vp,S,f);
% ii = index+length(dt);
% x(index+1:ii) = x(end);
% h(index+1:ii) = dh;
% V(index+1:ii) = dV;
% W(index+1:ii) = dW;
% t(index+1:ii) = t(index)+dt;
% index = ii;
% clear dx dh dV dW dt ii
% 
% r = 7*t(end)/60;
% Vs = (sqrt((2*W(end)/(rho*S)))*(k/(3*CD0))^.25)/1.69;
% [~,dh,dV,dW,dt] = fturn(2000,Vs,Vw*.5,W(end),P0,.6,Vp,S,f,1.5,180);
% ii = index+length(dt);
% x(index+1:ii) = x(end);
% h(index+1:ii) = dh;
% V(index+1:ii) = dV;
% W(index+1:ii) = dW;
% t(index+1:ii) = t(index)+dt;
% index = ii;
% clear dx dh dV dW dt ii
% 
% r = 7*t(end)/60;
% Vs = (sqrt((2*W(end)/(rho*S)))*(k/(3*CD0))^.25)/1.69;
% [~,dh,dV,dW,dt] = fcruise(2*r,h(end),Vs,Vw,W(end),P0,.75,Vp,S,f);
% ii = index+length(dt);
% x(index+1:ii) = x(end);
% h(index+1:ii) = dh;
% V(index+1:ii) = dV;
% W(index+1:ii) = dW;
% t(index+1:ii) = t(index)+dt;
% index = ii;
% clear dx dh dV dW dt ii
% 
% r = 7*t(end)/60;
% Vs = (sqrt((2*W(end)/(rho*S)))*(k/(3*CD0))^.25)/1.69;
% [~,dh,dV,dW,dt] = fturn(2000,Vs,Vw*.5,W(end),P0,.6,Vp,S,f,1.5,180);
% ii = index+length(dt);
% x(index+1:ii) = x(end);
% h(index+1:ii) = dh;
% V(index+1:ii) = dV;
% W(index+1:ii) = dW;
% t(index+1:ii) = t(index)+dt;
% index = ii;
% clear dx dh dV dW dt ii
% 
% r = 7*t(end)/60;
% Vs = (sqrt((2*W(end)/(rho*S)))*(k/(3*CD0))^.25)/1.69;
% [~,dh,dV,dW,dt] = fcruise(2*r,h(end),Vs,Vw,W(end),P0,.75,Vp,S,f);
% ii = index+length(dt);
% x(index+1:ii) = x(end);
% h(index+1:ii) = dh;
% V(index+1:ii) = dV;
% W(index+1:ii) = dW;
% t(index+1:ii) = t(index)+dt;
% index = ii;
% clear dx dh dV dW dt ii
% 
% 
% [dx,dh,dV,dW,dt] = fcruise(d/2,h(end),Vc,Vw,W(end),P0,.85,Vp,S,f);
% ii = index+length(dt);
% x(index+1:ii) = dx;
% h(index+1:ii) = dh;
% V(index+1:ii) = dV;
% W(index+1:ii) = dW;
% t(index+1:ii) = t(index)+dt;
% index = ii;
% clear dx dh dV dW dt ii
% 
% 







%% Descend?

%% Loiter (Surveillance)

rho = density(2000);
Ve = (sqrt((2*W(end)/(rho*S)))*(k/(3*CD0))^.25)/1.69;
[~,dh,dV,dW,dt] = fturn(2000,Ve,Vw*.5,W(end),P0,.6,Vp,S,f,1.2,360*4);
ii = index+length(dt);
x(index+1:ii) = x(end);
h(index+1:ii) = dh;
V(index+1:ii) = dV;
W(index+1:ii) = dW;
t(index+1:ii) = t(index)+dt;
index = ii;
clear dx dh dV dW dt ii

%% Climb?

rho = (density(2000)+density(9000))/2;
VE = (sqrt((2*W(end)/(rho*S)))*(k/(CD0))^.25)/1.69;
[dx,dh,dV,dW,dt] = fclimb(2000,9000,VE,W(end),P0,.85,Vp,S,f);
ii = index+length(dt);
x(index+1:ii) = x(index)+dx;
h(index+1:ii) = dh;
V(index+1:ii) = dV;
W(index+1:ii) = dW;
t(index+1:ii) = t(index)+dt;
index = ii;
clear dx dh dV dW dt ii

%% Cruise 2

rho = density(9000);
Vr = (sqrt((2*W(end)/(rho*S)))*(k/(CD0))^.25)/1.69;
[dx,dh,dV,dW,dt] = fcruise(d*1.5,9000,Vr,Vw,W(end),P0,.75,Vp,S,f);
ii = index+length(dt);
x(index+1:ii) = x(index)+dx;
h(index+1:ii) = dh;
V(index+1:ii) = dV;
W(index+1:ii) = dW;
t(index+1:ii) = t(index)+dt;
index = ii;
clear dx dh dV dW dt ii


%% Descent/Landing


Wf = (W(end)-W(1))*1.25;
X = x(end)+18*r

end
