function[TW] = Desired_Cruise_Airspeed(WS, q, CDmin, k)

% Austin Berg
% AERO 443
% October 17 2020
% Constraint Diagram
% T/W for a Desired Cruise Airspeed
% Gudmundsson Chapter 3

TW = zeros(size(WS));

for j = 1:length(WS)
TW(j) = q*CDmin*(1/WS(j))+k*(1/q)*WS(j);
end

end