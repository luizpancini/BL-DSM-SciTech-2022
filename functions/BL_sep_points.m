function [f_n,f_m,f_c,fprime_n,fprime_m,fprime_c,fprime_n_db,fprime_m_db,fprime_c_db] = BL_sep_points(alpha_bar,alpha_lag,alpha1_n,alpha1_m,alpha1_c,alpha2_n,alpha2_m,alpha2_c,upstroke,downstroke_beginning,R,RD,S,fprime_n_i,fprime_m_i,fprime_c_i,fprime_n_db,fprime_m_db,fprime_c_db,T_db,T_s,T_flag_downstroke,alpha1_0n,alpha1_0m,alpha1_0c,alpha2_0n,alpha2_0m,alpha2_0c,f0_n,f0_m,f0_c,fb1_n,fb1_m,fb1_c,fb2_n,fb2_m,fb2_c,S1,S1_c,S2,S3,S3_c,beta_S1n_u,beta_S1m_u,beta_S1c_u,beta_S1n_d,beta_S1m_d,beta_S1c_d,beta_S2n_u,beta_S2m_u,beta_S2c_u,beta_S2n_d,beta_S2m_d,beta_S2c_d,beta_S3n_u,beta_S3m_u,beta_S3c_u,beta_S3n_d,beta_S3m_d,beta_S3c_d)

%% Decay time functions
if T_flag_downstroke 
    T_decay_n = T_db^3; T_decay_m = T_db^4; T_decay_c = T_db^3;
else
    T_decay_n = T_s^3;  T_decay_m = T_s^4;  T_decay_c = T_s^3;
end

%% Quasi-steady separation point based on quasi-steady AoA - f
% Normal force
if abs(alpha_bar)<=alpha1_0n
    f_n = 1-(1-fb1_n)*exp((abs(alpha_bar)-alpha1_0n)/S1);
elseif alpha_bar>alpha1_0n && alpha_bar<alpha2_0n
    f_n = fb2_n+(fb1_n-fb2_n)*((alpha2_0n-alpha_bar)/(alpha2_0n-alpha1_0n))^S3;
else
    f_n = f0_n+(fb2_n-f0_n)*exp((alpha2_0n-abs(alpha_bar))/S2);
end
% Pitching moment
if abs(alpha_bar)<=alpha1_0m
    f_m = 1-(1-fb1_m)*exp((abs(alpha_bar)-alpha1_0m)/S1);
elseif alpha_bar>alpha1_0m && alpha_bar<alpha2_0m
    f_m = fb2_m+(fb1_m-fb2_m)*((alpha2_0m-alpha_bar)/(alpha2_0m-alpha1_0m))^S3;
else
    f_m = f0_m+(fb2_m-f0_m)*exp((alpha2_0m-abs(alpha_bar))/S2);
end
% Chordwise force
if abs(alpha_bar)<=alpha1_0c
    f_c = 1-(1-fb1_c)*exp((abs(alpha_bar)-alpha1_0c)/S1_c);
elseif alpha_bar>alpha1_0c && alpha_bar<alpha2_0c
    f_c = fb2_c+(fb1_c-fb2_c)*((alpha2_0c-alpha_bar)/(alpha2_0c-alpha1_0c))^S3_c;
else
    f_c = f0_c+(fb2_c-f0_c)*exp((alpha2_0c-abs(alpha_bar))/S2);
end

%% Separation points based on lagged AoA at downstroke's or stall in downstroke beginning
if downstroke_beginning || ~T_flag_downstroke
    fprime_n_db = fprime_n_i; 
    fprime_m_db = fprime_m_i; 
    fprime_c_db = fprime_c_i; 
end

%% Normal force unsteady lagged separation point based on lagged AoA - fprime_n
if abs(alpha_lag)<=alpha1_n                                 % First phase
    alpha_diff = abs(alpha_lag)-alpha1_n;
    if upstroke  
        S1_prime = S1*(1+beta_S1n_u*RD);      
        fprime_n = 1-(1-fb1_n)*exp(alpha_diff/S1_prime);
    else                
        S1_prime = S1*(1+beta_S1n_d*RD);       
        fprime_n = fprime_n_db*T_decay_n+(1-(1-fb1_n)*exp(alpha_diff/S1_prime))*(1-T_decay_n);
    end
elseif abs(alpha_lag)>alpha1_n && abs(alpha_lag)<alpha2_n   % Second phase
    alpha_diff = alpha2_n-abs(alpha_lag);
    if upstroke  
        S3_prime = S3*(1+beta_S3n_u*RD);      
        fprime_n = fb2_n+(fb1_n-fb2_n)*(alpha_diff/(alpha2_n-alpha1_n))^S3_prime;
    else
        S3_prime = S3*(1+beta_S3n_d*RD);   
        fb2_n = fb2_n*(1-R^(1/4));                                   % Reduce fb2 to allow greater drop in c_n during downstroke
        fprime_n = fprime_n_db*T_decay_n+(fb2_n+(fb1_n-fb2_n)*(alpha_diff/(alpha2_n-alpha1_n))^S3_prime)*(1-T_decay_n);
    end
else                                                        % Third phase
    alpha_diff = alpha2_n-abs(alpha_lag);
    if upstroke  
        S2_prime = S2*(1+beta_S2n_u*RD);      
        fprime_n = f0_n+(fb2_n-f0_n)*exp(alpha_diff/S2_prime);
    else  
        fb2_n = fb2_n*(1-R^(1/4));        
        if ~S && ~any(S3)   % Unstalled
            S1_prime = S1*(1+beta_S1n_d*RD);
            alpha_diff = alpha1_n-abs(alpha_lag);
            fprime_n = max([f0_n,fprime_n_db*T_decay_n+(1-(1-fb1_n)*exp(-alpha_diff/S1_prime))*(1-T_decay_n)]);
        else                % Stalled
            S2_prime = S2*(1+beta_S2n_d*RD);
            fprime_n = fprime_n_db*T_decay_n+(f0_n+(fb2_n-f0_n)*exp(alpha_diff/S2_prime))*(1-T_decay_n);
        end
    end
end

%% Pitching moment unsteady lagged separation point based on lagged AoA - fprime_m
if abs(alpha_lag)<=alpha1_m                                 % First phase
    alpha_diff = abs(alpha_lag)-alpha1_m;
    if upstroke  
        S1_prime = S1*(1+beta_S1m_u*RD);       
        fprime_m = 1-(1-fb1_m)*exp(alpha_diff/S1_prime);
    else                
        S1_prime = S1*(1+beta_S1m_d*RD);       
        fprime_m = fprime_m_db*T_decay_m+(1-(1-fb1_m)*exp(alpha_diff/S1_prime))*(1-T_decay_m);
    end
elseif abs(alpha_lag)>alpha1_m && abs(alpha_lag)<alpha2_m   % Second phase
    alpha_diff = alpha2_m-abs(alpha_lag);
    if upstroke  
        S3_prime = S3*(1+beta_S3m_u*RD);       
        fprime_m = fb2_m+(fb1_m-fb2_m)*(alpha_diff/(alpha2_m-alpha1_m))^S3_prime;
    else
        S3_prime = S3*(1+beta_S3m_d*RD);   
        fprime_m = fprime_m_db*T_decay_m+(fb2_m+(fb1_m-fb2_m)*(alpha_diff/(alpha2_m-alpha1_m))^S3_prime)*(1-T_decay_m);
    end
else                                                        % Third phase
    alpha_diff = alpha2_m-abs(alpha_lag);
    if upstroke  
        S2_prime = S2*(1+beta_S2m_u*RD);      
        fprime_m = f0_m+(fb2_m-f0_m)*exp(alpha_diff/S2_prime);
    else              
        if ~S && ~any(S3)   % Unstalled
            S1_prime = S1; 
            alpha_diff = alpha1_m-abs(alpha_lag);
            fprime_m = max([f0_m,fprime_m_db*T_decay_m+(1-(1-fb1_m)*exp(-alpha_diff/S1_prime))*(1-T_decay_m)]);
        else                % Stalled
            S2_prime = S2*(1+beta_S2m_d*RD);       
            fprime_m = fprime_m_db*T_decay_m+(f0_m+(fb2_m-f0_m)*exp(alpha_diff/S2_prime))*(1-T_decay_m); 
        end
    end
end

%% Chordwise force unsteady lagged separation point based on lagged AoA - fprime_c
if abs(alpha_lag)<=alpha1_c                                 % First phase
    alpha_diff = abs(alpha_lag)-alpha1_c;
    if upstroke  
        S1_prime = S1_c*(1+beta_S1c_u*RD);      
        fprime_c = 1-(1-fb1_c)*exp(alpha_diff/S1_prime);
    else
        S1_prime = S1_c*(1+beta_S1c_d*RD);   
        fprime_c = fprime_c_db*T_decay_c+(1-(1-fb1_c)*exp(alpha_diff/S1_prime))*(1-T_decay_c);
    end
elseif abs(alpha_lag)>alpha1_c && abs(alpha_lag)<alpha2_c   % Second phase
    alpha_diff = alpha2_c-abs(alpha_lag);
    if upstroke  
        S3_prime = S3_c*(1+beta_S3c_u*RD);       
        fprime_c = fb2_c+(fb1_c-fb2_c)*(alpha_diff/(alpha2_c-alpha1_c))^S3_prime;
    else
        S3_prime = S3_c*(1+beta_S3c_d*RD); 
        fb2_c = fb2_c*(1-R^(1/4));
        fprime_c = fprime_c_db*T_decay_c+(fb2_c+(fb1_c-fb2_c)*(alpha_diff/(alpha2_c-alpha1_c))^S3_prime)*(1-T_decay_c);
    end
else                                                        % Third phase
    alpha_diff = alpha2_c-abs(alpha_lag);
    if upstroke  
        S2_prime = S2*(1+beta_S2c_u*RD);
        fprime_c = f0_c+(fb2_c-f0_c)*exp(alpha_diff/S2_prime);
    else        
        fb2_c = fb2_c*(1-R^(1/4));      
        if ~S && ~any(S3)   % Unstalled
            S1_prime = S1*(1+beta_S1c_d*RD);
            alpha_diff = alpha1_c-abs(alpha_lag);
            fprime_c = max([f0_c,fprime_c_db*T_decay_c+(1-(1-fb1_c)*exp(-alpha_diff/S1_prime))*(1-T_decay_c)]);
        else                % Stalled
            S2_prime = S2*(1+beta_S2c_d*RD);
            fprime_c = fprime_c_db*T_decay_c+(f0_c+(fb2_c-f0_c)*exp(alpha_diff/S2_prime))*(1-T_decay_c);
        end
    end
end

end