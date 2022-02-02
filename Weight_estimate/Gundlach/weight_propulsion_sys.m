function [W_prop_sys] = weight_propulsion_sys(Wengine)
%Gundlach
%This is for any remaing prop systems items, ie controls, oil, starte3rs,
%etc

%Variables
%Fprop=multiplication factor
    %This will range from .08-.35
Fprop=.1;
W_prop_sys=Fprop*Wengine;
end

