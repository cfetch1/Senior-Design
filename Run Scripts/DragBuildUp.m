close all
clear all
clc

%% Wing Data from AVL

file = load('AVLdrag.csv');
%alpha = file(1,:);
CL_W = file(2,:);
CDi_W = file(3,:);
CD0_W = file(4,:);
CL_HT = file(5,:);
CDi_HT = file(6,:);
CD0_HT = file(7,:);
CD0_VT = file(8,:);

cd('C:\Users\grega\Documents\GitHub\Senior-Design\Functions')

%% Flight Conditions
alpha = 0;
V = 202.5;
h = 7000;
% V = 60:10:120; %kts
% V_fps = V*1.69;
[T,P,rho] = ISA_english(h);

%% Geometric Inputs

S = 38.63;
SA = 4.743;
SC = 12.2804;
Scab = 1.7671;
Spx0 = 40.2806;
alphaB0 = 0;
diaB = 1.5;
d_LG = [.4333,.4333,.4333];
w_LG = [1.125,1.125,1.125];
Scam = 1.136;
Srad = 45.8/144;
nT = 5;
tc_T = 3.25/(.5*(29.9+11.97));
cT = 29.92/12;
A = .3061;
V2 = .98;


%% Assumptions/Hand Calcs
Cf = 6.5*10^-3;
dCDS_cab = .004;
k = .91;
K = 10;
F = 1.08;
eta = .675;
CDC = .64;
CDS_LG = [.0029,.0029,.0029];
CDScam = .47;
FOScam = 0.8;
CDSrad = .47;
FOSrad = 0.2;

% Fuselage Lift - Drag
[CL_B,~,CD0_B,CDi_B] = FuselageLiftDrag(alpha,alphaB0,S,k,diaB,eta,CDC,Spx0,Cf,F,SA,SC,K,dCDS_cab,Scab);

% Landing Gear Drag
[CD] = LandingGearDrag(CDS_LG,d_LG,w_LG,S);

% (Gimbal) Camera Drag
[CDcam] = ShapeDrag(CDScam,Scam,S,FOScam);

% (Gimbal) Radar Drag
[CDrad] = ShapeDrag(CDSrad,Srad,S,FOSrad);

% Wing-Fuselage Interference Drag
[CD_WB] = .05*(CD0_B+CDi_B);
 
% Tail-Fuselage Interference Drag
[CD_WT] = TailFuselageInterference(nT,tc_T,cT,S);

% Air Intake Drag
CD_duct = DuctDrag(h,A,V,V*V2,S);

% Radar Interference
CD_BR = .05*CDrad;

% Camera Interference
CD_BC = .05*CDcam;
