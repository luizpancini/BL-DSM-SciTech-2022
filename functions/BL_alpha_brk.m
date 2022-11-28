function [alpha1_n,alpha1_m,alpha1_c,alpha2_n,alpha2_m,alpha2_c,dalpha_n,dalpha_m,dalpha_c,dalpha_db] = BL_alpha_brk(qR,R,RD_theta,S,upstroke,downstroke_beginning,dalpha_n_i,dalpha_db,alpha1_0n,alpha1_0m,alpha1_0c,alpha2_0n,alpha2_0m,alpha2_0c,delta_alpha_0,delta_alpha_1,delta_alpha_u,d_cm,d_cc,z_cm,z_cc)
    
%% Breakpoint angle offsets
if upstroke 
    R_upstroke = RD_theta;                                  
    dalpha_n = delta_alpha_u*R_upstroke;                                       
    dalpha_m = (delta_alpha_u+d_cm)*R_upstroke;                                         
    dalpha_c = (delta_alpha_u+d_cc)*R_upstroke;                                          
else 
    if downstroke_beginning, dalpha_db = dalpha_n_i; end  % To promote continuity
    dalpha_n = -S*(delta_alpha_0+delta_alpha_1*qR);                
    dalpha_m = dalpha_n*(1-z_cm*R^(1/2));                                
    dalpha_c = dalpha_n*(1-z_cc*R^(1/2));      
end

%% Unsteady breakpoint of separation angles
alpha1_n = alpha1_0n+dalpha_n; 
alpha1_m = alpha1_0m+dalpha_m;
alpha1_c = alpha1_0c+dalpha_c;
alpha2_n = alpha2_0n+dalpha_n; 
alpha2_m = alpha2_0m+dalpha_m; 
alpha2_c = alpha2_0c+dalpha_c; 

end