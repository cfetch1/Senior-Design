function [W_fuse] = weight_fuselage(W_feq,VeqMax,Ltot)

%Fuselage Sizing from Gundlach using parametric solution
%Most data from sail planes which is closeish to us
%Error is 29.6%
%For 1-800,000lb
%curve fit method
%Variables that can be changed
%Fmg=main gear
    %1=no main gear on fuselage
    %1.07 meain gear on fuselage
%Fpress= pressurization
    %1=unpressurized
    %1.08 = pressurized
%Fng=nose gear
    %1= no nose gear on fuselage
    %1.04 = nose gear on fuselage
%Fvt= vertical tail fuselage factor
    %1= vertical tail weight not included
    %1.1 vertical tail weight included
%Fmat=materials factor
    %1=carbon fiber or metal
    %2=fiberglass or unknown

%Inputs
%L_struct=structural fuselage length in feet
%Wcar=weight of components carried within the structure
%Nz=load factor in [g]
%VeqMax=max equivalent velocity
%Variables

%Output
%W_fuse=fuselage weight [lbs]

Fmg=1;
Fng=1;
Fpress=1;
Fvt=1.1;
Fmat=1;
Nz=1.5;
W_fuse=.5257*Fmg*Fng*Fpress*Fvt*Fmat*(Ltot^.3796)*((W_feq*Nz)^.4863)*VeqMax^2;

end

