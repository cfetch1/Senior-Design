function [xc1,xc2,yc1,yc2] = Carpet(x1,x2,y,xv1,xv2,xu1,xu2,yl,offset,d1,d2)

xx1 = max(x1);
xx2 = max(x2);
yy = max(y);

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

dx = [xc1,xc2];
xmin = min(dx);
xmin = .95*min(xmin);
xmax = max(dx);
xmax = 1.05*max(xmax);

ymin = min(yc1);
ymin = .95*min(ymin);
ymax = max(yc1);
ymax = 1.05*max(ymax);

figure
hold on
i1 = plot(xc1(:,1),yc1(:,1),'k','linewidth',2);
i2 = plot(xc1(:,5),yc1(:,5),'k','linewidth',2);
i3 = plot(xc1(:,9),yc1(:,9),'k','linewidth',2);
i4 = plot(xc1(:,13),yc1(:,13),'k','linewidth',2);
text2line(i1,.85,0,[xv1 ' = ' num2str(x1(1)) ' ' xu1])
text2line(i2,.85,0,[xv1 ' = ' num2str(x1(5)) ' ' xu1])
text2line(i3,.85,0,[xv1 ' = ' num2str(x1(9)) ' ' xu1])
text2line(i4,.85,0,[xv1 ' = ' num2str(x1(13)) ' ' xu1])
j1 = plot(xc2(:,1),yc2(:,1),'k','linewidth',2);
j2 = plot(xc2(:,5),yc2(:,5),'k','linewidth',2);
j3 = plot(xc2(:,9),yc2(:,9),'k','linewidth',2);
j4 = plot(xc2(:,13),yc2(:,13),'k','linewidth',2);
text2line(j1,.85,0,[xv2 ' = ' num2str(x2(1)) ' ' xu2])
text2line(j2,.85,0,[xv2 ' = ' num2str(x2(5)) ' ' xu2])
text2line(j3,.85,0,[xv2 ' = ' num2str(x2(9)) ' ' xu2])
text2line(j4,.85,0,[xv2 ' = ' num2str(x2(13)) ' ' xu2])
ylabel(yl)
grid on
axis([xmin,xmax,ymin,ymax])
ax = gca;
ax.XTick = 0:1.5*xmax:3*xmax;
ax.YTick = 0:d1:ymax;
ax.YAxis.MinorTick='on';
ax.YAxis.MinorTickValues = 0:d2:ymax;
ax.FontSize = 14;
end

