function[TW] = Desired_Takeoff_Distance(WS, V_lof, g, Sg, q, CD_to, mu, MTOW)

% Austin Berg
% AERO 443
% October 17 2020
% Constraint Diagram
% T/W for a Desired Takeoff Distance
% Gudmundsson Chapter 3

TW = zeros(size(WS));

for j = 1:length(WS)
    S = WS(j)*MTOW;
    CL_to = MTOW/(q*S);
TW(j) = (V_lof^2)/(2*g*Sg) + q*CD_to/WS(j) + mu*(1-q*CL_to/WS(j));
end

end