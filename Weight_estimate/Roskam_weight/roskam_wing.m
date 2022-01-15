function [W_w] = roskam_wing(MTOW, S, AR)
%MTOW= takeoff weight
%S= wing area in ft^2
%n_ult=design ultimate load factor
%A= aspect ratio
n_ult=1.5;
W_w = (0.04674*(MTOW^0.397))*(S^0.360)*(n_ult^0.397)*(AR^1.712) ;
end