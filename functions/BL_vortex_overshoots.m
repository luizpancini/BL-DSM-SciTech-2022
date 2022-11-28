function [cn_v,cm_v,cc_v] = BL_vortex_overshoots(tau_v,theta_tv0,f_diff_tv0,RD_tv0,Tv_tv0,f_diff_tv0_2,f_diff_tv0_3,nu_1,nu_2,nu_3,nu_4,g_v,Tv,chi_v,Vm,Vn1,Vn2)

%% First vortex
if tau_v <= 2*Tv_tv0 
    % Vortex strength
    B1 = Vn1*RD_tv0^nu_1*f_diff_tv0^nu_2*(Tv/Tv_tv0)^nu_3; 
    % Vortex shape function 
    if tau_v/Tv_tv0 <= 1/chi_v
        Vx_n = sin(pi/2*tau_v/Tv_tv0*chi_v)^(nu_4/chi_v); 
    else
        Vx_n = sin(pi/2*(1+(chi_v/(2*chi_v-1))*(tau_v/Tv_tv0-1/chi_v)))^(nu_4*chi_v);
    end
    % Airloads' coefficients
    cn_v1 = B1*Vx_n*sign(theta_tv0);
    cm_v1 = -Vm*cn_v1; 
else
    cn_v1 = 0;
    cm_v1 = 0;
end

%% Second vortex
if tau_v > (2+g_v)*Tv_tv0 && tau_v <= (4+g_v)*Tv_tv0 && f_diff_tv0_2 > 0.02
    % Vortex strength
    B2 = Vn2*RD_tv0^(2*nu_1)*f_diff_tv0^(2*nu_2)*(Tv/Tv_tv0)^nu_3; 
    % Vortex shape function 
    Vx_n2 = (1-cos(pi*(tau_v-(2+g_v)*Tv_tv0)/Tv_tv0))/2; 
    % Airloads' coefficients
    cn_v2 = B2*Vx_n2*sign(theta_tv0);
    cm_v2 = -Vm*cn_v2; 
else
    cn_v2 = 0;
    cm_v2 = 0;
end

%% Third vortex
if tau_v > (4+3/2*g_v)*Tv_tv0 && tau_v <= (6+3/2*g_v)*Tv_tv0 && f_diff_tv0_2 > 0.02 && f_diff_tv0_3 > 0
    % Vortex strength
    B3 = 3/4*Vn2*RD_tv0^(2*nu_1)*f_diff_tv0^(2*nu_2)*(Tv/Tv_tv0)^nu_3; 
    % Vortex shape function 
    Vx_n3 = (1-cos(pi*(tau_v-(4+3/2*g_v)*Tv_tv0)/Tv_tv0))/2; 
    % Airloads' coefficients
    cn_v3 = B3*Vx_n3*sign(theta_tv0);
    cm_v3 = -Vm*cn_v3; 
else
    cn_v3 = 0;
    cm_v3 = 0;
end

%% Total vortices' contributions
cn_v = cn_v1+cn_v2+cn_v3;
cm_v = cm_v1+cm_v2+cm_v3;
cc_v = 0;

end