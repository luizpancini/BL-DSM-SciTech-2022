%% Pre-process
switch INPUTS.source
    case "OSU"
        INPUTS.cases = OSU;
        INPUTS.base_name = "OSU run ";
    case "other"
        INPUTS.cases = other;
        INPUTS.base_name = "Oscillatory case ";   
    otherwise
        error("Source '" + INPUTS.source + "' not available")
end

% Loop over cases
counter = 0;
for case_now = INPUTS.cases(:)'

% Update case counter 
counter = counter+1;

%% Initialization 
[data,params,x0,y0,RKF_options] = initialize_model(case_now,INPUTS);

%% Solve system and get outputs
tic; 
switch INPUTS.model
    case "BL"
        outputs = BL_RKF45(params.tspan,x0,y0,params,RKF_options);        
end
outputs.runtime = toc;
% Display runtime
fprintf(INPUTS.base_name + num2str(case_now)  + ", runtime: " + num2str(outputs.runtime) + " s");

%% Interpolate data and find normalized errors with respect to reference data
interp = interp_data(case_now,INPUTS,data,params,outputs);

%% Plots
if INPUTS.plot_sep_figs
    % Separate figures
    h = call_plotter_sepfigs(INPUTS,case_now,data,params,outputs,interp,INPUTS.save_folder,INPUTS.figures_extension);
else
    % Tabbed figures
    h = call_plotter(INPUTS,case_now,data,params,outputs,interp);
end

%% Save all of current case's data
OUTPUTS(counter) = variables2struct(struct,data,params,outputs,interp,h);
% Prepare to print on next line
fprintf('\n');

end
% Mean errors across all cases
if isfield(OUTPUTS(1).interp,'NRMSE')
    cn_NRMSE_sum = 0; cm_NRMSE_sum = 0; cc_NRMSE_sum = 0;
    for i=1:length(OUTPUTS)
        cn_NRMSE_sum = cn_NRMSE_sum+OUTPUTS(i).interp.cn_NRMSE;
        cm_NRMSE_sum = cm_NRMSE_sum+OUTPUTS(i).interp.cm_NRMSE;
        cc_NRMSE_sum = cc_NRMSE_sum+OUTPUTS(i).interp.cc_NRMSE;
    end
    mean_cn_NRMSE = cn_NRMSE_sum/length(OUTPUTS); 
    mean_cm_NRMSE = cm_NRMSE_sum/length(OUTPUTS);
    mean_cc_NRMSE = cc_NRMSE_sum/length(OUTPUTS);
    str = "Mean NMRSE: cn = " + num2str(mean_cn_NRMSE,'%.4f') + ", cm = " + num2str(mean_cm_NRMSE,'%.4f') + ", cc = " + num2str(mean_cc_NRMSE,'%.4f');
    disp(str);
end
% Clear workspace
clearvars -except INPUTS OUTPUTS mean_cn_NRMSE mean_cm_NRMSE mean_cc_NRMSE