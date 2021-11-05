WS = 17;
AR = 18;
MTOW = 414; %lbf

lambda = linspace(0.6,1,10);
TW = linspace(0.1733,1,10);
Vh = 0.4;
Vv = 0.04;
% lh =
lv = 6.65;

for i = 1:length(TW)
    T(i) = MTOW * TW(i); %lbf
    S(i) = MTOW/WS;
    b(i) = sqrt(S(i)*AR);
    Cr(i) = (2*S(i))/(b(i)*(1+lambda(i)));
    Ct(i) = lambda(i)*Cr(i);
    c(i) = (Cr(i) + Ct(i))/2;
%     Sh(i) = (S(i)*c(i)*Vh)/lh;
    Sv(i) = (S(i)*b(i)*Vv)/lv;

end

    