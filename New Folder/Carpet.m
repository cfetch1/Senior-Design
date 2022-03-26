function [eX1,eY1,eX2,eY2] = Carpet(x1,x2,y,xv1,xv2,xu1,xu2,yl,offset,d1,d2)

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

index = round(linspace(1,length(x1),4));
c1 = index(1);
c2 = index(2);
c3 = index(3);
c4 = index(4);

figure
hold on
i1 = plot(xc1(:,c1),yc1(:,c1),'k','linewidth',2);
i2 = plot(xc1(:,c2),yc1(:,c2),'k','linewidth',2);
i3 = plot(xc1(:,c3),yc1(:,c3),'k','linewidth',2);
i4 = plot(xc1(:,c4),yc1(:,c4),'k','linewidth',2);
text2line(i1,.85,0,[xv1 ' = ' num2str(x1(c1)) ' ' xu1])
text2line(i2,.85,0,[xv1 ' = ' num2str(x1(c2)) ' ' xu1])
text2line(i3,.85,0,[xv1 ' = ' num2str(x1(c3)) ' ' xu1])
text2line(i4,.85,0,[xv1 ' = ' num2str(x1(c4)) ' ' xu1])
j1 = plot(xc2(:,c1),yc2(:,c1),'k','linewidth',2);
j2 = plot(xc2(:,c2),yc2(:,c2),'k','linewidth',2);
j3 = plot(xc2(:,c3),yc2(:,c3),'k','linewidth',2);
j4 = plot(xc2(:,c4),yc2(:,c4),'k','linewidth',2);
text2line(j1,.85,0,[xv2 ' = ' num2str(x2(c1)/1) ' ' xu2])
text2line(j2,.85,0,[xv2 ' = ' num2str(x2(c2)/1) ' ' xu2])
text2line(j3,.85,0,[xv2 ' = ' num2str(x2(c3)/1) ' ' xu2])
text2line(j4,.85,0,[xv2 ' = ' num2str(x2(c4)/1) ' ' xu2])
ylabel(yl)
grid on
axis([xmin,xmax,ymin,ymax])
ax = gca;
ax.XTick = -3*abs(1.5*xmax):6*abs(xmax):3*abs(xmax);
ax.YTick = 0:d1:ymax;
ax.YAxis.MinorTick='on';
ax.YAxis.MinorTickValues = 0:d2:ymax;
ax.FontSize = 14;
 %pbaspect([1 1 1])

eX1(1,:) = xc1(:,c1);
eX1(2,:) = xc1(:,c2);
eX1(3,:) = xc1(:,c3);
eX1(4,:) = xc1(:,c4);

eY1(1,:) = yc1(:,c1);
eY1(2,:) = yc1(:,c2);
eY1(3,:) = yc1(:,c3);
eY1(4,:) = yc1(:,c4);

eX2(1,:) = xc2(:,c1);
eX2(2,:) = xc2(:,c2);
eX2(3,:) = xc2(:,c3);
eX2(4,:) = xc2(:,c4);

eY2(1,:) = yc2(:,c1);
eY2(2,:) = yc2(:,c2);
eY2(3,:) = yc2(:,c3);
eY2(4,:) = yc2(:,c4);



end

