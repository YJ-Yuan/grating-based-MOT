load /Users/lycoris/Desktop/test/d.mat;
ax1 = axes; 
plot(lum.x0, lum.y0)
set(ax1, 'XLim', [2e-08 1e-07])
set(ax1, 'YLim', [-1 -0.7])
set(ax1,'XGrid', 'on')
set(ax1,'YGrid', 'on')
