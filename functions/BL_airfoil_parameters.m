function params = BL_airfoil_parameters(params,airfoil,M,U,b)

%% Airfoil parameters table - as functions of Mach number
switch airfoil
    case 'S809'
        % Interpolation strategy
        interp_mode = 'linear';
        % Bound limits
        M = max([0.075,min([0.15,M])]);
        % Mach-dependent parameters
        Mach_range =                [0.075;             0.15];
        alpha_0L_range =     pi/180*[-0.56;             -0.7];
        alpha_ds0_range =    pi/180*[22.05;             21.32];
        alpha_ss_range =     pi/180*[19.3;              19.0];
        alpha1_0n_range =    pi/180*[11.3;              11.4];
        alpha1_0m_range =    pi/180*[8.7;               8.5];
        alpha1_0c_range =    pi/180*[16.9;              17.1];
        alpha2_0n_range =    pi/180*[19.5;              19.9];
        alpha2_0m_range =    pi/180*[19.9;              19.5];
        alpha2_0c_range =    pi/180*[21.3;              22.0];
        beta_S1n_u_range =          [-0.36;             -0.40];
        beta_S1m_u_range =          [0.83;              3.97];     
        beta_S1c_u_range =          [-0.70;             -0.80];       
        beta_S1n_d_range =          [2.61;              1.23];     
        beta_S1m_d_range =          [-0.73;             -0.75];    
        beta_S1c_d_range =          [3.95;              3.97];         
        beta_S2n_u_range =          [0.12;              -0.73];       
        beta_S2m_u_range =          [-0.87;             2.63];      
        beta_S2c_u_range =          [1.27;              2.08];       
        beta_S2n_d_range =          [1.83;              1.60];       
        beta_S2m_d_range =          [-0.69;             -0.52];      
        beta_S2c_d_range =          [0.60;              3.29]; 
        beta_S3n_u_range =          [-0.78;             0.65];       
        beta_S3m_u_range =          [2.97;              3.17];      
        beta_S3c_u_range =          [0.37;              4.0];       
        beta_S3n_d_range =          [1.75;              -0.01];       
        beta_S3m_d_range =          [0.91;              0.56];      
        beta_S3c_d_range =          [3.88;              3.93];
        gamma_v_range =             [8.1;               9.8];
        delta_alpha_0_range= pi/180*[0.1;               0.0];
        delta_alpha_1_range= pi/180*[1.0;               0.54];
        delta_alpha_u_range= pi/180*[6.1;               6.7];
        eta_range =                 [0.049;             0.035];
        kappa_0_range =             [0.349;             0.347];
        kappa_1_range =             [0.31;              0.37];
        kappa_2_range =             [0.108;             0.119];
        kappa_3_range =             [0.011;             0.013];
        lambda_1_range =            [15;                0];
        lambda_2_range =            [0.17;              0.18];
        nu_1_range =                [0.29;              0.19];
        nu_2_range =                [0.10;              0.22];
        nu_3_range =                [0.13;              0.11];
        nu_4_range =                [2.6;               2.1];
        chi_v_range =               [1.60;              1.92];
        c_d0_range =                [0.000;             0.000];
        c_m0_range =                [-0.034;            -0.037];
        c_n_alpha_range =      2*pi*[1.089;             1.102];
        d_cc_range =         pi/180*[-2.9;              -2.2];
        d_cm_range =         pi/180*[-1.1;              -2.2];
        E1_range =                  [0.08;              0.08];
        f0_n_range =                [0.0493;            0.0478];
        f0_m_range =                [0.0045;            0.0031];
        f0_c_range =                [0.0092;            0.0091];
        fb1_n_range =               [0.353;             0.355];
        fb1_m_range =               [0.435;             0.444];
        fb1_c_range =               [0.533;             0.525];
        fb2_n_range =               [0.0073;            0.010];
        fb2_m_range =               [0.021;             0.024];
        fb2_c_range =               [0.0078;            0.0098];
        g_v_range =                 [-1.0;              -0.95];
        K0_range =                  [-0.031;            -0.032];
        K1_range =                  [-0.219;            -0.212];
        K2_range =                  [0.206;             0.203];
        r0_range =                  [1.977e-2;          1.907e-2];
        S1_range =           pi/180*[4.05;              4.65];
        S1_c_range =         pi/180*[11.1;              12.0];
        S2_range =           pi/180*[3.40;              3.44];
        S3_range =                  [0.88;              0.90];
        S3_c_range =                [0.25;              0.25];
        Ta_range =                  [1.93;              1.52];
        Tf_range =                  [2.77;              3.75];
        Tv_range =                  [3.72;              4.13];
        Vm_range =                  [0.207;             0.180];
        Vn1_range =                 [1.09;              0.60];
        Vn2_range =                 [0.93;              1.32];
        z_cc_range =                [-2.61;             -0.51];
        z_cm_range =                [2.07;              2.89];          
    otherwise
        error("Airfoil '" + airfoil + "' not listed")
end

%% Interpolated values
alpha_0L =      interp1(Mach_range,alpha_0L_range,M,interp_mode);
alpha_ds0 =     interp1(Mach_range,alpha_ds0_range,M,interp_mode);
alpha_ss =      interp1(Mach_range,alpha_ss_range,M,interp_mode);
alpha1_0n =     interp1(Mach_range,alpha1_0n_range,M,interp_mode);
alpha1_0m =     interp1(Mach_range,alpha1_0m_range,M,interp_mode);
alpha1_0c =     interp1(Mach_range,alpha1_0c_range,M,interp_mode);
alpha2_0n =     interp1(Mach_range,alpha2_0n_range,M,interp_mode);
alpha2_0m =     interp1(Mach_range,alpha2_0m_range,M,interp_mode);
alpha2_0c =     interp1(Mach_range,alpha2_0c_range,M,interp_mode);
beta_S1n_u =    interp1(Mach_range,beta_S1n_u_range,M,interp_mode);
beta_S1m_u =    interp1(Mach_range,beta_S1m_u_range,M,interp_mode);
beta_S1c_u =    interp1(Mach_range,beta_S1c_u_range,M,interp_mode);
beta_S1n_d =    interp1(Mach_range,beta_S1n_d_range,M,interp_mode);
beta_S1m_d =    interp1(Mach_range,beta_S1m_d_range,M,interp_mode);
beta_S1c_d =    interp1(Mach_range,beta_S1c_d_range,M,interp_mode);
beta_S2n_u =    interp1(Mach_range,beta_S2n_u_range,M,interp_mode);
beta_S2m_u =    interp1(Mach_range,beta_S2m_u_range,M,interp_mode);
beta_S2c_u =    interp1(Mach_range,beta_S2c_u_range,M,interp_mode);
beta_S2n_d =    interp1(Mach_range,beta_S2n_d_range,M,interp_mode);
beta_S2m_d =    interp1(Mach_range,beta_S2m_d_range,M,interp_mode);
beta_S2c_d =    interp1(Mach_range,beta_S2c_d_range,M,interp_mode);
beta_S3n_u =    interp1(Mach_range,beta_S3n_u_range,M,interp_mode);
beta_S3m_u =    interp1(Mach_range,beta_S3m_u_range,M,interp_mode);
beta_S3c_u =    interp1(Mach_range,beta_S3c_u_range,M,interp_mode);
beta_S3n_d =    interp1(Mach_range,beta_S3n_d_range,M,interp_mode);
beta_S3m_d =    interp1(Mach_range,beta_S3m_d_range,M,interp_mode);
beta_S3c_d =    interp1(Mach_range,beta_S3c_d_range,M,interp_mode);
gamma_v =       interp1(Mach_range,gamma_v_range,M,interp_mode);
delta_alpha_0 = interp1(Mach_range,delta_alpha_0_range,M,interp_mode);
delta_alpha_1 = interp1(Mach_range,delta_alpha_1_range,M,interp_mode);
delta_alpha_u = interp1(Mach_range,delta_alpha_u_range,M,interp_mode);
eta =           interp1(Mach_range,eta_range,M,interp_mode);
kappa_0 =       interp1(Mach_range,kappa_0_range,M,interp_mode);
kappa_1 =       interp1(Mach_range,kappa_1_range,M,interp_mode);
kappa_2 =       interp1(Mach_range,kappa_2_range,M,interp_mode);
kappa_3 =       interp1(Mach_range,kappa_3_range,M,interp_mode);
lambda_1 =      interp1(Mach_range,lambda_1_range,M,interp_mode);
lambda_2 =      interp1(Mach_range,lambda_2_range,M,interp_mode);
nu_1 =          interp1(Mach_range,nu_1_range,M,interp_mode);
nu_2 =          interp1(Mach_range,nu_2_range,M,interp_mode);
nu_3 =          interp1(Mach_range,nu_3_range,M,interp_mode);
nu_4 =          interp1(Mach_range,nu_4_range,M,interp_mode);
chi_v  =        interp1(Mach_range,chi_v_range,M,interp_mode);
c_d0 =          interp1(Mach_range,c_d0_range,M,interp_mode);
c_m0 =          interp1(Mach_range,c_m0_range,M,interp_mode);
c_n_alpha =     interp1(Mach_range,c_n_alpha_range,M,interp_mode);
d_cc =          interp1(Mach_range,d_cc_range,M,interp_mode);
d_cm =          interp1(Mach_range,d_cm_range,M,interp_mode);
E1 =            interp1(Mach_range,E1_range,M,interp_mode);
f0_n =          interp1(Mach_range,f0_n_range,M,interp_mode);
f0_m =          interp1(Mach_range,f0_m_range,M,interp_mode);
f0_c =          interp1(Mach_range,f0_c_range,M,interp_mode);
fb1_n =         interp1(Mach_range,fb1_n_range,M,interp_mode);
fb1_m =         interp1(Mach_range,fb1_m_range,M,interp_mode);
fb1_c =         interp1(Mach_range,fb1_c_range,M,interp_mode);
fb2_n =         interp1(Mach_range,fb2_n_range,M,interp_mode);
fb2_m =         interp1(Mach_range,fb2_m_range,M,interp_mode);
fb2_c =         interp1(Mach_range,fb2_c_range,M,interp_mode);
g_v =           interp1(Mach_range,g_v_range,M,interp_mode);
K0 =            interp1(Mach_range,K0_range,M,interp_mode);
K1 =            interp1(Mach_range,K1_range,M,interp_mode);
K2 =            interp1(Mach_range,K2_range,M,interp_mode);
r0 =            interp1(Mach_range,r0_range,M,interp_mode);
S1 =            interp1(Mach_range,S1_range,M,interp_mode);
S1_c =          interp1(Mach_range,S1_c_range,M,interp_mode);
S2 =            interp1(Mach_range,S2_range,M,interp_mode);
S3 =            interp1(Mach_range,S3_range,M,interp_mode);
S3_c =          interp1(Mach_range,S3_c_range,M,interp_mode);
Ta =            interp1(Mach_range,Ta_range,M,interp_mode);
Tf =            interp1(Mach_range,Tf_range,M,interp_mode);
Tv =            interp1(Mach_range,Tv_range,M,interp_mode);
Vm =            interp1(Mach_range,Vm_range,M,interp_mode);
Vn1 =           interp1(Mach_range,Vn1_range,M,interp_mode);
Vn2 =           interp1(Mach_range,Vn2_range,M,interp_mode);
z_cc =          interp1(Mach_range,z_cc_range,M,interp_mode);
z_cm =          interp1(Mach_range,z_cm_range,M,interp_mode);
x_ac = 0.25-K0;

%% Override with optmized parameters
load_params = 0;
if load_params && airfoil == "S809"
    filepath = '../S809 parameters optimization/gBestMat_036.mat';
    [alpha_0L,alpha_ds0,alpha_ss,alpha1_0n,alpha1_0m,alpha1_0c,alpha2_0n,alpha2_0m,alpha2_0c,beta_S1n_u,beta_S1m_u,beta_S1c_u,beta_S1n_d,beta_S1m_d,beta_S1c_d,beta_S2n_u,beta_S2m_u,beta_S2c_u,beta_S2n_d,beta_S2m_d,beta_S2c_d,beta_S3n_u,beta_S3m_u,beta_S3c_u,beta_S3n_d,beta_S3m_d,beta_S3c_d,gamma_v,delta_alpha_0,delta_alpha_1,delta_alpha_u,eta,kappa_0,kappa_1,kappa_2,kappa_3,lambda_1,lambda_2,nu_1,nu_2,nu_3,nu_4,chi_v,c_d0,c_m0,c_n_alpha,d_cc,d_cm,E1,f0_n,f0_m,f0_c,fb1_n,fb1_m,fb1_c,fb2_n,fb2_m,fb2_c,g_v,K0,K1,K2,r0,S1,S1_c,S2,S3,S3_c,Ta,Tf,Tv,Vm,Vn1,Vn2,z_cc,z_cm,x_ac] = load_opt_params(filepath);
end

%% Time delay constants adjustment for dimensional time
Ta = Ta*b/U;
Tf = Tf*b/U;
Tv = Tv*b/U;

%% Set parameters structure
params = variables2struct(params,alpha_0L,alpha_ds0,alpha_ss,alpha1_0n,alpha1_0m,alpha1_0c,alpha2_0n,alpha2_0m,alpha2_0c,beta_S1n_u,beta_S1m_u,beta_S1c_u,beta_S1n_d,beta_S1m_d,beta_S1c_d,beta_S2n_u,beta_S2m_u,beta_S2c_u,beta_S2n_d,beta_S2m_d,beta_S2c_d,beta_S3n_u,beta_S3m_u,beta_S3c_u,beta_S3n_d,beta_S3m_d,beta_S3c_d,gamma_v,delta_alpha_0,delta_alpha_1,delta_alpha_u,eta,kappa_0,kappa_1,kappa_2,kappa_3,lambda_1,lambda_2,nu_1,nu_2,nu_3,nu_4,c_d0,c_m0,c_n_alpha,d_cc,d_cm,E1,f0_n,f0_m,f0_c,fb1_n,fb1_m,fb1_c,fb2_n,fb2_m,fb2_c,g_v,K0,K1,K2,r0,S1,S1_c,S2,S3,S3_c,Ta,Tf,Tv,chi_v,Vm,Vn1,Vn2,z_cc,z_cm,x_ac);

end