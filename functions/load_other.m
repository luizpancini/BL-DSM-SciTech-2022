function [params,data] = load_other(case_now)

%% Load experimental data
switch case_now
    case 1
        % Test conditions
        M = 0.075; 
        a_0 = 17.5*pi/180;
        a_1 = 22.5*pi/180;
        k = 1e-4;
        authors{1} = 'NREL';
        b = 0.437/2;
        a_inf = 340;
        ah = -1/2;
        airfoil = 'S809';
        % Experimental data
        file = '../Other Data/S809_static_M_0075.mat';
        load(file,'alpha','c_l','c_d','c_m','c_n','c_c')
        alpha_exp_cl = alpha; alpha_exp_cd = alpha; alpha_exp_cn = alpha; alpha_exp_cm = alpha; alpha_exp_cc = alpha;
        cl_exp = c_l; cd_exp = c_d; cn_exp = c_n; cm_exp = c_m; cc_exp = c_c;
        alpha_mod_cl = nan; cl_mod = nan; alpha_mod_cm = nan; cm_mod = nan; alpha_mod_cd = nan; cd_mod = nan; alpha_mod_cn = nan; cn_mod = nan; alpha_mod_cc = nan; cc_mod = nan;
    case 2
        % Test conditions
        M = 0.150; 
        a_0 = 10.0*pi/180;
        a_1 = 15.0*pi/180;
        k = 2e-4;
        authors{1} = 'NREL';
        b = 0.437/2;
        a_inf = 340;
        ah = -1/2;
        airfoil = 'S809';
        % Experimental data
        file = '../Other Data/S809_static_M_0150.mat';
        load(file,'alpha','c_l','c_d','c_m','c_n','c_c')
        alpha_exp_cl = alpha; alpha_exp_cd = alpha; alpha_exp_cn = alpha; alpha_exp_cm = alpha; alpha_exp_cc = alpha;
        cl_exp = c_l; cd_exp = c_d; cn_exp = c_n; cm_exp = c_m; cc_exp = c_c;
        alpha_mod_cl = nan; cl_mod = nan; alpha_mod_cm = nan; cm_mod = nan; alpha_mod_cd = nan; cd_mod = nan; alpha_mod_cn = nan; cn_mod = nan; alpha_mod_cc = nan; cc_mod = nan;    
    case 3
        % NREL/OSU
        [params,data] = load_OSU(374);
        [M,U,b,a_inf,beta,a_0,a_1,k,airfoil,ah] = struct2vars(params);
        [authors,alpha_exp_cl,alpha_exp_cm,alpha_exp_cd,alpha_exp_cn,alpha_exp_cc,cl_exp,cm_exp,cd_exp,cn_exp,cc_exp] = struct2vars(data);
        % Mohamed & Wood (2020)
        file1 = '../Other Data/S809_Mohamed_N1_cn.mat';
        file2 = '../Other Data/S809_Mohamed_N1_cm.mat';
        file3 = '../Other Data/S809_Mohamed_N1_cc.mat';
        load(file1)
        load(file2)
        load(file3)
        alpha_mod_cn = S809_Mohamed_N1_cn(:,1);
        cn_mod       = S809_Mohamed_N1_cn(:,2);
        alpha_mod_cm = S809_Mohamed_N1_cm(:,1);
        cm_mod       = S809_Mohamed_N1_cm(:,2);
        alpha_mod_cc = S809_Mohamed_N1_cc(:,1);
        cc_mod       = S809_Mohamed_N1_cc(:,2);
        alpha_mod_cl = nan; cl_mod = nan; alpha_mod_cd = nan; cd_mod = nan;
        authors{2} = 'Mohamed and Wood (2020)';
    case 4
        % NREL/OSU
        [params,data] = load_OSU(398);
        [M,U,b,a_inf,beta,a_0,a_1,k,airfoil,ah] = struct2vars(params);
        [authors,alpha_exp_cl,alpha_exp_cm,alpha_exp_cd,alpha_exp_cn,alpha_exp_cc,cl_exp,cm_exp,cd_exp,cn_exp,cc_exp] = struct2vars(data);
        % Mohamed & Wood (2020)
        file1 = '../Other Data/S809_Mohamed_N3_cn.mat';
        file2 = '../Other Data/S809_Mohamed_N3_cm.mat';
        file3 = '../Other Data/S809_Mohamed_N3_cc.mat';
        load(file1)
        load(file2)
        load(file3)
        alpha_mod_cn = S809_Mohamed_N3_cn(:,1);
        cn_mod       = S809_Mohamed_N3_cn(:,2);
        alpha_mod_cm = S809_Mohamed_N3_cm(:,1);
        cm_mod       = S809_Mohamed_N3_cm(:,2);
        alpha_mod_cc = S809_Mohamed_N3_cc(:,1);
        cc_mod       = S809_Mohamed_N3_cc(:,2);
        alpha_mod_cl = nan; cl_mod = nan; alpha_mod_cd = nan; cd_mod = nan;
        authors{2} = 'Mohamed and Wood (2020)'; 
    case 5
        % NREL/OSU
        [params,data] = load_OSU(392);
        [M,U,b,a_inf,beta,a_0,a_1,k,airfoil,ah] = struct2vars(params);
        [authors,alpha_exp_cl,alpha_exp_cm,alpha_exp_cd,alpha_exp_cn,alpha_exp_cc,cl_exp,cm_exp,cd_exp,cn_exp,cc_exp] = struct2vars(data);
        % Mohamed & Wood (2020)
        file1 = '../Other Data/S809_Mohamed_N5_cn.mat';
        file2 = '../Other Data/S809_Mohamed_N5_cm.mat';
        file3 = '../Other Data/S809_Mohamed_N5_cc.mat';
        load(file1)
        load(file2)
        load(file3)
        alpha_mod_cn = S809_Mohamed_N5_cn(:,1);
        cn_mod       = S809_Mohamed_N5_cn(:,2);
        alpha_mod_cm = S809_Mohamed_N5_cm(:,1);
        cm_mod       = S809_Mohamed_N5_cm(:,2);
        alpha_mod_cc = S809_Mohamed_N5_cc(:,1);
        cc_mod       = S809_Mohamed_N5_cc(:,2);
        alpha_mod_cl = nan; cl_mod = nan; alpha_mod_cd = nan; cd_mod = nan;
        authors{2} = 'Mohamed and Wood (2020)';
    case 6
        % NREL/OSU
        [params,data] = load_OSU(389);
        [M,U,b,a_inf,beta,a_0,a_1,k,airfoil,ah] = struct2vars(params);
        [authors,alpha_exp_cl,alpha_exp_cm,alpha_exp_cd,alpha_exp_cn,alpha_exp_cc,cl_exp,cm_exp,cd_exp,cn_exp,cc_exp] = struct2vars(data);
        % Mohamed & Wood (2020)
        file1 = '../Other Data/S809_Mohamed_N8_cn.mat';
        file2 = '../Other Data/S809_Mohamed_N8_cm.mat';
        file3 = '../Other Data/S809_Mohamed_N8_cc.mat';
        load(file1)
        load(file2)
        load(file3)
        alpha_mod_cn = S809_Mohamed_N8_cn(:,1);
        cn_mod       = S809_Mohamed_N8_cn(:,2);
        alpha_mod_cm = S809_Mohamed_N8_cm(:,1);
        cm_mod       = S809_Mohamed_N8_cm(:,2);
        alpha_mod_cc = S809_Mohamed_N8_cc(:,1);
        cc_mod       = S809_Mohamed_N8_cc(:,2);
        alpha_mod_cl = nan; cl_mod = nan; alpha_mod_cd = nan; cd_mod = nan;
        authors{2} = 'Mohamed and Wood (2020)';     
    case 7 % Sheng et al (2008) - A Modified Dynamic Stall Model for Low Mach Numbers - Fig. 10
        % Test conditions
        M = 0.12;
        a_0 = 15.3*pi/180;
        a_1 = 9.9*pi/180;
        k = 0.074;
        authors{1} = 'EXP - Sheng et al. (2008)';
        authors{2} = 'MOD - Sheng et al. (2008)';
        b = 0.55/2;             % As displayed in Table 1 of Sheng et al (2006) - A New Stall-Onset Criterion for Low Speed Dynamic-Stall
        a_inf = 340;            % Assumed MSL conditions
        ah = -1/2;              % Semichord-normalized pitch axis position after midchord
        airfoil = 'S809';
        % Experimental data
        file1 = '../Other Data/CN_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP.mat';
        file2 = '../Other Data/CM_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP.mat';
        file3 = '../Other Data/CC_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP.mat';
        file4 = '../Other Data/CD_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP.mat';
        load(file1)
        load(file2)
        load(file3)
        load(file4)
        alpha_exp_cn = CN_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP(:,1);
        cn_exp = CN_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP(:,2);
        alpha_exp_cm = CM_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP(:,1);
        cm_exp = CM_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP(:,2);
        alpha_exp_cd = CD_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP(:,1);
        cd_exp = CD_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP(:,2);
        alpha_exp_cc = CC_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP(:,1);
        cc_exp = CC_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_EXP(:,2);
        alpha_exp_cl = nan; cl_exp = nan;
        % Model
        file1 = '../Other Data/CN_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD.mat';
        file2 = '../Other Data/CM_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD.mat';
        file3 = '../Other Data/CC_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD.mat';
        file4 = '../Other Data/CD_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD.mat';
        load(file1)
        load(file2)
        load(file3)
        load(file4)
        alpha_mod_cn = CN_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD(:,1);
        cn_mod = CN_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD(:,2);
        alpha_mod_cm = CM_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD(:,1);
        cm_mod = CM_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD(:,2);
        alpha_mod_cd = CD_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD(:,1);
        cd_mod = CD_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD(:,2);
        alpha_mod_cc = CC_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD(:,1);
        cc_mod = CC_alpha_Sheng_S809_A0_15_A1_10_k0074_M0012_MOD(:,2);
        alpha_mod_cl = nan; cl_mod = nan;
    otherwise
        error('test case not available')
end

% Additional flow variables
U = M*a_inf;
beta = sqrt(1-M^2);

%% Set all flow and test condition variables into the params struct
params = variables2struct(struct,airfoil,ah,M,U,b,a_inf,beta,a_0,a_1,k);

%% Set on data structure
data = variables2struct(struct,authors,alpha_exp_cl,alpha_exp_cm,alpha_exp_cd,alpha_exp_cn,alpha_exp_cc,cl_exp,cm_exp,cd_exp,cn_exp,cc_exp,alpha_mod_cl,alpha_mod_cm,alpha_mod_cd,alpha_mod_cn,alpha_mod_cc,cl_mod,cm_mod,cd_mod,cn_mod,cc_mod);

end