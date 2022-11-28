function h = call_plotter(INPUTS,case_now,data,params,outputs,interp,varargin)

% Handle inputs
if isempty(varargin)
    plot_mod_vars = true;
else
    plot_mod_vars = varargin{1};
end

% Initialize plot handles structure
h = struct;

% Unpack 
authors = data.authors;
model = INPUTS.model;
source = INPUTS.source; 
base_name = INPUTS.base_name;
t = outputs.t;
alpha = outputs.alpha;
c_n = outputs.c_n;
c_m = outputs.c_m;
c_c = outputs.c_c;
c_l = outputs.c_l;
c_d = outputs.c_d;
iti = interp.iti;
time_ref_interp = interp.time_ref;
alpha_ref_interp = interp.alpha_ref;
cn_ref_interp = interp.cn_ref;
cm_ref_interp = interp.cm_ref;
cc_ref_interp = interp.cc_ref;
cl_ref_interp = interp.cl_ref;
cd_ref_interp = interp.cd_ref;

%% Set legend for current model
switch model
    case {"BL"}
        model_name = "Present model";    
end

%% Create figure and initialize plot options
[h,plot_opt] = init_plotter(h,base_name,case_now,source,params,1);

%% Coefficients x pitch angle
h_cla = alpha_plotter(1,h.fig,'cl','$c_l$',alpha,c_l,alpha_ref_interp,cl_ref_interp,data.alpha_exp_cl,data.cl_exp,data.alpha_mod_cl,data.cl_mod,data.alpha_cycles,data.cl_cycles,authors,iti,source,h.tabgp,model_name,plot_opt);
h_cma = alpha_plotter(1,h.fig,'cm','$c_m$',alpha,c_m,alpha_ref_interp,cm_ref_interp,data.alpha_exp_cm,data.cm_exp,data.alpha_mod_cm,data.cm_mod,data.alpha_cycles,data.cm_cycles,authors,iti,source,h.tabgp,model_name,plot_opt);
h_cda = alpha_plotter(1,h.fig,'cd','$c_d$',alpha,c_d,alpha_ref_interp,cd_ref_interp,data.alpha_exp_cd,data.cd_exp,data.alpha_mod_cd,data.cd_mod,data.alpha_cycles,data.cd_cycles,authors,iti,source,h.tabgp,model_name,plot_opt);
h_cna = alpha_plotter(1,h.fig,'cn','$c_n$',alpha,c_n,alpha_ref_interp,cn_ref_interp,data.alpha_exp_cn,data.cn_exp,data.alpha_mod_cn,data.cn_mod,data.alpha_cycles,data.cn_cycles,authors,iti,source,h.tabgp,model_name,plot_opt);
h_cca = alpha_plotter(1,h.fig,'cc','$c_c$',alpha,c_c,alpha_ref_interp,cc_ref_interp,data.alpha_exp_cc,data.cc_exp,data.alpha_mod_cc,data.cc_mod,data.alpha_cycles,data.cc_cycles,authors,iti,source,h.tabgp,model_name,plot_opt);
% Add to plots handle structure
h = variables2struct(h,h_cla,h_cma,h_cda,h_cna,h_cca);

%% Coefficients x time
h_clt = time_plotter(1,h.fig,'cl x t','$c_l$',t,c_l,time_ref_interp,cl_ref_interp,data.time_exp_cl,data.clt_exp,data.time_mod_cl,data.clt_mod,data.time_cycles,data.cl_cycles,model,outputs,params,interp,authors,source,h.tabgp,model_name,plot_opt);
h_cmt = time_plotter(1,h.fig,'cm x t','$c_m$',t,c_m,time_ref_interp,cm_ref_interp,data.time_exp_cm,data.cmt_exp,data.time_mod_cm,data.cmt_mod,data.time_cycles,data.cm_cycles,model,outputs,params,interp,authors,source,h.tabgp,model_name,plot_opt);
h_cdt = time_plotter(1,h.fig,'cd x t','$c_d$',t,c_d,time_ref_interp,cd_ref_interp,data.time_exp_cd,data.cdt_exp,data.time_mod_cd,data.cdt_mod,data.time_cycles,data.cd_cycles,model,outputs,params,interp,authors,source,h.tabgp,model_name,plot_opt);
h_cnt = time_plotter(1,h.fig,'cn x t','$c_n$',t,c_n,time_ref_interp,cn_ref_interp,data.time_exp_cn,data.cnt_exp,data.time_mod_cn,data.cnt_mod,data.time_cycles,data.cn_cycles,model,outputs,params,interp,authors,source,h.tabgp,model_name,plot_opt);
h_cct = time_plotter(1,h.fig,'cc x t','$c_c$',t,c_c,time_ref_interp,cc_ref_interp,data.time_exp_cc,data.cct_exp,data.time_mod_cc,data.cct_mod,data.time_cycles,data.cc_cycles,model,outputs,params,interp,authors,source,h.tabgp,model_name,plot_opt);
% Add to plots handle structure
h = variables2struct(h,h_clt,h_cmt,h_cdt,h_cnt,h_cct);
    
%% Separation points, angle offsets and time delay constants
if ismember(model,{'BL'}) && plot_mod_vars
    if ~isnan(alpha_ref_interp)
        model_vars_plotter(interp,outputs,source,model,h.tabgp,plot_opt,params);
    end
end

end