function[TW] = Level_Constant_Velocity_Turn(WS, CDmin, k, q, n)

% Austin Berg
% AERO 443
% October 17 2020
% Constraint Diagram
% T/W for a Level Constant-Velocity Turn 
% Gudmundsson Chapter 3

TW = zeros(size(WS));

for j = 1:length(WS)
TW(j) = q*[CDmin/WS(j) + k*((n/q)^2)*WS(j)];
end

end
