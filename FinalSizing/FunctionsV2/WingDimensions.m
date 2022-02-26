function [L_fuselage,c_root,c_tip,L_h,S_h,b_h,c_root_h,c_tip_h,L_v,S_v,b_v,c_root_v,c_tip_v] = WingDimensions(S,b,c)
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
L_h_ratio = .52;

% L_v/L_fuselage
L_v_ratio = .52;

% b/L_fuselage
b_L_ratio = 2;

% S_h/S
% S_h_ratio = .22;


%% Outputs

% Fuselage Length
L_fuselage = b/b_L_ratio;

% Horizontal Tail Distance
L_h = L_fuselage*L_h_ratio;

% Vertical Tail Distance
L_v = L_fuselage*L_v_ratio;

% Horizontal Tail Area (using V_h)
S_h = (V_h*c*S)/L_h;

% Horizontal Tail Area for comparison (using S_h_ratio)
% S_h_test = S*S_h_ratio;

% Vertical Tail Area (using V_v)
S_v = (V_v*b*S)/L_h;


% Root and tip chords
c_root = (2*c)/(1+lambda);
c_tip = c_root*lambda;

% Root and tip chords for horizontal tail
b_h = sqrt(AR_h*S_h);
c_h = b_h/AR_h;
c_root_h = (2*c_h)/(1+lambda_h);
c_tip_h = c_root_h*lambda_h;

% Root and tip chords for vertical tail
b_v = sqrt(AR_v*S_v);
c_v = b_v/AR_v;
c_root_v = (2*c_v)/(1+lambda_v);
c_tip_v = c_root_v*lambda_v;





end

