close all
clear all
clc

r = .75;
L = 12;
dx = linspace(0,12,100);
x0 = .4978;
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
%     if x>= x0
    
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
%     
%     if 24.76/12<=x && x<=(80.05+2.7)/12
%         
%         if x<=27.35/12
%             p(ii) = (p(ii)-sin(pi*(x-24.76/12)/(2*(27.35-24.76)/12))*5.4/12)+dc*sin(pi*(x-24.76/12)/(2*(27.35-24.76)/12));
%         elseif 27.35/12<x && x<80.05/12
%             p(ii) = (p(ii)-5.4/12)+dc;
%         else
%             p(ii) = (p(ii)-cos(pi*(x-80.05/12)/(2*(82.75-80.05)/12))*5.4/12)+dc*cos(pi*(x-80.05/12)/(2*(82.75-80.05)/12));
%         end
%         
%     end
%     
    if p(ii)<0
        p(ii) = 0;
    end
%     end
    d(ii) = p(ii)/pi;
    

    
end

dy = linspace(0,max(p),10);
lim1 = zeros(10,1);
lim1(:,1) = 33.46/12;
lim2 = zeros(10,1);
lim2(:,1) = 89.04/12;
x1 = lim1(1)/2;
x2 = (lim1(1)+lim2(1))/2;
x3 = (L+lim2(1))/2;
y = .1*max(p);


figure
hold on
h = area(dx,p);
set(h(1),'FaceColor',[0 0 1],'FaceAlpha',0.2);
plot(lim1,dy,'k--');
plot(lim2,dy,'k--');
plot(dx,p,'color','b','linewidth',2)
text(x1,y,'S_A','FontSize',18); %,'BackgroundColor','w')
text(x2,y,'S_B','FontSize',18);%,'BackgroundColor','w')
text(x3,y,'S_C','FontSize',18);%,'BackgroundColor','w')
ax=gca;
ax.FontSize = 18;
xlabel('Distance along Fuselage [ft]')
ylabel('Perimeter [ft]')
ax.DataAspectRatio = [1 1 1];
ax.XAxis.Exponent = 0;
ax.YAxis.Exponent = 0;
ax.YTick = 0:1:20;
ax.XTick = 0:1:20;
ax.XAxis.MinorTick='on';
ax.YAxis.MinorTick='on';
ax.XAxis.MinorTickValues = 0:.5:20;
ax.YAxis.MinorTickValues = 0:.5:20;
axis([0,L,0,max(p)])
grid on
% figure
% hold on
% plot(dx,d)

% Spx0 = sum(p(1:end)*(dx(2)-dx(1)));
a1 = sum(p(1:24)*(dx(2)-dx(1)));
a2 = sum(p(25:63)*(dx(2)-dx(1)));
a3 = sum(p(64:100)*(dx(2)-dx(1)));
Scab = pi*r^2;
Cf = 4*10^-3;
F = 1.08;
S =  38.63;
u = 8*pi/180;
CD0 = Cf/S*(F*a1+a1+F*a3)+.004*Scab/S;
%(3.83*u*2.5*(pi*r^2))/S;
