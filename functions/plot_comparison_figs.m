% Set Xlim
fig_name = "N5";
XLim = [2,25];
warning('off')
% Plot c_n
uiopen(pwd+"\"+fig_name+"_cn.fig",1); hold on
plot(OUTPUTS.h.h_cna(2).XData,OUTPUTS.h.h_cna(2).YData,'b-','LineWidth',1)
ax = gca; ax.XLim = XLim;
hold on; plotnan = plot(nan,nan,'b-o',nan,nan,'k-',nan,nan,'k--','LineWidth',1);
lgd1 = legend(plotnan,'NREL','Present model','Mohamed \& Wood (2020)'); lgd1.FontSize = 12;
close
% Plot c_m
uiopen(pwd+"\"+fig_name+"_cm.fig",1); hold on
plot(OUTPUTS.h.h_cma(2).XData,OUTPUTS.h.h_cma(2).YData,'b-','LineWidth',1)
ax = gca; ax.XLim = XLim;
hold on; plotnan = plot(nan,nan,'b-o',nan,nan,'k-',nan,nan,'k--','LineWidth',1);
lgd1 = legend(plotnan,'NREL','Present model','Mohamed \& Wood (2020)'); lgd1.FontSize = 12;
close
% Plot c_c
uiopen(pwd+"\"+fig_name+"_cc.fig",1); hold on
plot(OUTPUTS.h.h_cca(2).XData,OUTPUTS.h.h_cca(2).YData,'b-','LineWidth',1)
ax = gca; ax.XLim = XLim;
hold on; plotnan = plot(nan,nan,'b-o',nan,nan,'k-',nan,nan,'k--','LineWidth',1);
lgd1 = legend(plotnan,'NREL','Present model','Mohamed \& Wood (2020)'); lgd1.FontSize = 12;
close
warning('on')