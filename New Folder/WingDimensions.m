function [S,b,c,P,L_fuselage,c_root,c_tip,L_h,S_h,b_h,c_root_h,c_tip_h,L_v,S_v,b_v,c_root_v,c_tip_v,c_T] = WingDimensions(MTOW,AR,WS,PW)

P = PW*MTOW; %shaft horsepower
S = MTOW/WS; %planform area, ft^2
c = sqrt(S/AR);
b = S/c;

lambda = .5;

% Horizontal Tail AR
AR_h = 4.1;
% Horizontal Tail Taper Ratio
lambda_h = .8;

% Vertical Tail AR
AR_v = 2.15;
% Vertical Tail Taper Ratio
lambda_v = .762;

% V_h
V_h = .4;

% V_v
V_v = .04;

% L_h/L_fuselage
L_h_ratio = .42;

% L_v/L_fuselage
L_v_ratio = .42;

% b/L_fuselage
b_L_ratio = 2;

% S_h/S
% S_h_ratio = .22;


%% Outputs

% Fuselage Length
L_fuselage = b/b_L_ratio;
%L_fuselage= 12;

% Horizontal Tail Distance
L_h = 42/12; %L_fuselage*L_h_ratio;

% Vertical Tail Distance
L_v = 42/12; %L_fuselage*L_v_ratio;

Sw = S*144;
cw  = sqrt(Sw/AR);
c_tip = (2/3)*cw;
c_root = (4/3)*cw;
bw = Sw/cw;
Vh = .4;
Vv = .04;
ARh = 2.4;
lt = L_h*12';
lambda = 2/3;

r1 = @(beta) (sqrt(Vh*Sw*cw*ARh/(4*lt)))/cosd(beta);
r2 = @(beta) (Vv*bw*sqrt(Sw*ARh/(cw*lt*Vh)))/(2*sind(beta)+1/2);
beta = fzero( @(beta) r1(beta)-r2(beta),45);
r = r1(beta);

b_h = 2*r*cosd(beta);
ct = @(cr) 2*cr*(1+lambda+lambda^2)/(3*(1+lambda));
ct_root = fzero( @(cr) ct(cr)-b_h/ARh, r/2);
ct_tip = ct_root*lambda;

c_root_h = ct_root;
c_tip_h = ct_tip;
c_root_v = ct_root;
c_tip_v = ct_tip;

S_h = b_h*ct(ct_root);
Vhc = S_h*lt/(Sw*cw);

b_v = r*(2*sind(beta)+1/2);
S_v = b_v*ct(ct_root);
Vvc = S_v*lt/(Sw*bw);

lt_mac = lt +.25*ct(ct_root);
y_ = (r*(1+2*lambda)/(3*(1+lambda)));
psi = atand(r/(ct_root+ct_tip)/8);
lt_sw_le = lt + y_*tand(psi) - .25*ct_root;
lt_sw_te = lt + y_*tand(psi) + .75*ct_root;


c_root = c_root/12;
c_tip = c_tip/12;
S_h = S_h/144;
b_h = b_h/12;
c_root_h = c_root_h/12;
c_tip_h = c_tip_h/12;
S_v = S_v/144;
b_v = b_v/12;
c_root_v = c_root_v/12;
c_tip_v = c_tip_v/12;
c_T = ct(ct_root)/12;

end

