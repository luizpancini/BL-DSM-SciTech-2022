function [h,plot_opt] = init_plotter(h,base_name,case_now,source,params,tabbed)

% Unpack
a_0 = params.a_0;
a_1 = params.a_1;
M = params.M;
k = params.k;
if isnumeric(case_now), case_str =  num2str(case_now); else, case_str = ""; end

% Default plot options
set(0,'DefaultTextInterpreter','latex')
set(0,'DefaultLegendInterpreter','latex')
axes_size = 20;
lw = 1;
ms = 5;

% Create figure and tab group
h.fig = figure('InvertHardcopy','off','Color',[1 1 1]); 
h.fig.Name = base_name + case_str;
h.fig.NumberTitle = 'off';
h.fig.PaperSize = [9.5 7];
h.fig.Position = [3.5540e+02 129 920 6.2960e+02];
if tabbed, h.tabgp = uitabgroup(h.fig); end

% Set axes limits
xlim_vec = sort(180/pi*[a_0-a_1, a_0+a_1]);

% Configure title
info_str = ": $M$ = " +  num2str(M,'%.3f') + ", $k$ = " + num2str(k,'%.3f') + ", $\alpha_0$ = " +  num2str(a_0*180/pi,'%.1f') + "$^{\circ}$, $\alpha_1$ = " + num2str(a_1*180/pi,'%.1f') + "$^{\circ}$";
title_str = base_name + case_str + info_str;

% Save to struct
plot_opt = variables2struct(struct,axes_size,lw,ms,xlim_vec,title_str);

end