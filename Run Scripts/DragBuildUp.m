close all
clear all
clc

cd('C:\Users\grega\Documents\GitHub\Senior-Design\Functions')

% Fuslegae Lift - Drag
[CL,CD] = FuselageLiftDrag(alpha,alphaB0,S,k,D,eta,CDC,Spx0,Cf,F,SA,SC,K,dCDS,Scab);

% Landing Gear Drag
[CD] = LandingGearDrag(CDS,d,w,S);

% (Gimbal) Camera Drag
[CD] = CameraDrag(CDS,SN,S,FOS);

% Wing-Fuselage Interference Drag
[CD] = WingFuselageInterference(CD0,CDi);

% Wing-Nacelle Interference Drag
[CD] = WingNacelleInterference(CD0,CDi,n);

% Tail-Fuselage Interference Drag
[CD] = TailFuselageInterference(n,tc,cj,S);

% Air Intake Drag
[CD] = DuctDrag(h,Pprop,eta,V,S)