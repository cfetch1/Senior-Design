function[TW] = Service_Ceiling(WS, Vv, rho, k, CDmin)

% Austin Berg
% AERO 443
% October 17 2020
% Constraint Diagram
% T/W for a Service Ceiling
% Gudmundsson Chapter 3
% NOTE: Location where best ROC is 100 ft/min !

TW = zeros(size(WS));

for j = 1:length(WS)
TW(j) = Vv/(sqrt((2/rho)*WS(j)*sqrt(k/(3*CDmin)))) + 4*sqrt(k*CDmin/3);
end

end