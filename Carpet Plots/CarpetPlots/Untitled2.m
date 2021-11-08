% close all
% clear all
% clc
% 
% Emax = 12:1:20;
% SFCcruise = .4:.025:.6;
% for i = 1:length(Emax)
%     for j = 1:length(SFCcruise)
% 
% %INPUTS
% Wpl = 60; % payload weight, lb
% Wtoguess = 300; % MTOW, lb
% Vcruise = 120; % cruise speed, kt
% Range = 550; % range, nm
% Eloiter = Emax(i)/.866;
% SFCloiter = SFCcruise(j)*.9; % Fuel consumption during loiter (lb/(lb*hr))
% Endurance = 1; % time spent in loiter phase, hr
% reserve = .5*140/6; % Reserve fuel, lb
% 
% type = 1;
% 
% [Wto, We, Wf]=weight_estimator_cus(Wpl,Wtoguess,Emax(i),SFCcruise(j),Vcruise,Range,Eloiter,SFCloiter,Endurance,reserve,type);
% MTOW = (We+Wf+Wpl);
% 
% x1(i) = Emax(i);
% x2(j) = SFCcruise(j);
% y(i,j) = MTOW;
%     end
% 
% end
% 
% 
% offset = 10;
% 
% % if( nargin < 5 )
% %   nref = 0;
% % end
% % 
% % % Handle default line styles.
% % if( nargin < 6 )
% %   linspec1 = 'k';
% % end
% % 
% % if( nargin < 7 )
% %   linspec2 = linspec1;
% % end
% 
% % If input is not matrix similar to meshgrid, make it so.
% if( isvector(x1) && isvector(x2) )
%   [X1,X2] = meshgrid( x1, x2 );
% else
%   X1 = x1;
%   X2 = x2;
% end
% 
% % Calculate the cheater axis.
% Xcheat = X1 + X2 * offset;
% 
% xc1 = Xcheat(1:0+1:end,:)';
% yc1 = y(1:0+1:end,:)';
% 
% xc2 =  Xcheat(:,1:0+1:end);
% yc2 = y(:,1:0+1:end);
% 
% dx = [x1,x2];
% xmin = min(dx);
% xmax = max(dx);
% 
% ymin = min(y);
% ymax = max(y);

figure
hold all
E5 = plot(xc1(1,:),yc1(1,:),'k','linewidth',2);
E4 = plot(xc1(3,:),yc1(3,:),'k','linewidth',2);
E3 = plot(xc1(5,:),yc1(5,:),'k','linewidth',2);
E2 = plot(xc1(7,:),yc1(7,:),'k','linewidth',2);
E1 = plot(xc1(9,:),yc1(9,:),'k','linewidth',2);
text2line(E1,.2,0,'L/D=12')
text2line(E2,.2,0,'L/D=14')
text2line(E3,.2,0,'L/D=16')
text2line(E4,.2,0,'L/D=18')
text2line(E5,.2,0,'L/D=20')
c5 = plot(xc2(1,:),yc2(1,:),'k','linewidth',2);
c4 = plot(xc2(3,:),yc2(3,:),'k','linewidth',2);
c3 = plot(xc2(5,:),yc2(5,:),'k','linewidth',2);
c2 = plot(xc2(7,:),yc2(7,:),'k','linewidth',2);
c1 = plot(xc2(9,:),yc2(9,:),'k','linewidth',2);
text2line(c1,.85,0,'SFC=.40')
text2line(c2,.85,0,'SFC=.45')
text2line(c3,.85,0,'SFC=.50')
text2line(c4,.85,0,'SFC=.55')
text2line(c5,.85,0,'SFC=.60')
ylabel('MTOW [lbs]')
ax=gca;
ax.XAxis.Exponent = 0;
% ax.YAxis.Exponent = 0;
% ax.YTick = 0:5000:30000;
ax.XTick = 0:100:1000;
ax.XAxis.MinorTick='off';
ax.YAxis.MinorTick='on';
ax.XAxis.MinorTickValues = 0:25:1000;
%ax.YAxis.MinorTickValues = 0:500:30000;
grid on



%h=carpet(x1,x2,y,1)
