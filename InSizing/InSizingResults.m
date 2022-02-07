close all
clear 
clc
addpath('.\Functions')

range = linspace(550,800,4);
Vcruise = linspace(100,300,4);
for ii = 1:length(range)
    for jj = 1:length(Vcruise)
        [Wto,We,Wf,P,S,b,L_fuselage,c_root,c_tip,L_h,S_h,b_h,c_root_h,c_tip_h,L_v,S_v,b_v,c_root_v,c_tip_v] = InSizing(range(ii),Vcruise(jj));
        W(ii,jj) = Wto;
        Preq(ii,jj) = P;
    end
end

x1 = range;
x2 = Vcruise;
y = Preq;

xx1 = max(x1);
xx2 = max(x2);
yy = max(y);

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
hold on
plot(xc1(1,:),yc1(1,:),'k','linewidth',2);
plot(xc1(2,:),yc1(2,:),'k','linewidth',2);
plot(xc1(3,:),yc1(3,:),'k','linewidth',2);
plot(xc1(4,:),yc1(4,:),'k','linewidth',2);
% plot(xc1(5,:),yc1(5,:),'k','linewidth',2);
% plot(xc1(6,:),yc1(6,:),'k','linewidth',2);
% plot(xc1(7,:),yc1(7,:),'k','linewidth',2);
% plot(xc1(8,:),yc1(8,:),'k','linewidth',2);
plot(xc1(:,1),yc1(:,1),'k','linewidth',2);
plot(xc1(:,2),yc1(:,2),'k','linewidth',2);
plot(xc1(:,3),yc1(:,3),'k','linewidth',2);
plot(xc1(:,4),yc1(:,4),'k','linewidth',2);
% plot(xc1(:,5),yc1(:,5),'k','linewidth',2);
% plot(xc1(:,6),yc1(:,6),'k','linewidth',2);
% plot(xc1(:,7),yc1(:,7),'k','linewidth',2);
% plot(xc1(:,8),yc1(:,8),'k','linewidth',2);
axis([min(xc1(1,:)),max(xc1(end,:)),0,max(P)])