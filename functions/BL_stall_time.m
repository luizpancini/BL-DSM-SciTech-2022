function [tv0,tau_v,f_diff_tv0,RD_tv0,Tv_tv0,theta_tv0,f_diff_tv0_2,f_diff_tv0_3,V2F,V3F] = BL_stall_time(stall_beginning,tv0,theta_tv0,f_diff_tv0,RD_tv0,Tv_tv0,f_diff_tv0_2,f_diff_tv0_3,V2F,V3F,t_i,alpha_lag_i,alpha_cr_i,t,alpha_lag,alpha_cr,theta,RD,f_n,f2prime_n,upstroke,gamma_v,g_v,Tv)

%% Stall beginning - primary DSV
if stall_beginning && t>t_i
    % Linear interpolation for time of vortex shedding at positive AoA
    m_so = (alpha_lag-alpha_lag_i)/(t-t_i);
    m_so_lim = (alpha_cr-alpha_cr_i)/(t-t_i);
    tv0 = t_i + (alpha_cr_i-alpha_lag_i)/(m_so-m_so_lim); 
    % Difference between delayed and steady separation points at time of vortex shedding
    f_diff_tv0 = f2prime_n-f_n;
    % Stall onset ratio at time of vortex shedding (-1 or +1)
    theta_tv0 = theta;
    % Delayed capped reduced pitch rate ratio at time of vortex shedding
    RD_tv0 = RD;
    % Vortex convection time constant defined at time of vortex shedding   
    Tv_tv0 = max([Tv/2,Tv*(1+(gamma_v*((1-f_diff_tv0)^8+RD_tv0*~upstroke)))]);
    % Set flag to allow second vortex
    V2F = 1; 
end
% Time since primary vortex shedding 
tau_v = max([0, t-tv0]); 

%% Secondary DSVs
if tau_v >= (2+g_v)*Tv_tv0 && V2F == 1
    % Difference between delayed and steady separation points at time of vortex shedding
    f_diff_tv0_2 = f2prime_n-f_n;
    % Update flag
    V2F = 0;
    % Set flag to allow third vortex if still in the upstroke
    V3F = upstroke;
end
if tau_v >= (4+2*g_v)*Tv_tv0 && V3F == 1
    % Difference between delayed and steady separation points at time of vortex shedding
    f_diff_tv0_3 = f2prime_n-f_n;
    % Update flag
    V3F = 0;
end

end