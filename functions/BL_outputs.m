function y = BL_outputs(t,x,tv0,t_ub,t_db,theta_i,alpha_lag_i,R_i,upstroke_i,S_i,T_flag_downstroke,dalpha_n_i,dalpha_db,fprime_n_i,fprime_m_i,fprime_c_i,fprime_n_db,fprime_m_db,fprime_c_db,RD_ub,RD_db,theta_c_db,theta_max,theta_min,RD_m,R_max,RD_tv0,f_diff_tv0,theta_tv0,Tv_tv0,f_diff_tv0_2,f_diff_tv0_3,b,ah,U,M,beta,k,a_0,a_1,K_a,K_aM,K_q,K_qM,T_I,b1,b2,b3,b4,b5,A1,A2,A3,A4,alpha_0L,alpha1_0n,alpha1_0m,alpha1_0c,alpha2_0n,alpha2_0m,alpha2_0c,alpha_ds0,alpha_ss,beta_S1n_u,beta_S1m_u,beta_S1c_u,beta_S1n_d,beta_S1m_d,beta_S1c_d,beta_S2n_u,beta_S2m_u,beta_S2c_u,beta_S2n_d,beta_S2m_d,beta_S2c_d,beta_S3n_u,beta_S3m_u,beta_S3c_u,beta_S3n_d,beta_S3m_d,beta_S3c_d,delta_alpha_0,delta_alpha_1,delta_alpha_u,eta,kappa_0,kappa_1,kappa_2,kappa_3,lambda_1,lambda_2,nu_1,nu_2,nu_3,nu_4,chi_v,c_d0,c_m0,c_n_alpha,d_cc,d_cm,E1,f0_n,f0_m,f0_c,fb1_n,fb1_m,fb1_c,fb2_n,fb2_m,fb2_c,g_v,K0,K1,K2,r0,S1,S1_c,S2,S3,S3_c,Ta,Tf,Tv,Vn1,Vn2,Vm,x_ac,z_cc,z_cm)

%% Kinematics
[alpha,alpha_tqc,q,qR,R] = BL_kinematics(t,U,b,ah,k,a_0,a_1,r0);

%% States
alpha_lag = x(9);
f2prime_n = x(10);
f2prime_m = x(11);
f2prime_c = x(12);
RD = x(13);
RD_theta = x(14);

%% Stall onset criterion, stall and motion qualifiers
[alpha_cr,theta,theta_max,theta_min,RD_m,R_max,S,upstroke,downstroke_beginning,stall_beginning,in_stall,T_flag_downstroke,t_ub,t_db,T_ub,T_db,RD_ub,RD_db,T_s,theta_c,theta_c_db] = BL_stall_onset(t,t_ub,t_db,tv0,RD_ub,RD_db,theta_c_db,RD_tv0,theta_i,alpha_lag_i,R_i,upstroke_i,S_i,T_flag_downstroke,theta_max,theta_min,RD_m,R_max,alpha_lag,q,R,RD,RD_theta,alpha_ds0,alpha_ss,alpha1_0c,Tf);

%% Unsteady breakpoint of separation angles
[alpha1_n,alpha1_m,alpha1_c,alpha2_n,alpha2_m,alpha2_c,dalpha_n,dalpha_m,dalpha_c,dalpha_db] = BL_alpha_brk(qR,R,RD_theta,S,upstroke,downstroke_beginning,dalpha_n_i,dalpha_db,alpha1_0n,alpha1_0m,alpha1_0c,alpha2_0n,alpha2_0m,alpha2_0c,delta_alpha_0,delta_alpha_1,delta_alpha_u,d_cm,d_cc,z_cm,z_cc);

%% Separation points
[f_n,f_m,f_c,fprime_n,fprime_m,fprime_c,fprime_n_db,fprime_m_db,fprime_c_db] = BL_sep_points(alpha,alpha_lag,alpha1_n,alpha1_m,alpha1_c,alpha2_n,alpha2_m,alpha2_c,upstroke,downstroke_beginning,R,RD,S,fprime_n_i,fprime_m_i,fprime_c_i,fprime_n_db,fprime_m_db,fprime_c_db,T_db,T_s,T_flag_downstroke,alpha1_0n,alpha1_0m,alpha1_0c,alpha2_0n,alpha2_0m,alpha2_0c,f0_n,f0_m,f0_c,fb1_n,fb1_m,fb1_c,fb2_n,fb2_m,fb2_c,S1,S1_c,S2,S3,S3_c,beta_S1n_u,beta_S1m_u,beta_S1c_u,beta_S1n_d,beta_S1m_d,beta_S1c_d,beta_S2n_u,beta_S2m_u,beta_S2c_u,beta_S2n_d,beta_S2m_d,beta_S2c_d,beta_S3n_u,beta_S3m_u,beta_S3c_u,beta_S3n_d,beta_S3m_d,beta_S3c_d);

%% Find time of stall onset
tau_v = max([0 t-tv0]);

%% Time delay variables
[Tf_n,Tf_m,Tf_c,Ta_theta] = BL_time_constants(theta,R,RD,Ta,Tf,lambda_1,lambda_2);

%% Airloads coefficients
% Vortex overshoots  
[c_nv,c_mv,c_cv] = BL_vortex_overshoots(tau_v,theta_tv0,f_diff_tv0,RD_tv0,Tv_tv0,f_diff_tv0_2,f_diff_tv0_3,nu_1,nu_2,nu_3,nu_4,g_v,Tv,chi_v,Vm,Vn1,Vn2);
% c_n
[c_n,c_nC,c_nf,c_nI,alpha_C] = BL_cn_coeff(x,M,U,b,ah,beta,alpha_tqc,c_n_alpha,A1,A2,b1,b2,K_a,K_q,T_I,alpha,q,f2prime_n,alpha_0L,c_nv);
% c_m
[c_m,c_mC,c_mf,c_mI,dCP] = BL_cm_coeff(x,U,b,ah,M,beta,alpha,q,R,RD,theta,S,upstroke,c_mv,c_nC,c_nf,f2prime_m,A3,A4,b3,b4,b5,K_aM,K_qM,T_I,kappa_0,kappa_1,kappa_2,kappa_3,c_m0,K0,K1,K2,x_ac);
% c_c
c_c = BL_cc_coeff(alpha,alpha_C,f2prime_c,RD,c_cv,alpha_0L,eta,c_d0,c_n_alpha,E1,upstroke,theta_c,theta_c_db);
 
%% Outputs
y = [alpha, q, qR, R, alpha_cr, theta, theta_min, theta_max, S, alpha1_n, alpha1_m, alpha1_c, alpha2_n, alpha2_m, alpha2_c, dalpha_n, dalpha_m, dalpha_c, f_n, f_m, f_c, fprime_n, fprime_m, fprime_c, Tf_n, Tf_m, Tf_c, Ta_theta, alpha_C, c_n, c_nC, c_nI, c_nf, c_nv, c_m, c_mC, c_mI, c_mf, c_mv, dCP, c_c, RD_tv0, f_diff_tv0, Tv_tv0, f_diff_tv0_2];

end