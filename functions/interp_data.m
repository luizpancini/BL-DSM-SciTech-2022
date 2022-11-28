function interp = interp_data(case_now,INPUTS,data,params,outputs,varargin)

%% Handle inputs
% Check optional inputs
disp_info = 1; E_cn_best = nan; 
j = 0;
while ~isempty(varargin)
    j = j+1;
    switch j
        case 1
            disp_info = varargin{1};
            varargin(1) = [];
        case 2
            E_cn_best = varargin{1};
            E_cm_best = varargin{2};
            E_cc_best = varargin{3};
            varargin(1:3) = [];            
    end
end

% Unpack parameters and outputs
t = outputs.t;
alpha = outputs.alpha;
c_n = outputs.c_n;
c_m = outputs.c_m;
c_c = outputs.c_c;
source = INPUTS.source;

% Find time indices of oscillatory cases
t_cycle = params.t_cycle;
n_discard = params.n_discard;
delta_cycle = 1/4;
iti = find(t>n_discard*t_cycle,1,'first');                                      % First index after discarded time
itt = find(t>t(end)-(1+delta_cycle)*t_cycle,1,'first');                         % Index of begin of last cycle
ittf = min([length(t),find(t>t(end)-delta_cycle*t_cycle,1,'first')]);           % Index of end of last cycle
range = itt:ittf;                                                               % Range of indices in last cycle

% Create interpolation data structure
interp = variables2struct(struct(),iti,itt,ittf,range);

%% Interpolation of coefficients
% Interpolate model's results
N_interp = 1e3+1;                                                                   % Size of interpolated arrays - must be kept constant for comparison between any two sets, because the NRMSE depends on it
interp_method = 'pchip';                                                            % Interpolation method (pchip is best for OSU data)
time_mod_interp = linspace(t(itt),t(ittf),N_interp);                                % Linearly interpolated time array
alpha_mod_interp = interp1(t(range),alpha(range),time_mod_interp,interp_method);    % Interpolated pitch angle
cn_mod_interp = interp1(t(range),c_n(range),time_mod_interp,interp_method);         % Interpolated c_n
cm_mod_interp = interp1(t(range),c_m(range),time_mod_interp,interp_method);         % Interpolated c_m
cc_mod_interp = interp1(t(range),c_c(range),time_mod_interp,interp_method);         % Interpolated c_c

% Interpolate reference data
switch source
    case "OSU"
        [time_ref_interp,alpha_ref_interp,cn_ref_interp,cm_ref_interp,cc_ref_interp,cl_ref_interp,cd_ref_interp] = interp_coefs_OSU(data,N_interp,interp_method);
    otherwise
        time_ref_interp = nan; alpha_ref_interp = nan; cn_ref_interp = nan; cm_ref_interp = nan;cc_ref_interp = nan; cl_ref_interp = nan; cd_ref_interp = nan;
end

% Normalized Root Mean Squared Error
[cn_NRMSE,cm_NRMSE,cc_NRMSE] = NRMSE_calculator(cn_mod_interp,cm_mod_interp,cc_mod_interp,cn_ref_interp,cm_ref_interp,cc_ref_interp);

% Display information
if disp_info
    if isnan(E_cn_best)
        str = ", NMRSE: cn = " + num2str(cn_NRMSE,'%.4f') + ", cm = " + num2str(cm_NRMSE,'%.4f') + ", cc = " + num2str(cc_NRMSE,'%.4f');
    else
        str = ", NMRSE: cn = " + num2str(cn_NRMSE,'%.4f') + "(" + num2str(100*(cn_NRMSE/E_cn_best-1),'%.1f') + "%%), cm = " + num2str(cm_NRMSE,'%.4f') + "(" + num2str(100*(cm_NRMSE/E_cm_best-1),'%.1f') + "%%), cc = " + num2str(cc_NRMSE,'%.4f') + "(" + num2str(100*(cc_NRMSE/E_cc_best-1),'%.1f') + "%%)";
    end
    fprintf(str);
end

% Save interpolation data to struct
interp.time_mod = time_mod_interp;
interp.alpha_mod = alpha_mod_interp;
interp.cn_mod = cn_mod_interp;
interp.cm_mod = cm_mod_interp;
interp.cc_mod = cc_mod_interp;
interp.time_ref = time_ref_interp;
interp.alpha_ref = alpha_ref_interp;
interp.cn_ref = cn_ref_interp;
interp.cm_ref = cm_ref_interp;
interp.cc_ref = cc_ref_interp;
interp.cl_ref = cl_ref_interp;
interp.cd_ref = cd_ref_interp;
interp.NRMSE.cn = cn_NRMSE;
interp.NRMSE.cm = cm_NRMSE;
interp.NRMSE.cc = cc_NRMSE;
interp.cn_NRMSE = cn_NRMSE;
interp.cm_NRMSE = cm_NRMSE;
interp.cc_NRMSE = cc_NRMSE;

end