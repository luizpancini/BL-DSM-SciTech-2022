%% Initialize figure and set axes design
% Default plot options
set(0,'DefaultTextInterpreter','latex')
set(0,'DefaultLegendInterpreter','latex')
fig_size = [9.5 7];
axes_size = 20;
lw = 1;
ms = 5;
N = length(OUTPUTS);
c = lines(3); 
c(end,:) = [0,0,0];

%% Loop over cases
for i=1:N
    %% Loop over coefs 
    for coef = 1:3
        % Set axes design
        if i == 1
            % alpha
            alpha_figure(coef) = figure('InvertHardcopy','off','Color',[1 1 1]);
            alpha_figure(coef).PaperSize = fig_size;
            alpha_figure(coef).Position = [3.5540e+02 129 920 6.2960e+02];
            alpha_ax(coef) = axes('Parent',alpha_figure(coef),'FontSize',axes_size,'FontName','times new roman');
            alpha_ax(coef).XLabel.String = '$\alpha$ [deg]'; alpha_ax(coef).XLabel.FontWeight = 'normal'; alpha_ax(coef).XLabel.FontSize = axes_size;
            alpha_ax(coef).YLabel.FontWeight = 'normal'; alpha_ax(coef).YLabel.FontSize = axes_size;
            % time
            time_figure(coef) = figure('InvertHardcopy','off','Color',[1 1 1]);
            time_figure(coef).PaperSize = fig_size;
            time_figure(coef).Position = [3.5540e+02 129 920 6.2960e+02];
            time_ax(coef) = axes('Parent',time_figure(coef),'FontSize',axes_size,'FontName','times new roman');
            time_ax(coef).XLabel.String = '$\omega t$ [deg]'; time_ax(coef).XLabel.FontWeight = 'normal'; time_ax(coef).XLabel.FontSize = axes_size;
            time_ax(coef).YLabel.FontWeight = 'normal'; time_ax(coef).YLabel.FontSize = axes_size;
            time_ax(coef).XLim = [-90 270]; time_ax(coef).XTick = -90:90:270;
        end
        switch coef
            case 1 % c_n
                % Set YLabel
                time_ax(coef).YLabel.String = '$c_n$';
                alpha_ax(coef).YLabel.String = '$c_n$'; 
                % Data
                time_mod =  OUTPUTS(i).h.h_cnt(1).XData;
                time_exp =  OUTPUTS(i).h.h_cnt(2).XData;
                alpha_mod = OUTPUTS(i).h.h_cna(1).XData;
                alpha_exp = OUTPUTS(i).h.h_cna(2).XData;
                coef_modt =  OUTPUTS(i).h.h_cnt(1).YData;
                coef_expt =  OUTPUTS(i).h.h_cnt(2).YData;
                coef_moda =  OUTPUTS(i).h.h_cna(1).YData;
                coef_expa =  OUTPUTS(i).h.h_cna(2).YData;
                clearvars time_exp_raw coef_exp_rawt alpha_exp_raw coef_exp_rawa
                for n=1:length(OUTPUTS(i).h.h_cna)-2
                    time_exp_raw{n} =  OUTPUTS(i).h.h_cnt(2+n).XData;
                    coef_exp_rawt{n} = OUTPUTS(i).h.h_cnt(2+n).YData;
                    alpha_exp_raw{n} = OUTPUTS(i).h.h_cna(2+n).XData;
                    coef_exp_rawa{n} = OUTPUTS(i).h.h_cna(2+n).YData;
                end
            case 2 % c_m
                % Set YLabel
                time_ax(coef).YLabel.String = '$c_m$';
                alpha_ax(coef).YLabel.String = '$c_m$'; 
                % Data
                time_mod =  OUTPUTS(i).h.h_cmt(1).XData;
                time_exp =  OUTPUTS(i).h.h_cmt(2).XData;
                alpha_mod = OUTPUTS(i).h.h_cma(1).XData;
                alpha_exp = OUTPUTS(i).h.h_cma(2).XData;
                coef_modt =  OUTPUTS(i).h.h_cmt(1).YData;
                coef_expt =  OUTPUTS(i).h.h_cmt(2).YData;
                coef_moda =  OUTPUTS(i).h.h_cma(1).YData;
                coef_expa =  OUTPUTS(i).h.h_cma(2).YData;
                clearvars time_exp_raw coef_exp_rawt alpha_exp_raw coef_exp_rawa
                for n=1:length(OUTPUTS(i).h.h_cna)-2
                    time_exp_raw{n} =  OUTPUTS(i).h.h_cmt(2+n).XData;
                    coef_exp_rawt{n} = OUTPUTS(i).h.h_cmt(2+n).YData;
                    alpha_exp_raw{n} = OUTPUTS(i).h.h_cma(2+n).XData;
                    coef_exp_rawa{n} =  OUTPUTS(i).h.h_cma(2+n).YData;
                end
            case 3 % c_c
                % Set YLabel
                time_ax(coef).YLabel.String = '$c_c$';
                alpha_ax(coef).YLabel.String = '$c_c$'; 
                % Data
                time_mod =  OUTPUTS(i).h.h_cct(1).XData;
                time_exp =  OUTPUTS(i).h.h_cct(2).XData;
                alpha_mod = OUTPUTS(i).h.h_cca(1).XData;
                alpha_exp = OUTPUTS(i).h.h_cca(2).XData;
                coef_modt =  OUTPUTS(i).h.h_cct(1).YData;
                coef_expt =  OUTPUTS(i).h.h_cct(2).YData;
                coef_moda =  OUTPUTS(i).h.h_cca(1).YData;
                coef_expa =  OUTPUTS(i).h.h_cca(2).YData;
                clearvars time_exp_raw coef_exp_rawt alpha_exp_raw coef_exp_rawa
                for n=1:length(OUTPUTS(i).h.h_cna)-2
                    time_exp_raw{n} =  OUTPUTS(i).h.h_cct(2+n).XData;
                    coef_exp_rawt{n} = OUTPUTS(i).h.h_cct(2+n).YData;
                    alpha_exp_raw{n} = OUTPUTS(i).h.h_cca(2+n).XData;
                    coef_exp_rawa{n} =  OUTPUTS(i).h.h_cca(2+n).YData;
                end
        end
        %% Coefs vs. alpha
        hold(alpha_ax(coef),'on'); alpha_ax(coef).XGrid = 'on'; alpha_ax(coef).YGrid = 'on';
        % Plot model results
        plot(alpha_mod,coef_moda,'-','Color',c(i,:),'LineWidth',lw,'Parent',alpha_ax(coef));
        % Plot mean interpolated experimental values
        plot(alpha_exp,coef_expa,'--','Color',c(i,:),'LineWidth',lw,'MarkerSize',ms,'Parent',alpha_ax(coef));
        % Plot the multiple experimental cycles
        for n=1:size(alpha_exp_raw,2)
            plot(alpha_exp_raw{n},coef_exp_rawa{n},'o','Color',c(i,:),'LineWidth',lw,'MarkerSize',ms,'Parent',alpha_ax(coef));
        end   
        % Set legend
        for j=1:3
            ha(2*j-1) = plot(nan,nan,'-','Color',c(j,:),'LineWidth',lw,'MarkerSize',ms,'Parent',alpha_ax(coef));
            ha(2*j)   = plot(nan,nan,'--o','Color',c(j,:),'LineWidth',lw,'MarkerSize',ms,'Parent',alpha_ax(coef));
        end
        lgda = legend(ha,{"Model - $k=$"+num2str(OUTPUTS(1).params.k,'%.3f'),"NREL - $k=$"+num2str(OUTPUTS(1).params.k,'%.3f'),"Model - $k=$"+num2str(OUTPUTS(2).params.k,'%.3f'),"NREL - $k=$"+num2str(OUTPUTS(2).params.k,'%.3f'),"Model - $k=$"+num2str(OUTPUTS(3).params.k,'%.3f'),"NREL - $k=$"+num2str(OUTPUTS(3).params.k,'%.3f')});
        set(lgda,'Location','best','FontSize',axes_size*0.6,'NumColumns',2,'Orientation','horizontal');
        %% Coefs vs. time
        hold(time_ax(coef),'on'); time_ax(coef).XGrid = 'on'; time_ax(coef).YGrid = 'on';
        % Plot model results
        plot(time_mod,coef_modt,'-','Color',c(i,:),'LineWidth',lw,'Parent',time_ax(coef));
        % Plot mean interpolated experimental values
        plot(time_exp,coef_expt,'--','Color',c(i,:),'LineWidth',lw,'MarkerSize',ms,'Parent',time_ax(coef));
        % Plot the multiple experimental cycles
        for n=1:size(time_exp_raw,2)
            plot(time_exp_raw{n},coef_exp_rawt{n},'o','Color',c(i,:),'LineWidth',lw,'MarkerSize',ms,'Parent',time_ax(coef));
        end   
        % Set legend
        for j=1:3
            ht(2*j-1) = plot(nan,nan,'-','Color',c(j,:),'LineWidth',lw,'MarkerSize',ms,'Parent',time_ax(coef));
            ht(2*j)   = plot(nan,nan,'--o','Color',c(j,:),'LineWidth',lw,'MarkerSize',ms,'Parent',time_ax(coef));
        end
        lgdt = legend(ht,{"Model - $k=$"+num2str(OUTPUTS(1).params.k,'%.3f'),"NREL - $k=$"+num2str(OUTPUTS(1).params.k,'%.3f'),"Model - $k=$"+num2str(OUTPUTS(2).params.k,'%.3f'),"NREL - $k=$"+num2str(OUTPUTS(2).params.k,'%.3f'),"Model - $k=$"+num2str(OUTPUTS(3).params.k,'%.3f'),"NREL - $k=$"+num2str(OUTPUTS(3).params.k,'%.3f')});
        set(lgdt,'Location','best','FontSize',axes_size*0.6,'NumColumns',2,'Orientation','horizontal');
    end
end

%% Save figures
% Set filepaths
if ismember(INPUTS.cases(1),[432,435,438,441])
    base_name = "Attached_flow";
elseif ismember(INPUTS.cases(1),[420,423,426,429])
    base_name = "Stall_onset_high";
elseif ismember(INPUTS.cases(1),[396,399,402,405])
    base_name = "Stall_onset_low";
elseif ismember(INPUTS.cases(1),[384,387,390,393])
    base_name = "Deep_stall";
elseif ismember(INPUTS.cases(1),[408,411,414,417])
    base_name = "Very_deep_stall_low";
elseif ismember(INPUTS.cases(1),[372,375,378,381])
    base_name = "Very_deep_stall_high";
end  
if     ismember(INPUTS.cases(1),[372 373 374 384 385 386 396 397 398 408 409 410 420 421 422 432 433 434])
    base_name = base_name + "_M_0075";
elseif ismember(INPUTS.cases(1),[375 376 377 387 388 389 399 400 401 411 412 413 423 424 425 435 436 437])
    base_name = base_name + "_M_0100";
elseif ismember(INPUTS.cases(1),[378 379 380 390 391 392 402 403 404 414 415 416 426 427 428 438 439 440])
    base_name = base_name + "_M_0125";
elseif ismember(INPUTS.cases(1),[381 382 383 393 394 395 405 406 407 417 418 419 429 430 431 441 442 443])
    base_name = base_name + "_M_0150";
end
baseFileName_cn_a = base_name + "_cn_a.pdf";
baseFileName_cm_a = base_name + "_cm_a.pdf";
baseFileName_cc_a = base_name + "_cc_a.pdf";
baseFileName_cn_t = base_name + "_cn_t.pdf";
baseFileName_cm_t = base_name + "_cm_t.pdf";
baseFileName_cc_t = base_name + "_cc_t.pdf";
filepath_cn_a = fullfile(INPUTS.save_folder,baseFileName_cn_a);
filepath_cm_a = fullfile(INPUTS.save_folder,baseFileName_cm_a);
filepath_cc_a = fullfile(INPUTS.save_folder,baseFileName_cc_a);
filepath_cn_t = fullfile(INPUTS.save_folder,baseFileName_cn_t);
filepath_cm_t = fullfile(INPUTS.save_folder,baseFileName_cm_t);
filepath_cc_t = fullfile(INPUTS.save_folder,baseFileName_cc_t);
% Save
warning('off')
saveas(alpha_figure(1),filepath_cn_a);
saveas(alpha_figure(2),filepath_cm_a);
saveas(alpha_figure(3),filepath_cc_a);
saveas(time_figure(1),filepath_cn_t);
saveas(time_figure(2),filepath_cm_t);
saveas(time_figure(3),filepath_cc_t);
warning('on')