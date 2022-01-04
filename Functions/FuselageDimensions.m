close all
clear all
clc

r = .75;
L = 12;
dx = linspace(0,12,100);

f1 = polyfit([0,33.46/12],[0,r],2);
p1a = @(x) 2*polyval(f1,x)*pi;
p1b = @(x) polyval(f1,x)*(pi+2);
p1c = @(x) (1+sin(pi*(x-23.23/12)/(2*(33.46-23.23)/12)))*polyval(f1,x)*pi + cos(pi*(x-23.23/12)/(2*(33.46-23.23)/12))*polyval(f1,x)*2;
dc = 2.7*pi/12;
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
    
    if 24.76/12<=x && x<=(80.05+2.7)/12
        
        if x<=27.35/12
            p(ii) = (p(ii)-sin(pi*(x-24.76/12)/(2*(27.35-24.76)/12))*5.4/12)+dc*sin(pi*(x-24.76/12)/(2*(27.35-24.76)/12));
        elseif 27.35/12<x && x<80.05/12
            p(ii) = (p(ii)-5.4/12)+dc;
        else
            p(ii) = (p(ii)-cos(pi*(x-80.05/12)/(2*(82.75-80.05)/12))*5.4/12)+dc*cos(pi*(x-80.05/12)/(2*(82.75-80.05)/12));
        end
        
    end
    
    if p(ii)<0
        p(ii) = 0;
    end
    
    d(ii) = p(ii)/pi;
    

    
end

figure
hold on
plot(dx,p)

figure
hold on
plot(dx,d)

a = pi*(p2/(2*pi))^2;



