close all
clear all
clc

r = .75;
L = 12;
dx = linspace(0,12,1000);

f1 = polyfit([0,33.46/12],[0,r],2);
p1a = @(x) polyval(f1,x)*(pi+2);
p1b = @(x) sin(pi*x/(2*23.23/12))*2*polyval(f1,x)*pi + cos(pi*x/(2*23.23/12))*2*polyval(f1,x)*(pi+2);
p1c = @(x) 2*polyval(f1,x)*pi;
p2 = 2*r*pi;
f3 = polyfit([89.04/12,L],[r,0],2);
p3 = @(x) 2*polyval(f3,x)*pi;
clc
p = zeros(length(dx),1);
for ii = 1:length(dx)
    x = dx(ii);
    if x<= 15.73/12
        p(ii) = p1a(x);
    elseif x<=23.23/12
        p(ii) = p1b(x);
    elseif x<=33.46/12
        p(ii) = p1c(x);
    elseif x<=89.04/12
        p(ii) = p2;
    else 
        p(ii) = p3(x);
    end
    if p(ii)<0
        p(ii) = 0;
    end
end

figure
hold on
plot(dx,p)
