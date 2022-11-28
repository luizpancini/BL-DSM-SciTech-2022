function [alpha_cr,theta,theta_max,theta_min,RD_m,R_max,S,upstroke,downstroke_beginning,stall_beginning,in_stall,T_flag_downstroke,t_ub,t_db,T_ub,T_db,RD_ub,RD_db,T_s,theta_c,theta_c_db] = BL_stall_onset(t,t_ub,t_db,tv0,RD_ub,RD_db,theta_c_db,RD_tv0,theta_i,alpha_lag_i,R_i,upstroke_i,S_i,T_flag_downstroke,theta_max,theta_min,RD_m,R_max,alpha_lag,q_bar,R,RD,RD_theta,alpha_ds0,alpha_ss,alpha1_0c,Tf)

%% Critical angle for dynamic stall
alpha_cr = alpha_ss+(alpha_ds0-alpha_ss)*RD_theta;   

%% Dynamic stall onset ratio
theta = alpha_lag/alpha_cr;

%% Chordwise force stall onset ratio
theta_c = abs(alpha_lag)/alpha1_0c;

%% Update extremes
% Update maximum capped reduced pitch rate
if R > R_i
    R_max = R;
end
% Update maximum stall onset ratio and corresponding delayed capped reduced pitch rate (update only for increments in the lagged AoA)
if abs(theta) > abs(theta_i) && abs(alpha_lag) > abs(alpha_lag_i)
    theta_max = theta;
    RD_m = RD;
end
% Update minimum stall onset ratio (update only for decrements in the lagged AoA and when in the upstroke)
if abs(theta) < abs(theta_i) && abs(alpha_lag) < abs(alpha_lag_i) && theta*q_bar>0
    theta_min = theta;
end

%% Stall condition and motion indicators
% Flags
S = abs(theta_max) > 1;                             % TF for stalled condition (S = 1: stall has occurred, S = 0: stall has not occured)
upstroke = theta*q_bar>=0;                          % TF for upstroke
stall_beginning = S & ~S_i;                         % TF for beginning of stall
in_stall = abs(theta) > 1;                          % TF for currently stalled flow;
if stall_beginning && ~upstroke
    T_flag_downstroke = false;                      % Flag to use T_db instead of T_s for the calculation of separation point in the stalled downstroke
end
if upstroke_i == -1                                 % Neither upstroke nor downstroke (zero pitch rate)
    upstroke_beginning = upstroke;                  % TF for beginning of upstroke
    downstroke_beginning = ~upstroke;               % TF for beginning of downstroke
else
    upstroke_beginning = upstroke & ~upstroke_i;    
    downstroke_beginning = ~upstroke & upstroke_i;  
end
% Time instances
if upstroke_beginning
    t_ub = t;                                       % Time upstroke began
    RD_ub = max([0.1,RD]);                          % Corresponding delayed capped reduced pitch rate
    T_flag_downstroke = true;
end
if downstroke_beginning
    t_db = t;                                       % Time downstroke began
    RD_db = max([0.1,RD]);                          % Corresponding delayed capped reduced pitch rate
    theta_c_db = theta_c;                           % Chordwise force stall onset at begin of downstroke
end
% Time decay functions
T_ub = exp(-(t-t_ub)*RD_ub^2/Tf);                  % For build-up of breakpoint angle offset in the upstroke
T_db = exp(-10*(t-t_db)*RD_db^2/Tf);               % For build-up of breakpoint angle offset in the downstroke 
T_s =  exp(-5*(t-tv0)*max([0.1,RD_tv0])^2/Tf);     % For build-up of breakpoint angle offset in the downstroke after stall 

end