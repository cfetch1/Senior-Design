close all
clear all
clc
addpath('C:\Users\grega\Documents\GitHub\Senior-Design\Functions')
Ecruise = 10:1:18;
size= 10;
SFC = .3:.025:.5;
Wtoguess = 300;
res = 0;
for i = 1:length(Ecruise)
    for j = 1:length(SFC)
        err=1000;
        while err>1
Wpl=50;
% Wpl_ = 40:5:100;
% for i = 1:length(Wpl_)
% Wpl = Wpl_(i);

% Ecruise = 18;
% SFCcruise = .4;
Range = 550;
% Eloiter = 18;
% SFCloiter = .4;
Endurance = 1;

hcr = 9000;
h=hcr;
Vcl = 100;
ROC = 500;
% SFCclimb = .5;
eta_cl = .62;
eta_cr = .83;
% Eclimb = 17;

[MTOW,We,Wf,EWF,Wrs]=RangeSizing(50,400,550,1,[Ecruise(i)*1.1093,Ecruise(i),Ecruise(i)*1.5981],[.94*SFC(j),SFC(j),.81*SFC(j)],[100,120,80],ROC,h,[.62,.83],1.1,res);
res = Wf*.25;
err=100*abs(MTOW-Wtoguess)/MTOW;

Wtoguess=MTOW;
% x(i) = Wpl;
% y(i) = MTOW;
% end
% 
% figure
% hold on
% plot(x,y)
% xlabel('Payload Weight [lbs]')
% ylabel('MTOW [lbs]')
% grid on
        end
x1(i) = Ecruise(i);
x2(j) = SFC(j);
y(i,j) = MTOW;
    end

end
xx1 = 14.6;
xx2 = 0.4;
yy = 439;




offset = 1;

% if( nargin < 5 )
%   nref = 0;
% end
% 
% % Handle default line styles.
% if( nargin < 6 )
%   linspec1 = 'k';
% end
% 
% if( nargin < 7 )
%   linspec2 = linspec1;
% end

% If input is not matrix similar to meshgrid, make it so.
if( isvector(x1) && isvector(x2) )
  [X1,X2] = meshgrid( x1, x2 );
else
  X1 = x1;
  X2 = x2;
end

% Calculate the cheater axis.
Xcheat = X1 + X2 * offset;

XX = xx1+xx2*offset;

xc1 = Xcheat(1:0+1:end,:)';
yc1 = y(1:0+1:end,:)';

xc2 =  Xcheat(:,1:0+1:end);
yc2 = y(:,1:0+1:end);

dx = [x1,x2];
xmin = min(dx);
xmax = max(dx);

ymin = min(y);
ymax = max(y);

figure
hold all
E5 = plot(xc1(1,:),yc1(1,:),'k','linewidth',2);
E4 = plot(xc1(3,:),yc1(3,:),'k','linewidth',2);
E3 = plot(xc1(5,:),yc1(5,:),'k','linewidth',2);
E2 = plot(xc1(7,:),yc1(7,:),'k','linewidth',2);
E1 = plot(xc1(9,:),yc1(9,:),'k','linewidth',2);
text2line(E1,.2,0,'L/D=10',size)
text2line(E2,.2,0,'L/D=12',size)
text2line(E3,.2,0,'L/D=14',size)
text2line(E4,.2,0,'L/D=16',size)
text2line(E5,.2,0,'L/D=18',size)
c5 = plot(xc2(1,:),yc2(1,:),'k','linewidth',2);
c4 = plot(xc2(3,:),yc2(3,:),'k','linewidth',2);
c3 = plot(xc2(5,:),yc2(5,:),'k','linewidth',2);
c2 = plot(xc2(7,:),yc2(7,:),'k','linewidth',2);
c1 = plot(xc2(9,:),yc2(9,:),'k','linewidth',2);
text2line(c1,.85,0,'SFC=.30',size)
text2line(c2,.85,0,'SFC=.35',size)
text2line(c3,.85,0,'SFC=.40',size)
text2line(c4,.85,0,'SFC=.45',size)
text2line(c5,.85,0,'SFC=.50',size)
ylabel('MTOW [lbs]')
ax=gca;
ax.YTick = 0:50:1000;
ax.XTick = 0:1000:1000;
ax.YAxis.MinorTick='on';
ax.YAxis.MinorTickValues = 0:10:800;
ax.FontSize = 14;
pbaspect([1.0000    0.7882    0.7882])

grid on




