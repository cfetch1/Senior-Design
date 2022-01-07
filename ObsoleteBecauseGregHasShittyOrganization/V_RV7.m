function [V] = V_RV7(h)
% outputs vector of possible airspeeds [TAS,mph] for a given height [hp,ft]

%% now kts

f1 = [8.15850815850814e-08,0.000686480186480190,39.4405594405594];
V1 = (f1(1)*h^2+f1(2)*h+f1(3))/1.15;
f2 = [-6.84731934731942e-08, 0.000119463869463884, 160.209790209790];
V2 = (f2(1)*h^2+f2(2)*h+f2(3))/1.15;

%V = 5*(.5*round(V1/5):round(.5*V2/5));
V = 60:5:5*round(.75*V2/5);

end

