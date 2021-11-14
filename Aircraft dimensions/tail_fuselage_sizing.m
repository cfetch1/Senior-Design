clc; clear; close all;

%{
Tail and Fuselage Sizing and Placement

Comments:
- Uses ratios calculated from existing UAS
- Ratios used in SENIOR DESIGN/Configuration/Tail Assessment
%}

%% Inputs

% Wing Area
S = 38.6697;

% Wing Chord
c = 1.6056;

% Wing Span
b = 24.0841;

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





