close all
clear all
clc

r = 2;
L = 21+1/12;
dx = linspace(0,L,100);
x0 = L*(.374+.533*5.5/L);
f1 = polyfit([0,5.5],[0,(1.5+r)/2],2);
p1 = @(x) 2*polyval(f1,x)*pi;
p2 = 2*r*pi;

f3 = polyfit([10,L],[r,0],2);
p3 = @(x) 2*polyval(f3,x)*pi;
clc
p = zeros(length(dx),1);
index = 0;
for ii = 1:length(dx)
    x = dx(ii);
%     if x>= x0
    
    if x<= 5.5
        p(ii) = p1(x);
    elseif x<=10
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
    if dx(ii)<=x0
        index = index+1;
    end

    
end
% 
% dy = linspace(0,max(p),10);
% lim1 = zeros(10,1);
% lim1(:,1) = 33.46/12;
% lim2 = zeros(10,1);
% lim2(:,1) = 89.04/12;
% x1 = lim1(1)/2;
% x2 = (lim1(1)+lim2(1))/2;
% x3 = (L+lim2(1))/2;
% y = .1*max(p);
% 
% 
% figure
% hold on
% h = area(dx,p);
% set(h(1),'FaceColor',[0 0 1],'FaceAlpha',0.2);
% plot(lim1,dy,'k--');
% plot(lim2,dy,'k--');
% plot(dx,p,'color','b','linewidth',2)
% text(x1,y,'S_A','FontSize',18); %,'BackgroundColor','w')
% text(x2,y,'S_B','FontSize',18);%,'BackgroundColor','w')
% text(x3,y,'S_C','FontSize',18);%,'BackgroundColor','w')
% ax=gca;
% ax.FontSize = 18;
% xlabel('Distance along Fuselage [ft]')
% ylabel('Perimeter [ft]')
% ax.DataAspectRatio = [1 1 1];
% ax.XAxis.Exponent = 0;
% ax.YAxis.Exponent = 0;
% ax.YTick = 0:1:20;
% ax.XTick = 0:1:20;
% ax.XAxis.MinorTick='on';
% ax.YAxis.MinorTick='on';
% ax.XAxis.MinorTickValues = 0:.5:20;
% ax.YAxis.MinorTickValues = 0:.5:20;
% axis([0,L,0,max(p)])
% grid on
% % figure
% % hold on
% % plot(dx,d)
% 
Spx0 = sum(p(1:index)*(dx(2)-dx(1)));
a1 = sum(p(1:26)*(dx(2)-dx(1)));
a2 = sum(p(27:47)*(dx(2)-dx(1)));
a3 = sum(p(48:100)*(dx(2)-dx(1)));
% Scab = pi*r^2;
% Cf = 4*10^-3;
% F = 1.08;
% S =  38.63;
% u = 8*pi/180;
% CD0 = Cf/S*(F*a1+a1+F*a3)+.004*Scab/S;
% %(3.83*u*2.5*(pi*r^2))/S;
