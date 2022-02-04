clc;clear;close all;
WS = 11.7;
AR = 15;
MTOW = 436; %lbf

% Taper ratio
lambda = 0.5;

% Power ratio
PW = 0.09;

% Tail Coefficient: Competitive Assesment
Vh = 0.4;
Vv = 0.04;
lh = 4;
lv = 4;
V_deg = 120;


% Tail Aspect ratio
AR_T_v = 3;
AR_T_h = 5;


% Geometry calculation
% wing
S = MTOW./WS;
b = sqrt(S.*AR);
Cr = (2*S)./(b.*(1+lambda));
Ct = lambda.*Cr;
c = (Cr + Ct)./2;

% Tail
Sh = (S.*c.*Vh)./lh;
Sv = (S.*b.*Vv)./lv;

b_t_h = sqrt(AR_T_h*Sh);
b_t_v = sqrt(AR_T_v*Sv);

% Equivalent V-Tail Dimension
b_v = sqrt(b_t_h^2 + b_t_v^2);

i = 1;
for a  = 30
    SV_v(i) = 2*Sh.*tand(a) + (2/3).*Sh.*tand(a);
%     SV_h = (b_v/tand(a))*c;
    Vv_update(i) = (SV_v(i).*lv)./(S.*b);
    i = i + 1;
end

% A_vtail = Sv + Sh;
% angle = atand(sqrt(Sv./Sh));


disp('Input Design Factor: ')
disp(['Aspect Ratio: ', num2str(AR), ' [/]'])
disp(['Wing Loading: ', num2str(WS), ' [/]'])
disp(['Taper Ratio : ', num2str(lambda(1)), ' [/]'])
disp('-----------------------')
disp('Derived Dimension: ')
disp(['Wing Span            : ', num2str(b(1)), ' [ft]'])
disp(['    Root Chord Length: ', num2str(Cr(1)), ' [ft]'])
disp(['25% Root Chord Length: ', num2str(Cr(1)/4), ' [ft]'])
disp(['     Tip Chord Length: ', num2str(Ct(1)), ' [ft]'])
disp([' 25% Tip Chord Length: ', num2str(Ct(1)/4), ' [ft]'])
disp(['            Wing Area: ', num2str(S(1)), ' [ft2]'])
disp(' ')

disp('Tail Dimensions')
disp(['   Vertical Tail Area: ', num2str(Sv(1)), ' [ft2]'])
disp([' Horizontal Tail Area: ', num2str(Sh(1)), ' [ft2]'])
disp(' ')

disp('V-Tail Dimensions')
disp(['V-Tail Span: ', num2str(b_v), ' [ft2]'])
disp(['V-Tail Angle: ', num2str(V_deg), ' [deg]'])
disp(['V-Tail Vertical Area: ', num2str(SV_v), ' [ft2]'])
disp(['Updated Vertical tail coefficeint: ', num2str(Vv_update), ' [/]'])


    