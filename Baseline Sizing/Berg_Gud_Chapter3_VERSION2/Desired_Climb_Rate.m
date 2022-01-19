function[TW] = Desired_Climb_Rate(WS,Vv, V, q, CDmin, k)

% Austin Berg
% AERO 443
% October 17 2020
% Constraint Diagram
% T/W for a Desired Climb Rate
% Gudmundsson Chapter 3

TW = zeros(size(WS));

for j = 1:length(WS)
TW(j) = Vv/V + (q/(WS(j)))*CDmin + (k/q)*(WS(j));
end

end