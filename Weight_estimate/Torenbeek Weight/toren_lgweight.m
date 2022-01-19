function [W_lg] = toren_lgweight(MTOW, k, A1, A2, B1, B2, C1, C2, D1, D2)
% Torenbeek landing gear weight, aka "alighting gear", for fixed lg

% W_lg = landing gear weight in lb
% w_main = main gear weight in lb
% w_nose = nose gear weight in lb
% MTOW in lb
% k = constant = 1.08 for high wing
% A1, A2, B1, B2, C1, etc etc = coefficient values from data table in book for fixed lg

A1 = 20;
A2 = 25;
B1 = 0.1;
B2 = 0.1;
C1 = 0.019;
C2 = 0.0024;
D1 = 1.5;
D2 = 2;
w_main = k*(A1 + B1*(MTOW^.75) + C1*MTOW + D1*(MTOW^(3/2))) ;
w_nose = k*(A2 + B2*(MTOW^.75) + C2*MTOW + D2*(MTOW^(3/2))) ;
W_lg = w_main + w_nose ;

end