function [outputs,tp,xp,yp,xdotp] = BL_RKF45(tspan,x0,y0,params,RKF_options)

%% Setup the algorithm
% Initialize RK5 algorithm's variables
[display_progress,c5,c45,dt,dt_lim,i,tc,ti,tf,RKF_it_max,RKFtol,tp,xp,yp,xdotp,x_i,xdot_i] = setup_RKF45(tspan,x0,y0,RKF_options);
% Unpack model's parameters
[U,M,b,ah,a_0,a_1,k,beta,A,alpha_0L,alpha_ds0,alpha_ss,alpha1_0n,alpha1_0m,alpha1_0c,alpha2_0n,alpha2_0m,alpha2_0c,beta_S1n_u,beta_S1m_u,beta_S1c_u,beta_S1n_d,beta_S1m_d,beta_S1c_d,beta_S2n_u,beta_S2m_u,beta_S2c_u,beta_S2n_d,beta_S2m_d,beta_S2c_d,beta_S3n_u,beta_S3m_u,beta_S3c_u,beta_S3n_d,beta_S3m_d,beta_S3c_d,gamma_v,delta_alpha_0,delta_alpha_1,delta_alpha_u,eta,kappa_0,kappa_1,kappa_2,kappa_3,lambda_1,lambda_2,nu_1,nu_2,nu_3,nu_4,chi_v,c_d0,c_m0,c_n_alpha,d_cc,d_cm,E1,f0_n,f0_m,f0_c,fb1_n,fb1_m,fb1_c,fb2_n,fb2_m,fb2_c,g_v,K0,K1,K2,r0,S1,S1_c,S2,S3,S3_c,Ta,Tf,Tv,Vm,Vn1,Vn2,x_ac,z_cc,z_cm,A1,A2,A3,A4,b1,b2,b3,b4,b5,K_a,K_aM,K_q,K_qM,T_I] = BL_unpack_params(params);
% Initialize model's complementary variables
tv0 = 0; t_ub = 0; t_db = 0; alpha_lag_i = 0; alpha_cr_i = 1; theta_i = 0; R_i = 0; RD_tv0 = 0; f_diff_tv0 = 0; Tv_tv0 = -1e4; theta_tv0 = 0; f_diff_tv0_2 = 0; f_diff_tv0_3 = 0;  V2F = 0; V3F = 0; theta_min_i = 0; theta_max_i = 1; RD_m_i = 1; R_max_i = 1;
upstroke_i = -1; dalpha_n_i = 0; dalpha_db_i = 0; fprime_n_i = 1; fprime_m_i = 1; fprime_c_i = 1; fprime_n_db_i = 1; fprime_m_db_i = 1; fprime_c_db_i = 1; RD_ub_i = 0; RD_db_i = 0; theta_c_db_i = 0; S_i = 0; T_flag_downstroke_i = true;

%% Solve the ODEs            
% Loop over time steps
while tc < tf
    % Reset iterations counters and error
    eps = 10*RKFtol;                          
    RKF_it = 0;               
    % Loop until convergence is reached
    while eps > RKFtol 
        % Adjust for last time step
        dt = min([dt,tf-tc]); 
        % RKF45 steps
        [xdot1,tv0,t_ub,t_db,alpha_i,q_i,R_i,alpha_lag_i,alpha_cr_i,dalpha_n_i,dalpha_db_i,fprime_n_i,fprime_m_i,fprime_c_i,fprime_n_db_i,fprime_m_db_i,fprime_c_db_i,RD_ub_i,RD_db_i,theta_c_db_i] = BL_dxdt(tc,x_i,xdot_i,tc,tv0,t_ub,t_db,RD_tv0,f_diff_tv0,Tv_tv0,theta_tv0,f_diff_tv0_2,f_diff_tv0_3,V2F,V3F,alpha_lag_i,alpha_cr_i,theta_i,R_i,upstroke_i,S_i,T_flag_downstroke_i,theta_max_i,theta_min_i,RD_m_i,R_max_i,dalpha_n_i,dalpha_db_i,fprime_n_i,fprime_m_i,fprime_c_i,fprime_n_db_i,fprime_m_db_i,fprime_c_db_i,RD_ub_i,RD_db_i,theta_c_db_i,A,U,b,ah,a_0,a_1,k,alpha1_0n,alpha1_0m,alpha1_0c,alpha2_0n,alpha2_0m,alpha2_0c,alpha_ds0,alpha_ss,beta_S1n_u,beta_S1m_u,beta_S1c_u,beta_S1n_d,beta_S1m_d,beta_S1c_d,beta_S2n_u,beta_S2m_u,beta_S2c_u,beta_S2n_d,beta_S2m_d,beta_S2c_d,beta_S3n_u,beta_S3m_u,beta_S3c_u,beta_S3n_d,beta_S3m_d,beta_S3c_d,gamma_v,delta_alpha_0,delta_alpha_1,delta_alpha_u,lambda_1,lambda_2,d_cm,d_cc,f0_n,f0_m,f0_c,fb1_n,fb1_m,fb1_c,fb2_n,fb2_m,fb2_c,g_v,r0,S1,S1_c,S2,S3,S3_c,Ta,Tf,Tv,z_cm,z_cc); 
        x1 = x_i + xdot1*dt/4;
        [xdot2,tv0,t_ub,t_db] = BL_dxdt(tc+dt/4,x1,xdot_i,tc,tv0,t_ub,t_db,RD_tv0,f_diff_tv0,Tv_tv0,theta_tv0,f_diff_tv0_2,f_diff_tv0_3,V2F,V3F,alpha_lag_i,alpha_cr_i,theta_i,R_i,upstroke_i,S_i,T_flag_downstroke_i,theta_max_i,theta_min_i,RD_m_i,R_max_i,dalpha_n_i,dalpha_db_i,fprime_n_i,fprime_m_i,fprime_c_i,fprime_n_db_i,fprime_m_db_i,fprime_c_db_i,RD_ub_i,RD_db_i,theta_c_db_i,A,U,b,ah,a_0,a_1,k,alpha1_0n,alpha1_0m,alpha1_0c,alpha2_0n,alpha2_0m,alpha2_0c,alpha_ds0,alpha_ss,beta_S1n_u,beta_S1m_u,beta_S1c_u,beta_S1n_d,beta_S1m_d,beta_S1c_d,beta_S2n_u,beta_S2m_u,beta_S2c_u,beta_S2n_d,beta_S2m_d,beta_S2c_d,beta_S3n_u,beta_S3m_u,beta_S3c_u,beta_S3n_d,beta_S3m_d,beta_S3c_d,gamma_v,delta_alpha_0,delta_alpha_1,delta_alpha_u,lambda_1,lambda_2,d_cm,d_cc,f0_n,f0_m,f0_c,fb1_n,fb1_m,fb1_c,fb2_n,fb2_m,fb2_c,g_v,r0,S1,S1_c,S2,S3,S3_c,Ta,Tf,Tv,z_cm,z_cc);
        x2 = x_i + (3/32*xdot1+9/32*xdot2)*dt;
        [xdot3,tv0,t_ub,t_db] = BL_dxdt(tc+3/8*dt,x2,xdot_i,tc,tv0,t_ub,t_db,RD_tv0,f_diff_tv0,Tv_tv0,theta_tv0,f_diff_tv0_2,f_diff_tv0_3,V2F,V3F,alpha_lag_i,alpha_cr_i,theta_i,R_i,upstroke_i,S_i,T_flag_downstroke_i,theta_max_i,theta_min_i,RD_m_i,R_max_i,dalpha_n_i,dalpha_db_i,fprime_n_i,fprime_m_i,fprime_c_i,fprime_n_db_i,fprime_m_db_i,fprime_c_db_i,RD_ub_i,RD_db_i,theta_c_db_i,A,U,b,ah,a_0,a_1,k,alpha1_0n,alpha1_0m,alpha1_0c,alpha2_0n,alpha2_0m,alpha2_0c,alpha_ds0,alpha_ss,beta_S1n_u,beta_S1m_u,beta_S1c_u,beta_S1n_d,beta_S1m_d,beta_S1c_d,beta_S2n_u,beta_S2m_u,beta_S2c_u,beta_S2n_d,beta_S2m_d,beta_S2c_d,beta_S3n_u,beta_S3m_u,beta_S3c_u,beta_S3n_d,beta_S3m_d,beta_S3c_d,gamma_v,delta_alpha_0,delta_alpha_1,delta_alpha_u,lambda_1,lambda_2,d_cm,d_cc,f0_n,f0_m,f0_c,fb1_n,fb1_m,fb1_c,fb2_n,fb2_m,fb2_c,g_v,r0,S1,S1_c,S2,S3,S3_c,Ta,Tf,Tv,z_cm,z_cc);
        x3 = x_i + (1932*xdot1-7200*xdot2+7296*xdot3)/2197*dt;
        [xdot4,tv0,t_ub,t_db] = BL_dxdt(tc+12/13*dt,x3,xdot_i,tc,tv0,t_ub,t_db,RD_tv0,f_diff_tv0,Tv_tv0,theta_tv0,f_diff_tv0_2,f_diff_tv0_3,V2F,V3F,alpha_lag_i,alpha_cr_i,theta_i,R_i,upstroke_i,S_i,T_flag_downstroke_i,theta_max_i,theta_min_i,RD_m_i,R_max_i,dalpha_n_i,dalpha_db_i,fprime_n_i,fprime_m_i,fprime_c_i,fprime_n_db_i,fprime_m_db_i,fprime_c_db_i,RD_ub_i,RD_db_i,theta_c_db_i,A,U,b,ah,a_0,a_1,k,alpha1_0n,alpha1_0m,alpha1_0c,alpha2_0n,alpha2_0m,alpha2_0c,alpha_ds0,alpha_ss,beta_S1n_u,beta_S1m_u,beta_S1c_u,beta_S1n_d,beta_S1m_d,beta_S1c_d,beta_S2n_u,beta_S2m_u,beta_S2c_u,beta_S2n_d,beta_S2m_d,beta_S2c_d,beta_S3n_u,beta_S3m_u,beta_S3c_u,beta_S3n_d,beta_S3m_d,beta_S3c_d,gamma_v,delta_alpha_0,delta_alpha_1,delta_alpha_u,lambda_1,lambda_2,d_cm,d_cc,f0_n,f0_m,f0_c,fb1_n,fb1_m,fb1_c,fb2_n,fb2_m,fb2_c,g_v,r0,S1,S1_c,S2,S3,S3_c,Ta,Tf,Tv,z_cm,z_cc);
        x4 = x_i + (439/216*xdot1-8*xdot2+3680/513*xdot3-845/4104*xdot4)*dt;
        [xdot5,tv0,t_ub,t_db,alpha_ip1,q_ip1,R_ip1,alpha_lag_ip1,alpha_cr_ip1,dalpha1_n_ip1,dalpha1_db_ip1,fprime_n_ip1,fprime_m_ip1,fprime_c_ip1,fprime_n_db_ip1,fprime_m_db_ip1,fprime_c_db_ip1,RD_ub_ip1,RD_db_ip1,theta_c_db_ip1,RD_tv0,f_diff_tv0,Tv_tv0,theta_tv0,f_diff_tv0_2,f_diff_tv0_3,V2F,V3F] = BL_dxdt(tc+dt,x4,xdot_i,tc,tv0,t_ub,t_db,RD_tv0,f_diff_tv0,Tv_tv0,theta_tv0,f_diff_tv0_2,f_diff_tv0_3,V2F,V3F,alpha_lag_i,alpha_cr_i,theta_i,R_i,upstroke_i,S_i,T_flag_downstroke_i,theta_max_i,theta_min_i,RD_m_i,R_max_i,dalpha_n_i,dalpha_db_i,fprime_n_i,fprime_m_i,fprime_c_i,fprime_n_db_i,fprime_m_db_i,fprime_c_db_i,RD_ub_i,RD_db_i,theta_c_db_i,A,U,b,ah,a_0,a_1,k,alpha1_0n,alpha1_0m,alpha1_0c,alpha2_0n,alpha2_0m,alpha2_0c,alpha_ds0,alpha_ss,beta_S1n_u,beta_S1m_u,beta_S1c_u,beta_S1n_d,beta_S1m_d,beta_S1c_d,beta_S2n_u,beta_S2m_u,beta_S2c_u,beta_S2n_d,beta_S2m_d,beta_S2c_d,beta_S3n_u,beta_S3m_u,beta_S3c_u,beta_S3n_d,beta_S3m_d,beta_S3c_d,gamma_v,delta_alpha_0,delta_alpha_1,delta_alpha_u,lambda_1,lambda_2,d_cm,d_cc,f0_n,f0_m,f0_c,fb1_n,fb1_m,fb1_c,fb2_n,fb2_m,fb2_c,g_v,r0,S1,S1_c,S2,S3,S3_c,Ta,Tf,Tv,z_cm,z_cc);
        x5 = x_i + (-8/27*xdot1+2*xdot2-3544/2565*xdot3+1859/4104*xdot4-11/40*xdot5)*dt;
        [xdot6,tv0,t_ub,t_db] = BL_dxdt(tc+dt/2,x5,xdot_i,tc,tv0,t_ub,t_db,RD_tv0,f_diff_tv0,Tv_tv0,theta_tv0,f_diff_tv0_2,f_diff_tv0_3,V2F,V3F,alpha_lag_i,alpha_cr_i,theta_i,R_i,upstroke_i,S_i,T_flag_downstroke_i,theta_max_i,theta_min_i,RD_m_i,R_max_i,dalpha_n_i,dalpha_db_i,fprime_n_i,fprime_m_i,fprime_c_i,fprime_n_db_i,fprime_m_db_i,fprime_c_db_i,RD_ub_i,RD_db_i,theta_c_db_i,A,U,b,ah,a_0,a_1,k,alpha1_0n,alpha1_0m,alpha1_0c,alpha2_0n,alpha2_0m,alpha2_0c,alpha_ds0,alpha_ss,beta_S1n_u,beta_S1m_u,beta_S1c_u,beta_S1n_d,beta_S1m_d,beta_S1c_d,beta_S2n_u,beta_S2m_u,beta_S2c_u,beta_S2n_d,beta_S2m_d,beta_S2c_d,beta_S3n_u,beta_S3m_u,beta_S3c_u,beta_S3n_d,beta_S3m_d,beta_S3c_d,gamma_v,delta_alpha_0,delta_alpha_1,delta_alpha_u,lambda_1,lambda_2,d_cm,d_cc,f0_n,f0_m,f0_c,fb1_n,fb1_m,fb1_c,fb2_n,fb2_m,fb2_c,g_v,r0,S1,S1_c,S2,S3,S3_c,Ta,Tf,Tv,z_cm,z_cc);
        xdot_steps = [xdot1, xdot2, xdot3, xdot4, xdot5, xdot6];
        % Error between 5th and 4th order RKF approximations   
        eps = norm(xdot_steps*c45)*dt;  
        % Check RKF steps tolerance    
        if eps > RKFtol
            % Increase iteration count
            RKF_it = RKF_it+1;  
            % If maximum number of RKF iterations is reached, break the loop
            if RKF_it >= RKF_it_max, break; end
            % Halve time step and restart
            dt = dt/2; continue;
        end
    end
    % Update states rates 
    xdot_i = xdot_steps*c5;
    % Update states array
    x_ip1 = x_i + xdot_i*dt;
    % Update storage arrays
    tp(i+1) = tc+dt;      
    xp(:,i+1) = x_ip1;
    xdotp(:,i) = xdot_i;
    yp(:,i+1) = BL_outputs(tc+dt,x_ip1,tv0,t_ub,t_db,theta_i,alpha_lag_i,R_i,upstroke_i,S_i,T_flag_downstroke_i,dalpha_n_i,dalpha_db_i,fprime_n_i,fprime_m_i,fprime_c_i,fprime_n_db_i,fprime_m_db_i,fprime_c_db_i,RD_ub_i,RD_db_i,theta_c_db_i,theta_max_i,theta_min_i,RD_m_i,R_max_i,RD_tv0,f_diff_tv0,theta_tv0,Tv_tv0,f_diff_tv0_2,f_diff_tv0_3,b,ah,U,M,beta,k,a_0,a_1,K_a,K_aM,K_q,K_qM,T_I,b1,b2,b3,b4,b5,A1,A2,A3,A4,alpha_0L,alpha1_0n,alpha1_0m,alpha1_0c,alpha2_0n,alpha2_0m,alpha2_0c,alpha_ds0,alpha_ss,beta_S1n_u,beta_S1m_u,beta_S1c_u,beta_S1n_d,beta_S1m_d,beta_S1c_d,beta_S2n_u,beta_S2m_u,beta_S2c_u,beta_S2n_d,beta_S2m_d,beta_S2c_d,beta_S3n_u,beta_S3m_u,beta_S3c_u,beta_S3n_d,beta_S3m_d,beta_S3c_d,delta_alpha_0,delta_alpha_1,delta_alpha_u,eta,kappa_0,kappa_1,kappa_2,kappa_3,lambda_1,lambda_2,nu_1,nu_2,nu_3,nu_4,chi_v,c_d0,c_m0,c_n_alpha,d_cc,d_cm,E1,f0_n,f0_m,f0_c,fb1_n,fb1_m,fb1_c,fb2_n,fb2_m,fb2_c,g_v,K0,K1,K2,r0,S1,S1_c,S2,S3,S3_c,Ta,Tf,Tv,Vn1,Vn2,Vm,x_ac,z_cc,z_cm);
    % Update extremes and flags
    [theta_min_i,theta_max_i,RD_m_i,R_max_i,S_i,upstroke_i,T_flag_downstroke_i] = BL_so_ratio_extremes(x_i(9),x_i(9)/alpha_cr_i,R_i,S_i,x_ip1(9),x_ip1(9)/alpha_cr_ip1,R_ip1,q_ip1,x_ip1(13),theta_min_i,theta_max_i,RD_m_i,R_max_i,S_i,upstroke_i,T_flag_downstroke_i);  
    % Setup next time step
    tc = tc+dt;
    x_i = x_ip1;
    alpha_lag_i = x_ip1(9);
    alpha_cr_i = alpha_cr_ip1;
    R_i = R_ip1;
    theta_i = x_ip1(9)/alpha_cr_ip1;
    dalpha_n_i = dalpha1_n_ip1;
    dalpha_db_i = dalpha1_db_ip1;
    fprime_n_i = fprime_n_ip1;
    fprime_m_i = fprime_m_ip1;
    fprime_c_i = fprime_c_ip1;
    fprime_n_db_i = fprime_n_db_ip1;
    fprime_m_db_i = fprime_m_db_ip1;
    fprime_c_db_i = fprime_c_db_ip1;
    RD_ub_i = RD_ub_ip1;
    RD_db_i = RD_db_ip1;
    theta_c_db_i = theta_c_db_ip1;
    i = i+1;
    % Adjust time step
    dt = min(dt_lim,dt*min([4,(eps/RKFtol)^(-1/5)]));
    % Display progress
    if rem(i,1e4) == 0 && display_progress
        disp(['RKF45 progress: ',num2str((tc-ti)/(tf-ti)*100,'%10.2f') '%'])
    end
end

% Assume last time step derivatives equal to previous
xdotp(:,i) = xdotp(:,i-1);

% Truncate pre-allocated arrays
tp = tp(1:i); xp = xp(:,1:i); yp = yp(:,1:i); xdotp = xdotp(:,1:i);

% Get outputs structure
outputs = BL_output_vars(tp,xp,yp,xdotp);

end