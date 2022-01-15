function [W_w] = roskam_wing(MTOW, S, n_ult, A)
%MTOW= takeoff weight
%S= wing area in ft^2
%n_ult=design ultimate load factor
%A= aspect ratio

W_w = (0.04674*(MTOW^0.397))*(S^0.360)*(n_ult^0.397)*(A^1.712) ;
end