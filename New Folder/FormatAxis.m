function FormatAxis(x,dx1,dx2,y,dy1,dy2)
ax = gca;
ax.FontSize = 18;
ax.XTick = 0:dx1:10*max(x);
ax.XAxis.MinorTick='on';
ax.XAxis.MinorTickValues =0:dx2:10*max(x);
ax.YTick = 0:dy1:10*max(y);
ax.YAxis.MinorTick='on';
ax.YAxis.MinorTickValues =0:dy2:10*max(y);
end

