clc;clear;close all;
WS = 16;
AR = 23;
MTOW = 414; %lbf

lambda = linspace(0.6,1,10);
TW = linspace(0.1733,1,10);
Vh = 0.4;
Vv = 0.04;
lh = 5.86;
lv = 6.65;

for i = 1:length(TW)
    T(i) = MTOW * TW(i); %lbf
    S(i) = MTOW/WS;
    b(i) = sqrt(S(i)*AR);
    Cr(i) = (2*S(i))/(b(i)*(1+lambda(i)));
    Ct(i) = lambda(i)*Cr(i);
    c(i) = (Cr(i) + Ct(i))/2;
    Sh(i) = (S(i)*c(i)*Vh)/lh;
    Sv(i) = (S(i)*b(i)*Vv)/lv;
end
disp('Input Design Factor: ')
disp(['Aspect Ratio: ', num2str(AR), ' [/]'])
disp(['Wing Loading: ', num2str(WS), ' [/]'])
disp([' Taper Ratio: ', num2str(lambda(1)), ' [/]'])
disp('-----------------------')
disp('Derived Dimension: ')
disp([' Wing Span: ', num2str(b(1)), ' [ft]'])
disp([' Root Chord Length: ', num2str(Cr(1)), ' [ft]'])
disp(['  25% Root Chord Length: ', num2str(Cr(1)/4), ' [ft]'])
disp(['  Tip Chord Length: ', num2str(Ct(1)), ' [ft]'])
disp(['  25% Tip Chord Length: ', num2str(Ct(1)/4), ' [ft]'])
disp(['         Wing Area: ', num2str(S(1)), ' [ft2]'])
disp(['Vertical Tail Area: ', num2str(Sv(1)), ' [ft2]'])
disp(['Horizontal Tail Area: ', num2str(Sh(1)), ' [ft2]'])



    