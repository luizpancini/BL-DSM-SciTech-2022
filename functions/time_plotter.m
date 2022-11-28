function [h,fig] = time_plotter(tabbed,fig,tab_name,coef_name,t,coef,time_interp,coef_interp,time_exp,coef_exp,time_mod,coef_mod,time_cycles,coef_cycles,model,outputs,params,interp,authors,source,tabgp,model_name,plot_opt)

% Unpack and set arrays
switch source
    case {"OSU","other"}
        t_cycle = params.t_cycle; itt = interp.itt; ittf = interp.ittf;
        t_plot = (t(itt:ittf)-t(itt))/t_cycle*360-90;
        coef_plot = coef(itt:ittf);
end

%% Initialize tab and set axes design
if tabbed
    tab = uitab('Parent',tabgp,'Title',tab_name,'BackgroundColor',[1 1 1]);
    ax = axes('Parent',tab,'FontSize',plot_opt.axes_size,'FontName','times new roman');
    ax.Title.String = plot_opt.title_str; ax.Title.FontWeight = 'normal'; ax.Title.FontSize = plot_opt.axes_size*0.6;
else
    ax = axes('Parent',fig,'FontSize',plot_opt.axes_size,'FontName','times new roman');
end
hold(ax,'on'); ax.XGrid = 'on'; ax.YGrid = 'on';
ax.XLabel.FontWeight = 'normal'; ax.XLabel.FontSize = plot_opt.axes_size;
ax.YLabel.FontWeight = 'normal'; ax.YLabel.FontSize = plot_opt.axes_size;
ax.XLim = [-90 270]; ax.XTick = -90:90:270;
ax.XLabel.String = '$\omega t$ [deg]';
ax.YLabel.String = coef_name;

%% Plot
switch source
    case "OSU"
        % Plot model results
        h_mod = plot(t_plot,coef_plot,'k-','LineWidth',plot_opt.lw,'Parent',ax);
        % Plot the multiple experimental cycles
        for n=1:length(time_cycles)
            h_exp_raw(n) = plot(time_cycles{n}(1:end-1),coef_cycles{n}(1:end-1),'bo','LineWidth',plot_opt.lw,'MarkerSize',plot_opt.ms,'Parent',ax);
        end
        % Plot mean interpolated values
        h_exp = plot(time_interp,coef_interp,'b-','LineWidth',plot_opt.lw,'MarkerSize',plot_opt.ms,'Parent',ax);
        % Legend
        h = plot(nan,nan,'k-',nan,nan,'b-o','LineWidth',plot_opt.lw,'MarkerSize',plot_opt.ms,'Parent',ax);
    otherwise
        if isnan(time_exp(1)) && isempty(authors{1})
            h = plot(t_plot,coef_plot,'k-','LineWidth',plot_opt.lw,'MarkerSize',plot_opt.ms,'Parent',ax);
        elseif length(authors) == 1  || isnan(time_mod(1)) 
            h = plot(t_plot,coef_plot,'k-',time_exp,coef_exp,'ko','LineWidth',plot_opt.lw,'MarkerSize',plot_opt.ms,'Parent',ax);
        elseif length(authors) == 2
            h = plot(t_plot,coef_plot,'k-',time_exp,coef_exp,'ko',time_mod,coef_mod,'k--','LineWidth',plot_opt.lw,'MarkerSize',plot_opt.ms,'Parent',ax);
        end            
end

% Set legend
if isnan(time_exp(1)) && isempty(authors{1})
    lgd = legend(h,{model_name});
elseif length(authors) == 1 || isnan(time_mod(1)) 
    lgd = legend(h,{model_name,authors{1}});
elseif length(authors) == 2
    lgd = legend(h,{model_name,authors{1},authors{2}});
end
set(lgd,'Location','best','FontSize',plot_opt.axes_size*0.6);

% Set correct handle output for OSU case
if source == "OSU", h = [h_mod, h_exp, h_exp_raw]; end

end