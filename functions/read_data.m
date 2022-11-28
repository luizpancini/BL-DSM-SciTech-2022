function [data,params] = read_data(INPUTS,case_now,n_discard)

% Unpack
source = INPUTS.source;
model = INPUTS.model;

%% Load experimental/model data and test conditions from source
switch source   
	case "OSU"
        [params,data] = load_OSU(case_now);
	case "other"
        [params,data] = load_other(case_now);
    otherwise
        error("Unknown data source: " + source);
end

% Unpack
airfoil = params.airfoil;
b = params.b;
U = params.U;
M = params.M;
k = params.k;

%% Simulation time variables for oscillatory cases
% Time of one cycle
t_cycle = 2*pi*b/(U*k);
% Number of cycles to discard for plots (only one if conditions are quasi-steady, i.e., k < 0.01)
is_quasi_steady = k<0.01;
params.n_discard = n_discard*(1-is_quasi_steady)+is_quasi_steady;
% Number of cycles to run
params.n_cycles = params.n_discard+1;
% Time of one cycle
params.t_cycle = t_cycle;
% Total test time
params.tf = params.t_cycle*params.n_cycles;
% Time span array
params.tspan = [0 params.tf];

%% Set unavailable experimental/model data to NaN
data_fields_list = {"alpha_exp_cl","alpha_exp_cm","alpha_exp_cd","alpha_exp_cn","alpha_exp_cc","alpha_exp_ch",...
                    "delta_exp_cl","delta_exp_cm","delta_exp_cd","delta_exp_cn","delta_exp_cc","delta_exp_ch",...
                    "cl_exp","cm_exp","cd_exp","cn_exp","cc_exp","ch_exp",...
                    "time_exp_cl","time_exp_cm","time_exp_cd","time_exp_cn","time_exp_cc",...
                    "clt_exp","cmt_exp","cdt_exp","cnt_exp","cct_exp",...
                    "alpha_mod_cl","alpha_mod_cm","alpha_mod_cd","alpha_mod_cn","alpha_mod_cc","alpha_mod_ch",...
                    "delta_mod_cl","delta_mod_cm","delta_mod_cd","delta_mod_cn","delta_mod_cc","delta_mod_ch",...
                    "cl_mod","cm_mod","cd_mod","cn_mod","cc_mod","ch_mod",...
                    "time_mod_cl","time_mod_cm","time_mod_cd","time_mod_cn","time_mod_cc",...
                    "clt_mod","cmt_mod","cdt_mod","cnt_mod","cct_mod",...
                    "time_cycles","alpha_cycles","cl_cycles","cm_cycles","cd_cycles","cn_cycles","cc_cycles"};
for i=1:length(data_fields_list)
    field = data_fields_list{i};
    if ~isfield(data,field)
        data.(field) = NaN;
    end
end

%% Airfoil parameters
switch model
    case {"BL"}
        params = BL_airfoil_parameters(params,airfoil,M,U,b);
    otherwise
        error("Unknown model: " + model);
end

%% Indicial parameters
params = indicial_params(params,model);

%% State space matrices
params = SS_matrices(params,model);

end