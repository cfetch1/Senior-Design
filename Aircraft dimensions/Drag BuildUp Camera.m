close all; clear all; clc;

% Drag build-up for camera:
% rho = density at sea level
% cd = drag coefficient for oval
% A = frontal projection area of an oval
% v = velocity range from 60 to 150 knots (converted to m/s)
% D = parasitic drag

rho = 1.2753 ; %kg/m^3
cd = 0.59 ;
A = pi*(.220/2)*(.252/2) ; %m^2
v = [60:10:150]*(1/1.944) ; %m/s

D = cd*rho*(v^2)*A*.5 ;
