WS = 6;
AR = 14;
MTOW = 414; %lbf

lambda = linspace(0.6,1,10);
TW = linspace(0.1733,1,10);

for i = 1:length(TW)
    T(i) = MTOW * TW(i); %lbf
    S(i) = MTOW/WS;
    b(i) = sqrt(S(i)*AR);
    Cr(i) = (2*S(i))/(b(i)*(1+lambda(i)));
    Ct(i) = lambda(i)*Cr(i);
end

    